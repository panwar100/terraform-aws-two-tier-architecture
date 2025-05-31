# Terraform AWS Two-Tier Architecture with Custom Domain

> Customized from [10WeeksOfCloudOps_Task3](https://github.com/piyushsachdeva/10WeeksOfCloudOps_Task3)

## 📌 Overview

This Terraform project sets up a complete two-tier architecture on AWS using:

- **VPC**
- **Public & Private Subnets**
- **EC2 instances**
- **Application Load Balancer (ALB)**
- **CloudFront Distribution**
- **ACM SSL Certificate**
- **Route 53 DNS**
- **Custom Domain Integration** (`yourcreativecorner.xyz`)

## 🛠️ Custom Features Added

- Integrated a **custom domain** via Route 53 and ACM
- Added **SSL support** using AWS Certificate Manager (ACM)
- Configured **CloudFront** as the CDN layer in front of ALB
- DNS routing using **Route 53 alias records** for `yourcreativecorner.xyz` and `www.yourcreativecorner.xyz`
- Enabled **Geo-restriction** (US, IN, CA)

## 🧱 Project Structure

terraform-aws-two-tier-architecture-custom/
│
├── modules/
│ ├── vpc/
│ ├── ec2/
│ ├── alb/
│ ├── rds/
│ ├── cloudfront/
│ └── route53/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── README.md

csharp
Copy
Edit

## 🚀 How to Use

```bash
# Initialize
terraform init

# Preview plan
terraform plan

# Apply infrastructure
terraform apply
🧾 Notes
Make sure your domain is hosted in Route 53 and ACM certificate is issued and validated in the us-east-1 region for CloudFront.

You can update the terraform.tfvars to match your domain and ALB values.

🙏 Credits
This project is based on 10WeeksOfCloudOps Task 3 by Piyush Sachdeva.

