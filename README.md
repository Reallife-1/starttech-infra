# StartTech Infrastructure

Terraform for the AWS side of the StartTech assessment — EKS, networking, storage, CDN, and caching, all provisioned as code.

## What's in here

Five modules, wired together from the root config.

**networking** builds the VPC (10.0.0.0/16) with 2 public and 2 private subnets across two AZs, one NAT Gateway, an Internet Gateway, and the route tables to tie it together. Public subnets carry the `kubernetes.io/role/elb` tag and private subnets carry `kubernetes.io/role/internal-elb`, which is what lets the AWS Load Balancer Controller find them automatically later.

**eks** stands up the cluster itself — `starttech-cluster`, running 1.34 — with a managed node group (`starttech-node-group`, two t3.medium instances) and IAM roles scoped to what the control plane and nodes actually need.

**storage** creates a private S3 bucket for the frontend build (`starttech-frontend-bucket-<random>`, public access fully blocked) and an ECR repo (`starttech-backend-api`) for backend images.

**database** is a single-node Redis cluster via ElastiCache (`starttech-redis`, cache.t3.micro), sitting in private subnets with a security group that only allows traffic from EKS worker nodes.

**cdn** is the part doing the most work: one CloudFront distribution acting as a reverse proxy in front of both S3 and the backend ALB. S3 goes through Origin Access Control under the origin ID `S3-Frontend`; the ALB sits behind `ALB-Backend`. Default behavior serves the React build and forces HTTPS. Anything hitting `/api/*` skips caching entirely and forwards every header, cookie, and query string through to the backend. 403s and 404s both redirect to `/index.html` with a 200, which is what makes client-side routing survive a page refresh.

## Before you run this

- Terraform >= 1.5.0
- AWS CLI configured with enough permissions to create everything above
- EKS 1.34 available in your target region (confirmed available in us-east-1)

## Running it

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# defaults target us-east-1, edit if you need something else

terraform init
terraform plan
terraform apply
```

Or just run the script, which does fmt, validate, plan, and apply in order:

```bash
./scripts/deploy-infrastructure.sh
```

## On cost

This stack isn't left running between sessions — EKS control plane, NAT Gateway, node group, ALB, and Redis all cost money sitting idle, so everything gets torn down at the end of a working session and rebuilt at the start of the next.

Order matters on teardown once a Kubernetes Ingress exists (from the `starttech-application` repo). Delete the Ingress and Service first, wait until the ALB is actually gone from the AWS Console, then destroy. Skip that step and the VPC destroy will hang — a leftover ALB security group still attached to a subnet will block it.

```bash
kubectl delete ingress backend-ingress
kubectl delete service backend-api-service
# confirm it's gone:
# aws elbv2 describe-load-balancers --region us-east-1
terraform destroy
```

## Outputs

`terraform output` after a successful apply gets you the VPC ID, EKS endpoint, ECR URL, S3 bucket name, CloudFront domain, and Redis endpoint.

## The other half

Application code, Kubernetes manifests, and CI/CD live in [`starttech-application`](https://github.com/Reallife-1/starttech-application).