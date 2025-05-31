# 🌐Terraform AWS Two-Tier Architecture
✨This repository is created to learn and deploy a 2-tier application on aws cloud through Terraform.

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


## 🌍 Prerequisites

- AWS Account with access to Route 53, EC2, ACM, CloudFront

- Registered domain (yourcreativecorner.xyz)

- Terraform CLI installed (v1.4+ recommended)

- Public hosted zone created in Route 53

## 🧭 Architecture Diagram

![image](https://github.com/user-attachments/assets/50d335ab-08a1-4c0b-ba4d-b8af123d44f5)

- #### [Image Source: Ankit Jodhan](https://github.com/AnkitJodhani/3rdWeekofCloudOps/blob/main/architecture.gif)

## ⚙️ Setup & Usage

### 1. Clone the Repository
```bash
git clone https://github.com/panwar100/two-tier-web-architecture.git
cd terraform_2tier
```

### 2. 🖥️ Installation of Terraform
Note: Follow the blog for the step-by-step instructions to build this project. [Terraform](https://ankitjodhani.hashnode.dev/implementing-two-tier-architecture-in-aws-with-terraform-step-by-step-guide-10weeksofcloudops)

### 3. Create S3 Backend Bucket
Create an S3 bucket to store the .tfstate file in the remote backend

![Screenshot 2025-05-31 163327](https://github.com/user-attachments/assets/1b47b91c-1c00-46a9-befc-cd6c3ccea629)

**Warning!** It is highly recommended that you enable Bucket Versioning on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.

**Note:** We will need this bucket name in the later step

### 4. Create a Dynamo DB table for state file locking

![Screenshot 2025-05-31 163250](https://github.com/user-attachments/assets/0ed348aa-df2d-4d7e-8307-66e4d018430d)

- Give the table a name
- Make sure to add a Partition key with the name LockID and type as String

### 5. Generate a public-private key pair for our instances
We need a public key and a private key for our server so please follow the procedure I've included below.
```
cd modules/key/
ssh-keygen
```
The above command asks for the key name and then gives `client_key` it will create a pair of keys one public and one private. you can give any name you want but then you need to edit the Terraform file

![Screenshot 2025-06-01 002626](https://github.com/user-attachments/assets/725c411f-3a29-4575-9535-d6946c8ec44f)

Edit the below file according to your configuration
```
vim root/backend.tf
```

Add the below code in root/backend.tf
```
terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    key    = "backend/FILE_NAME_TO_STORE_STATE.tfstate"
    region = "us-east-1"
    use_lockfile  = true
  }
}
```

### 6. 👨‍💻 Route 53 Hosted Zone
Go to AWS Console --> Route53 --> Hosted Zones and ensure you have a public hosted zone available, if not create one.

![Screenshot 2025-05-31 182155](https://github.com/user-attachments/assets/7f6da816-cbba-4896-817b-66ed35a3b59d)

### 7. 🔐 ACM certificate
Go to AWS console --> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status, if not, feel free to create one and use the domain name on which you are planning to host your application.

![Screenshot 2025-05-31 182018](https://github.com/user-attachments/assets/346c84e2-67da-4bc3-9066-de94bce4cfaf)

click on `create records in Route53`

![Screenshot 2025-05-31 182055](https://github.com/user-attachments/assets/31d49be6-5dda-4a5a-8c40-415e5650d094)

### 8. 🏠 Let's set up the variable for our Infrastructure
Create one file with the name terraform.tfvars
```
vim root/terraform.tfvars
```
Add the below content into the root/terraform.tfvars file and add the values of each variable.
```
region = ""
project_name = ""
vpc_cidr                = ""
pub_sub_1a_cidr        = ""
pub_sub_2b_cidr        = ""
pri_sub_3a_cidr        = ""
pri_sub_4b_cidr        = ""
pri_sub_5a_cidr        = ""
pri_sub_6b_cidr        = ""
db_username = ""
db_password = ""
certificate_domain_name = ""
additional_domain_name = ""
```
![Screenshot 2025-06-01 010526](https://github.com/user-attachments/assets/6673487f-f03c-4378-bc21-3ad134e7c747)

### 9. ✈️ Now we are ready to deploy our application on the cloud ⛅

get into the project directory
```
cd root
```
👉 let deploy the application

```bash
# Initialize
terraform init
```
```
# Preview plan
terraform plan
```
```
# Apply infrastructure
terraform apply
```
Type `yes`, and it will prompt you for approval..

![Screenshot 2025-06-01 010628](https://github.com/user-attachments/assets/ac1c749d-1bab-44ac-9317-c9120465cc26)

## 🧪 Verification

After ~10 minutes post-deployment:

✅ https://yourcreativecorner.xyz

![Screenshot 2025-05-31 175834](https://github.com/user-attachments/assets/78446359-6e4c-41d5-94ba-4fcda8ebd2eb)

✅ https://www.yourcreativecorner.xyz

![Screenshot 2025-05-31 190300](https://github.com/user-attachments/assets/4d69a055-4b1e-40c4-84d7-ccde6ed5c164)

If it doesn't load immediately, wait for CloudFront & DNS propagation.

## 🖥️ Outputs
let's see what Terraform created on our AWS console.

### Cloudfront Records in Route53

![Screenshot 2025-05-31 194314](https://github.com/user-attachments/assets/3df44fee-11b5-41bf-812e-4343a3a3e419)

### VPC

![Screenshot 2025-05-31 194613](https://github.com/user-attachments/assets/853c7f33-84e0-48dc-8662-f07860f39741)

### Subnet

![Screenshot 2025-05-31 202542](https://github.com/user-attachments/assets/cc0f9da9-b166-43b5-ac79-bc36be2eec4e)

### Route Tables

![Screenshot 2025-05-31 202620](https://github.com/user-attachments/assets/6ca6ca01-5950-451c-8e38-97fd24a47609)

### Internet Getways

![Screenshot 2025-05-31 202632](https://github.com/user-attachments/assets/014372d5-ba1e-4faf-9a2f-806b1958da5c)

### NAT gateways
![Screenshot 2025-05-31 202653](https://github.com/user-attachments/assets/8226d61a-342f-4893-bbd0-3727a06426e9)

### Security Groups
![Screenshot 2025-05-31 202739](https://github.com/user-attachments/assets/a22c62e3-328e-4edd-8222-f1dcb61d1ac8)

### Ec2 instance
![Screenshot 2025-05-31 194707](https://github.com/user-attachments/assets/324719ae-f55b-4461-9ec8-014486c0ef27)

### Load Balancer
![Screenshot 2025-05-31 194809](https://github.com/user-attachments/assets/74a89383-814e-42a9-991a-1aabc46a3cb3)

### Auto Scaling Group
![Screenshot 2025-05-31 194825](https://github.com/user-attachments/assets/17ed4045-4136-44ab-bbe1-5dac442a5d91)

## 🧾 Notes
- Make sure your domain is hosted in Route 53 and ACM certificate is issued and validated in the us-east-1 region for CloudFront.
- Bad Gateway or SSL errors may occur temporarily during propagation.
- You can update the terraform.tfvars to match your domain and ALB values.

## 🧼 Cleanup
```
terraform destroy
```
Type `yes`, and it will prompt you for approval..

## 🙏 Credits
This project is based on 10WeeksOfCloudOps Task 3 by [Piyush Sachdeva](https://github.com/piyushsachdeva/10WeeksOfCloudOps_Task3)
