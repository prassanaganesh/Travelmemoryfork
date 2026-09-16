# Travel Memory

`.env` file to work with the backend after creating a database in mongodb: 

```
MONGO_URI='ENTER_YOUR_URL'
PORT=3001
```

Data format to be added: 

```json
{
    "tripName": "Incredible India",
    "startDateOfJourney": "19-03-2022",
    "endDateOfJourney": "27-03-2022",
    "nameOfHotels":"Hotel Namaste, Backpackers Club",
    "placesVisited":"Delhi, Kolkata, Chennai, Mumbai",
    "totalCost": 800000,
    "tripType": "leisure",
    "experience": "Lorem Ipsum, Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum, ",
    "image": "https://t3.ftcdn.net/jpg/03/04/85/26/360_F_304852693_nSOn9KvUgafgvZ6wM0CNaULYUa7xXBkA.jpg",
    "shortDescription":"India is a wonderful country with rich culture and good people.",
    "featured": true
}
```


For frontend, you need to create `.env` file and put the following content (remember to change it based on your requirements):
```bash
REACT_APP_BACKEND_URL=http://localhost:3001
```

## How to run BE

Note: Make sure you have the .env file already added
```bash
cd backend
npm install
node index.js
```

## How to run FE
Note: Make sure you have the .env file already added
```bash
cd frontend
npm install
npm start
```


# TravelMemory MERN Application - AWS Deployment using Terraform & Ansible

## 📌 Project Overview

This project demonstrates the deployment of a **MERN (MongoDB, Express.js, React, Node.js) application** on AWS using:

- Terraform for Infrastructure as Code
- Ansible for configuration management and application deployment
- Amazon VPC for network isolation
- Amazon EC2 for application and database servers
- MongoDB for database services
- Nginx for frontend hosting and reverse proxy
- systemd for backend process management
- AWS Security Groups for network security
- UFW for host-level firewall protection
- AWS IAM for EC2 permissions
- NAT Gateway for private subnet outbound internet access

Application:

**TravelMemory**

Source repository:

https://github.com/UnpredictablePrashant/TravelMemory

---

# 🏗️ Architecture

```text
                              INTERNET
                                  |
                                  |
                         Internet Gateway
                                  |
                    +-------------+-------------+
                    |       PUBLIC SUBNET       |
                    |        10.0.1.0/24        |
                    |                           |
                    |       Web EC2             |
                    |       Ubuntu 24.04         |
                    |                           |
                    |       Nginx :80           |
                    |       React Frontend      |
                    |       Node.js :3001       |
                    |                           |
                    +-------------+-------------+
                                  |
                                  | TCP 27017
                                  | Private Network
                                  |
                    +-------------v-------------+
                    |      PRIVATE SUBNET       |
                    |       10.0.2.0/24         |
                    |                           |
                    |       Database EC2        |
                    |       Ubuntu 24.04        |
                    |                           |
                    |       MongoDB :27017      |
                    |       No Public IP        |
                    |                           |
                    +-------------+-------------+
                                  |
                                  |
                            NAT Gateway
                                  |
                            Internet Gateway
                                  |
                              INTERNET

🔐 SSH / Ansible Architecture
    -The database server does not have a public IP.
    -Ansible accesses it through the Web EC2

                    Local WSL
                       |
                       | SSH
                       |
                       v
                 +-----------+
                 | Web EC2   |
                 | Public IP |
                 | Bastion   |
                 +-----+-----+
                       |
                       | SSH ProxyCommand
                       |
                       v
                 +-----------+
                 | DB EC2    |
                 | Private IP|
                 +-----------+

Project Structure:

TravelMemory-Terraform-Ansible/
│
├── terraform/
│   ├── versions.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── vpc.tf
│   ├── security-groups.tf
│   ├── iam.tf
│   ├── ec2.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.ini
│   ├── site.yml
│   ├── database.yml
│   ├── web.yml
│   │
│   └── templates/
│       ├── backend.env.j2
│       ├── frontend.env.j2
│       ├── travelmemory.service.j2
│       └── nginx-travelmemory.j2
│
├── screenshots/
│
├── README.md
│
└── .gitignore






Prerequisites:

Two EC2 instances were created.
|
└──Web Server
│   Name: travelmemory-web-server
│   Subnet: Public
│   Public IP: Enabled
│   Instance Type: t3.micro
│   OS: Ubuntu 24.04
|
└── Database Server
    Name: travelmemory-database-server
    Subnet: Private
    Public IP: Disabled
    Instance Type: t3.micro
    OS: Ubuntu 24.04

📦 Terraform

```
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
```

provider.tf
```
Configures: AWS Provider / Region/
```
variables.tf
```
Configures:

AWS Region
Project Name
VPC CIDR
Public Subnet CIDR
Private Subnet CIDR
EC2 Instance Type
User Public IP
SSH Public Key
```
vpc.tf
```
Creates:
VPC
Public Subnet
Private Subnet
Internet Gateway
Elastic IP
NAT Gateway
Public Route Table
Private Route Table
Route Associations
```
security-groups.tf
```
Creates:
Web Security Group
Database Security Group
```
iam.tf
```
Creates:
IAM Role
IAM Policy Attachment
EC2 Instance Profile
```
```
ec2.tf
Creates:
Web EC2
Database EC2
AWS Key Pair
```

outputs.tf
```
Provides:
Web Public IP
Web Public DNS
Database Private IP
Application URL
SSH Command
```


Default Tags
```bash

aws --version
terraform --version
ansible --version
```

<img width="1315" height="385" alt="image" src="https://github.com/user-attachments/assets/d9f39695-e8ca-4a57-af99-dc19dff99206" />

🚀 Terraform Deployment:
Navigate to:
```bash
cd ~/TravelMemory-Terraform-Ansible/terraform
```
Check Terraform Version
```bash
terraform --version
```
Format Terraform
```bash
terraform fmt
```
Initialize Terraform
```
```bash
terraform init
```
Validate Configuration
```bash
terraform validate
```

Terraform Initialization

<img width="1005" height="657" alt="image" src="https://github.com/user-attachments/assets/e1900d19-ff08-4161-8722-71c388c7a580" />

Validate:
<img width="1526" height="826" alt="image" src="https://github.com/user-attachments/assets/9a2067e8-ff91-4fa7-8dbf-e5841e176c5f" />

Create Terraform Plan :
```bash
terraform plan
```

<img width="917" height="436" alt="image" src="https://github.com/user-attachments/assets/c5554aba-390d-4305-911a-d5f2c95585dc" />
Terraform Apply:
```bash
terraform apply
```
<img width="1307" height="862" alt="image" src="https://github.com/user-attachments/assets/31f5d476-69a2-467f-91b3-44a9707b586d" />

Verify AWS resources:
<img width="1035" height="472" alt="image" src="https://github.com/user-attachments/assets/239958c3-e1c7-4404-8b45-4f899c60cbfa" />

VPC: 

<img width="1902" height="977" alt="image" src="https://github.com/user-attachments/assets/f09eb151-7f54-4ed8-8de1-b794ab0a317d" />

Subnets:
<img width="1911" height="515" alt="image" src="https://github.com/user-attachments/assets/4627a062-9f14-482f-957c-76b7bcd7a8d8" />

NAT:
<img width="1910" height="645" alt="image" src="https://github.com/user-attachments/assets/0f58f8f7-48dc-4ba2-aabf-a7b769dcf5e4" />

EC2 Instance:

<img width="1907" height="727" alt="image" src="https://github.com/user-attachments/assets/d1950b19-7934-45a9-a85b-9f013572f998" />



🤖 Ansible
Ansible is used after Terraform creates the infrastructure.

Ansible configures:
```
Web EC2
Database EC2
MongoDB
Node.js
Nginx
TravelMemory
systemd
UFW
Environment variables
```
Ansible Configuration:
```
[defaults]
inventory = inventory.ini
host_key_checking = False
retry_files_enabled = False
interpreter_python = auto_silent
timeout = 30
```
Ansible Inventory

    -The inventory contains:
    -The database server is accessed using the Web EC2 as a bastion.
```
webserver

[web]
webserver ansible_host=<13.220.10.86> ansible_user=ubuntu

dbserver
[database]
dbserver ansible_host=<10.0.2.146> ansible_user=ubuntu
```

Ansible Connectivity Testing    

Web server:
```bash
ansible web -m ping
```
Database:

```bash
ansible database -m ping
```

Test web-server communication & private database server:

<img width="1492" height="446" alt="image" src="https://github.com/user-attachments/assets/2332b30f-076a-4895-9c9b-c7c0cd440e95" />

MongoDB Deployment

MongoDB Ansible playbook:

<img width="990" height="860" alt="image" src="https://github.com/user-attachments/assets/7325a418-5a68-498e-94df-2bcf7ca5d090" />

Verify MongoDB connection

<img width="1467" height="202" alt="image" src="https://github.com/user-attachments/assets/1268051b-808e-44ab-87f5-cb220e0a3b6e" />






Ansible Vault for passwords
<img width="1476" height="265" alt="image" src="https://github.com/user-attachments/assets/1d891635-8f8d-4308-ae64-1666d92b97bc" />


Application Deployment

The TravelMemory repository is cloned to:

/opt/TravelMemory

Structure:

/opt/TravelMemory/
├── backend/
└── frontend/
⚙️ Backend Configuration

Backend environment file:

/opt/TravelMemory/backend/.env

Example:
```
MONGO_URI=mongodb://<APP_USER>:<**************>@<10.0.2.146>:27017/travelmemory?authSource=travelmemory
PORT=3001
```

⚛️ Frontend Configuration

Frontend environment file:

/opt/TravelMemory/frontend/.env

Ansible template:

ansible/templates/frontend.env.j2

Contents:

REACT_APP_BACKEND_URL=http://{{ web_public_ip }}

The frontend is built using:
```
cd /opt/TravelMemory/frontend
npm install
npm run build
```
Frontend

Open:

http://13.220.10.86

in a browser.

<img width="1912" height="1005" alt="image" src="https://github.com/user-attachments/assets/8bde758f-d040-421b-91b0-61e431c2109e" />
<img width="1897" height="1015" alt="image" src="https://github.com/user-attachments/assets/c033c952-2de8-4e88-b94c-74d86ef2b20a" />

🔍 Troubleshooting Performed
Issue 1 - MongoDB Authentication

Error:

Command createUser requires authentication

Cause:

MongoDB authentication was already enabled.

Resolution:

Temporarily disable authentication
        ↓
Restart MongoDB
        ↓
Verify access
        ↓
Create/verify users
        ↓
Re-enable authentication
Issue 2 - Ansible Database SSH Timeout

Ansible returned:

Connection to UNKNOWN port 65535 timed out

This indicated a failure in the SSH connection through the bastion / ProxyCommand.

The Web EC2 was tested separately.

Issue 3 - Web EC2 SSH Timeout

Direct SSH:

```bash
ssh -i ~/.ssh/travelmemory-key ubuntu@$(terraform output -raw web_public_ip)
```
returned:

```bash
ssh: connect to host 13.220.10.86 port 22: Connection timed out
```
This confirmed that the problem was not initially Ansible itself.

Issue 4 - Public IP Verification

The local public IP was checked using:
```bash
curl -4 ifconfig.me
```
At the time of troubleshooting:

49.37.223.173

Terraform configuration contained:

my_ip = "49.37.223.173/32"

Therefore the configured Terraform SSH source IP matched the detected public IP at that point.

Issue 5 - AWS CLI RequestExpired

AWS CLI subsequently returned:

RequestExpired

Example:

An error occurred (RequestExpired) when calling the DescribeSecurityGroups operation:
Request has expired.

This pointed to a local system clock / request timestamp synchronization issue.

Checks used:
```bash
date
date -u
aws sts get-caller-identity
```
Windows time verification:
```bash
Get-Date
w32tm /query /status
```
Windows time synchronization:

w32tm /resync

WSL restart:

wsl --shutdown

After synchronization, AWS CLI was verified using:

```bash
aws sts get-caller-identity
```
