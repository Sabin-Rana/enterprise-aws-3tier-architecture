# ENTERPRISE AWS 3-TIER ARCHITECTURE - COMPLETE DOCUMENTATION

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/sabinrana/enterprise-aws-3tier-architecture)
[![Terraform](https://img.shields.io/badge/Terraform-1.0+-purple?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)](https://aws.amazon.com/)

## Architecture Diagram
![AWS 3-Tier Architecture](./docs/architecture-diagram/aws-3tier-architecture-diagram.png)

*Complete 57-resource AWS infrastructure with safety-first validation approach*

---

## Project Highlights

### Terraform Validation Success
![Terraform Validation](./docs/screenshots-organized/readme-showcase/01-terraform-validate.png)
*Terraform configuration successfully validated across all 6 modules*

### Infrastructure Planning
![Terraform Resources](./docs/screenshots-organized/readme-showcase/02-terraform-resources.png)
*57 AWS resources planned and validated without deployment costs*

### Backend Application
![Backend Running](./docs/screenshots-organized/readme-showcase/03-backend-running.png)
*Node.js API server running successfully with comprehensive error handling - gracefully manages database connection failures as expected in validation environment*

### Frontend Application
![Frontend Build](./docs/screenshots-organized/readme-showcase/04-frontend-build.png)
*React application built successfully with modern tooling and testing*

### Docker Containerization
![Docker Images](./docs/screenshots-organized/readme-showcase/05-docker-images.png)
*Both frontend and backend Docker images built and verified for production*

### CI/CD Pipeline
![CI/CD Success](./docs/screenshots-organized/readme-showcase/06-cicd-success.png)
*Safe validation workflows executing successfully with manual trigger safety*

### Cost Management Verification
![Zero Cost Proof](./docs/screenshots-organized/readme-showcase/07-zero-cost-proof.png)
*Comprehensive cost validation confirming zero AWS resources and billing compliance*

---

## Executive Summary

[![AWS Certified Solutions Architect](https://img.shields.io/badge/AWS-Certified%20Solutions%20Architect%20Associate-orange?logo=amazon-aws)](https://www.credly.com/badges/080be029-2747-438f-82cc-5f403008e2fa)

A comprehensive enterprise-grade cloud infrastructure project demonstrating professional DevOps practices with zero-cost validation strategy. This project designs, validates, and documents 57 AWS resources across 6 Terraform modules while maintaining absolute cost control through safety-first workflow design and comprehensive automation.

### Key Achievements

- **57 AWS Resources** designed and validated
- **6 Terraform Modules** with production-ready configuration  
- **Zero-Cost Validation** - Everything validated, nothing deployed
- **Safety-First CI/CD** - 2 active workflows, 3 disabled for safety
- **Full-Stack Applications** - Node.js + React with comprehensive testing
- **7 Safety Scripts** for cost management and emergency protocols

---

---

## The Story Behind This Architecture

### From $10 Scare to Zero-Cost Mastery

This project represents a fundamental shift in cloud engineering mindset, born from a critical lesson in cost management that transformed my approach to infrastructure design.

**[Read the Full Journey: "From $10 Scare to Zero-Cost Mastery: My AWS 3-Tier Architecture Journey"](https://sabin-codeops.hashnode.dev/from-10-scare-to-zero-cost-mastery-my-aws-3-tier-architecture-journey)**

#### The Learning Foundation
- **[Terraform Automation Journey](https://github.com/Sabin-Rana/terraform-learning-journey)** - Structured learning path with comprehensive hands-on labs
- **[Manual AWS 3-Tier Implementation](https://github.com/Sabin-Rana/aws-3tier-architecture)** - Foundational architecture built through AWS console
- **Enterprise Automation** - This project: 57 resources across 6 Terraform modules

#### The Evolution Path
**Manual Console Operations → Infrastructure as Code Foundation → Enterprise-Grade Automation**

#### Key Insights from the Journey
- **Financial responsibility in cloud engineering** - Treating every dollar as critical infrastructure cost
- **Progressive skill development** - Building from manual operations to automated enterprise solutions
- **Deep understanding before automation** - Mastering AWS services manually before implementing Infrastructure as Code
- **Safety-first infrastructure** - 7 automation scripts for cost control and emergency protocols
- **Comprehensive documentation** - Architecture diagrams and troubleshooting journeys that tell complete stories
- **Real-world problem solving** - 62+ documented challenges and solutions from hands-on experience

This project demonstrates that professional cloud engineering combines technical expertise with financial responsibility, creating solutions that are both powerful and cost-aware.

---


## Complete Architecture Breakdown

### Networking Foundation (VPC Module)

- **VPC** (10.0.0.0/16) with DNS support and multi-AZ deployment
- **Internet Gateway** for public subnet internet access
- **NAT Gateways** with Elastic IPs for private subnet outbound traffic
- **Public Subnets** (10.0.1.0/24, 10.0.2.0/24) for web tier resources
- **Private App Subnets** (10.0.3.0/24, 10.0.4.0/24) for application tier
- **Private DB Subnets** (10.0.5.0/24, 10.0.6.0/24) for database tier
- **Route Tables** and associations for proper traffic routing

### Security Layer (Security Module)

- **Security Groups** with dynamic ingress/egress rules
- **Web Tier Security Group** - Ports 80/443 for HTTP/HTTPS traffic
- **App Tier Security Group** - Port 4000 for application traffic
- **DB Tier Security Group** - Port 5432 for PostgreSQL database
- **Network segmentation** between public and private subnets

### Compute Layer (Compute Module)

- **EC2 Launch Templates** with Amazon Linux 2 AMI and t2.micro instances
- **Auto Scaling Groups** for web and application tiers
- **Web Tier ASG** - Minimum 2, Maximum 4 instances
- **App Tier ASG** - Minimum 2, Maximum 4 instances
- **IAM Instance Profiles** for Systems Manager access
- **Health monitoring** and load balancer integration

### Load Balancing (Load Balancing Module)

- **Application Load Balancer** with HTTP listeners on port 80
- **Target Groups** with health checks on /health endpoint
- **Listeners** for traffic routing and distribution
- **Health check configuration** with 30-second intervals
- **Traffic distribution** across multiple availability zones

### Database Layer (Database Module)

- **RDS PostgreSQL** (Version 14.9) with multi-AZ deployment
- **DB Subnet Group** for isolated database network placement
- **Encrypted storage** with automated backups (7-day retention)
- **Performance Insights** enabled for database monitoring
- **Parameter groups** and maintenance window configuration

### Monitoring & Observability (Monitoring Module)

- **CloudWatch Dashboard** with 4 comprehensive widgets:
  - EC2 CPU Utilization (Web & App Tiers)
  - ALB Health & Request Metrics
  - RDS Performance Metrics
  - Auto Scaling Group Instances
- **SNS Topics** for alert notifications
- **CloudWatch Alarms** for:
  - High CPU utilization (Web/App tiers >80%)
  - Database performance issues (>75% CPU)
  - ALB 5XX errors (>10 errors threshold)

---

## Safety-First Implementation

### CI/CD Pipeline Strategy

#### ACTIVE WORKFLOWS (Safe Validation)

- **Terraform Validation:** Syntax checking, configuration validation, planning only
- **Security Scanning:** npm audit, Gitleaks, code quality with continue-on-error

#### DISABLED WORKFLOWS (Safety Measure)

- **Backend Deployment:** EC2 deployment and application installation
- **Frontend Deployment:** S3 sync and CloudFront invalidation
- **Terraform Apply:** AWS resource creation and state modification

### 7 Safety & Automation Scripts

- `comprehensive-cost-check.sh` - Detailed AWS cost auditing
- `cost-checker.sh` - Quick cost assessment
- `emergency-nuke-all.sh` - Complete infrastructure termination
- `pre-deploy-check.sh` - Pre-deployment validation
- `post-deploy-check.sh` - Post-deployment verification
- `quick-cost-check.sh` - Rapid cost estimation
- `safety-destroy.sh` - Safe infrastructure teardown

### Zero-Cost Validation Approach

- **Terraform Planning Only:** terraform plan executed, terraform apply disabled
- **Backend Validation:** Application builds and tests without EC2 deployment
- **Frontend Validation:** React build process without S3 sync
- **Safety Protocols:** Manual triggers, disabled automatic deployments
- **Cost Guarantee:** Zero AWS resources created, only configuration validation

---

## Validation Evidence & Log Reports

### Complete Documentation Available
All validation evidence and log reports are available in the project's documentation:

[**View Complete Log Reports on GitHub**](https://github.com/Sabin-Rana/enterprise-aws-3tier-architecture/tree/main/docs/logs-reports)

### Evidence Includes:
- **5 Complete Terraform Plans** - Full validation cycles showing 57-resource infrastructure
- **Resource Count Tracking** - Documentation confirming all AWS resources planned
- **Error Resolution Logs** - Professional handling of validation challenges
- **Application Logs** - Backend and frontend validation with error handling
- **Cost Audit Reports** - Zero-cost verification through safety scripts

### Zero-Cost Verification
All validation performed through Terraform planning only - no AWS resources created, ensuring complete cost control while demonstrating full infrastructure capability.

---

## Troubleshooting Journey

### Phase 1: VPC Networking Challenges

**Problem:** Availability zone configuration errors blocked VPC creation

![AZ Errors](./docs/screenshots-organized/troubleshooting-journey/phase1-vpc-networking/01-problem-az-errors.png)  
*Initial availability zone conflicts preventing subnet deployment*

**Solution:** Corrected AZ mappings and subnet CIDR allocations

![VPC Success](./docs/screenshots-organized/troubleshooting-journey/phase1-vpc-networking/03-solution-vpc-success.png)  
*Successful VPC creation with proper multi-AZ configuration*

### Phase 2: Security Emergency

**Problem:** Security group conflicts and infinite module loops

![Duplicate Variables](./docs/screenshots-organized/troubleshooting-journey/phase4-infrastructure-integration/01-problem-duplicate-vars.png)

**Solution:** Emergency cleanup and security group optimization

![Security Complete](./docs/screenshots-organized/troubleshooting-journey/phase2-security-emergency/06-solution-security-complete.png)  
*Security module successfully deployed with proper rules*

### Phase 3: Database Configuration

**Problem:** Database module argument errors and missing variables

![DB Arguments](./docs/screenshots-organized/troubleshooting-journey/phase3-database-config/01-problem-db-arguments.png)  
*RDS configuration issues and parameter mismatches*

**Solution:** Corrected database parameters and subnet configurations

![Validate Success](./docs/screenshots-organized/troubleshooting-journey/phase3-database-config/03-solution-validate-success.png)  
*Database module validated successfully*

### Phase 4: Infrastructure Integration

**Problem:** Module dependency issues and output mismatches

![Dependencies](./docs/screenshots-organized/troubleshooting-journey/phase4-infrastructure-integration/03-problem-dependencies.png)  
*Missing dependencies between compute and networking modules*

**Solution:** Resolved module dependencies and output configurations

![Integration Complete](./docs/screenshots-organized/troubleshooting-journey/phase4-infrastructure-integration/06-solution-integration-complete.png)  
*All modules integrated successfully*

### Phase 5: Validation Fixes

**Problem:** Terraform syntax errors and formatting issues

![Validation Errors](./docs/screenshots-organized/troubleshooting-journey/phase5-validation-fixes/01-problem-validation-errors.png)  
*Terraform validation failures across multiple files*

**Solution:** Comprehensive formatting and syntax correction

![Validate Success](./docs/screenshots-organized/troubleshooting-journey/phase5-validation-fixes/16-solution-validate-success.png)  
*All Terraform files validated successfully*

### Phase 6: Deployment Attempts

**Problem:** IAM role conflicts and region configuration issues

![IAM Check](./docs/screenshots-organized/troubleshooting-journey/phase6-deployment-attempts/01-problem-iam-check.png)  
*IAM role configuration and permission errors*

**Solution:** Manual role creation and region fixes

![IAM Verified](./docs/screenshots-organized/troubleshooting-journey/phase6-deployment-attempts/11-solution-iam-verified.png)  
*IAM roles created and verified successfully*

### Phase 7: CI/CD Pipeline Recovery

**Problem:** GitHub Actions workflow failures due to YAML syntax errors

![Workflow Failures](./docs/screenshots-organized/troubleshooting-journey/phase7-cicd-journey/01-problem-workflow-failures.png)  
*All workflows failing due to YAML syntax and indentation issues*

**Solution:** Fixed YAML syntax and implemented safe validation workflows

![All Green](./docs/screenshots-organized/troubleshooting-journey/phase7-cicd-journey/04-solution-all-green.png)  
*All safe workflows passing with manual trigger safety*

---

## Project Structure

```
enterprise-aws-3tier-architecture/
├── .github/workflows/              # CI/CD Pipeline
│   ├── terraform-validation.yml   # ACTIVE - Safe validation
│   ├── security-scan.yml          # ACTIVE - Security checks
│   └── disabled/                  # SAFETY - Deployment workflows
├── backend/                        # Node.js API
│   ├── src/                       # Application source
│   │   ├── config/               # Configuration files
│   │   ├── controllers/          # API controllers
│   │   ├── middleware/           # Authentication & validation
│   │   ├── models/               # Data models
│   │   ├── routes/               # API routes
│   │   └── utils/                # Utility functions
│   ├── tests/                     # Test suites
│   ├── logs/                      # Application logs
│   ├── .eslintrc.json            # Code quality
│   ├── jest.config.js            # Testing configuration
│   └── ecosystem.config.js       # PM2 configuration
├── frontend/                      # React Application
│   ├── src/                      # React components
│   ├── public/                   # Static assets
│   ├── build/                    # Production build
│   ├── nginx.conf                # Web server configuration
│   └── Dockerfile                # Container configuration
├── terraform/                     # Infrastructure as Code
│   ├── modules/                  # 6 Terraform modules
│   │   ├── vpc/                 # Networking foundation
│   │   │   ├── main.tf
│   │   │   ├── nat_gateways.tf
│   │   │   ├── outputs.tf
│   │   │   ├── route_tables.tf
│   │   │   └── variables.tf
│   │   ├── security/            # Security groups & IAM
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── database/            # RDS PostgreSQL
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── compute/             # EC2 & Auto Scaling
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── load_balancing/      # ALB & Target Groups
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── monitoring/          # CloudWatch & SNS
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   └── environments/production/  # Production configuration
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── locals.tf
├── scripts/                       # Safety & Automation
│   ├── comprehensive-cost-check.sh
│   ├── cost-checker.sh
│   ├── emergency-nuke-all.sh
│   ├── pre-deploy-check.sh
│   ├── post-deploy-check.sh
│   ├── quick-cost-check.sh
│   └── safety-destroy.sh
├── docs/                          # Comprehensive Documentation
│   ├── architecture-diagram/
│   │   └── aws-3tier-architecture-diagram.png
│   ├── screenshots-organized/
│   │   ├── readme-showcase/
│   │   └── troubleshooting-journey/
│   └── archive-old/
├── LICENSE                        # MIT License
└── README.md                      # This file
```

---

## Technologies & AWS Services

### Infrastructure & DevOps

- **Terraform** - Infrastructure as Code (57 resources)
- **GitHub Actions** - CI/CD Pipeline with safety controls
- **Docker** - Containerization for both applications
- **AWS CLI** - Cloud management and automation

### AWS Services Implemented

- **Compute:** EC2, Auto Scaling, Launch Templates
- **Networking:** VPC, Internet Gateway, NAT Gateway, Route Tables, Subnets
- **Database:** RDS PostgreSQL, DB Subnet Groups
- **Load Balancing:** Application Load Balancer, Target Groups, Listeners
- **Security:** Security Groups, IAM Roles, IAM Policies
- **Monitoring:** CloudWatch, SNS, CloudWatch Alarms, Dashboards
- **Storage:** EBS (via RDS), S3 (configured for frontend)

### Application Stack

- **Backend:** Node.js, Express, JWT, PostgreSQL, Jest
- **Frontend:** React, modern JavaScript, CSS, Testing Library
- **Process Management:** PM2 for production process management
- **Web Server:** nginx for frontend serving

---

## Validation Evidence

### Comprehensive Log Reports

- **Terraform Plan Outputs:** Complete planning results for 57 resources
- **Error Logs:** Detailed troubleshooting documentation
- **Cost Audit Reports:** Zero-cost verification evidence
- **Application Logs:** Backend and frontend validation results

### Production Validation

- **57 Resources Successfully Planned:** Full infrastructure validation
- **Application Testing:** Backend and frontend test suites passing
- **Security Scanning:** Code quality and vulnerability assessment
- **Cost Management:** Zero AWS resources confirmed

---

## Getting Started

### Safe Validation Execution

All validation can be executed without AWS costs:

```bash
# Run comprehensive safety checks
./scripts/pre-deploy-check.sh

# Validate Terraform configuration
cd terraform/environments/production
terraform init -backend=false
terraform validate
terraform plan

# Execute application validation
cd backend
npm install
npm test
npm start

# Build and test frontend
cd frontend  
npm install
npm run build
npm test
```

### Cost Safety Verification

```bash
# Comprehensive cost audit
./scripts/comprehensive-cost-check.sh

# Quick cost verification
./scripts/quick-cost-check.sh

# Emergency termination (if needed)
./scripts/emergency-nuke-all.sh
```

---

## Professional Value

This project demonstrates enterprise-level skills in:

- **Cloud Architecture Design:** Complete 3-tier AWS infrastructure
- **Infrastructure as Code:** 57-resource Terraform configuration
- **DevOps & CI/CD:** Pipeline design with safety controls
- **Cost Optimization:** Zero-cost validation methodology
- **Problem-Solving:** Comprehensive troubleshooting documentation
- **Security Implementation:** Network segmentation and access controls
- **Monitoring & Observability:** CloudWatch dashboards and alerting
- **Full-Stack Development:** React frontend and Node.js backend
- **Containerization:** Docker implementation for both applications
- **Documentation:** Professional-grade project documentation

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**MIT License Summary:**
- Free to use, modify, and distribute
- Commercial use permitted
- Attribution required
- No warranty provided

---

## Author & Contact

**Sabin Rana**

- GitHub: [@sabinrana](https://github.com/sabinrana)
- LinkedIn: [linkedin.com/in/sabinran](https://linkedin.com/in/sabinran)
- Project Repository: [View this project](https://github.com/sabinrana/enterprise-aws-3tier-architecture)
- Blog: [Hashnode](https://sabin-codeops.hashnode.dev/)
- Credly: [Verify certifications](https://www.credly.com/badges/080be029-2747-438f-82cc-5f403008e2fa)

---

## Acknowledgments

This comprehensive project demonstrates professional cloud engineering skills through complete infrastructure design, validation, and documentation while maintaining absolute cost control. All 57 AWS resources are fully designed and validated without creating cloud resources, showcasing both technical expertise and financial responsibility in enterprise cloud environments.

**Ready for production deployment with a single command.**

---

### Star This Repository ⭐

If you find this project helpful or impressive, please consider giving it a star on GitHub. It helps others discover this resource and supports my work in creating professional cloud engineering content.

[⭐ Star this project on GitHub](https://github.com/sabinrana/enterprise-aws-3tier-architecture)