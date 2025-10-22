# Enterprise AWS 3-Tier Architecture

A production-ready, cost-optimized AWS 3-Tier Architecture built with Terraform, featuring enterprise security, CI/CD pipelines, and comprehensive monitoring.

## Features

### Infrastructure
- Multi-AZ High Availability across 2 Availability Zones
- Auto Scaling Groups for Web and Application tiers
- Load Balancers (External and Internal ALB)
- RDS PostgreSQL with Read Replica
- VPC with Public/Private Subnets

### Security
- Layered Security Groups with least privilege
- WAF and CloudFront for DDoS protection
- Secrets Manager and KMS for credential encryption
- VPC Flow Logs for network monitoring
- SSM Session Manager for secure access

### DevOps and Automation
- Terraform Infrastructure as Code
- GitHub Actions CI/CD Pipeline
- Automated Testing and Deployment
- Environment Promotion (Dev to Staging to Prod)

### Monitoring and Operations
- CloudWatch Dashboards and Alarms
- SNS Notifications for auto-scaling events
- Cost Optimization with budget alerts
- Comprehensive Logging

## Project Structure

```
enterprise-aws-3tier-architecture/
├── frontend/                # React.js application
├── backend/                 # Node.js API server
├── terraform/               # Infrastructure as Code
│   ├── modules/            # Reusable Terraform modules
│   └── environments/       # Environment configurations
├── docs/                   # Documentation and screenshots
└── README.md
```

## Architecture Overview

### External Layer
- SNS - Simple Notification Service for notifications
- Email notifications
- User access points
- Application Load Balancer - distributes incoming traffic
- Auto Scaling groups - automatically scales web servers
- Virtual Gateway - VPN connectivity
- Route53 - DNS service management

### Tier 1: Web/Presentation Layer (Public Subnets)
- EC2 instances running web servers
- Auto Scaling group automatically adds/removes web servers based on demand
- NAT Gateway allows private resources to access internet
- Route tables manage routing rules
- Behind Application Load Balancer for traffic distribution

### Tier 2: Application Layer (Private Subnets)
- EC2 instances running application servers
- Auto Scaling group scales application servers automatically
- Route tables for private subnet routing
- Connected to S3 bucket for object storage
- Behind Application Load Balancer for load distribution

### Tier 3: Database Layer (Private Subnets)
- Amazon RDS database servers
- Most secure layer, isolated from internet
- Route tables for database subnet

### Additional Components
- VPC Flow Logs - captures network traffic logs
- All resources contained within VPC (Virtual Private Cloud)
- Infrastructure spans across 2 Availability Zones for redundancy
- Auto-scaling connections between tiers

### Load Balancing and Auto Scaling
- Application Load Balancers distribute traffic evenly across EC2 instances in both availability zones
- Auto Scaling groups monitor resource usage and automatically add or remove EC2 instances to handle varying traffic loads
- Ensures optimal performance and cost efficiency

## Technologies

- **Frontend**: React.js, NGINX
- **Backend**: Node.js, Express.js
- **Database**: AWS RDS PostgreSQL
- **Infrastructure**: Terraform, AWS Cloud
- **CI/CD**: GitHub Actions
- **Monitoring**: CloudWatch, SNS

## Prerequisites

- AWS Account with appropriate permissions
- Terraform v1.0+ installed
- Node.js v16+ installed
- GitHub account for CI/CD

## Quick Start

Installation instructions will be added as we build the project.

## Cost Optimization

This project is designed to cost under $1 for demonstration purposes by:
- Utilizing AWS Free Tier resources
- Short deployment-test-destroy cycles
- Cost-optimized instance types
- Strategic use of VPC Endpoints

## Support

For issues and questions, please open a GitHub Issue.

## License

This project is licensed under the MIT License.