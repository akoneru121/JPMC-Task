Multi-Region Failover POC with Route 53, ALB, and AWS Organizations Policies
This project demonstrates a multi-region failover setup using AWS Route 53 and Application Load Balancers, along with custom Terraform modules for S3 bucket creation and AWS Organizations Service Control Policies (SCPs) to enforce region-specific restrictions.

Project Overview
This Proof of Concept (POC) includes three primary components:

Multi-Region Failover:

Implements a high-availability architecture using Route 53 and Application Load Balancers (ALBs) across us-east-1 and us-west-2.
Configures health checks and failover routing policies in Route 53 to ensure that traffic fails over seamlessly between regions.
Custom Terraform Module for S3 Buckets:

A reusable Terraform module for S3 bucket creation with configurable versioning and lifecycle management policies.
Allows automatic transition of objects to other storage classes or deletion based on lifecycle rules.
AWS Organizations and SCPs:

Utilizes AWS Organizations and Service Control Policies (SCPs) to restrict deployments in designated regions.
Implements best practices by denying access to all AWS regions except specified ones, aligning with organizational security policies.
Components
1. Multi-Region Failover with Route 53 and ALB
Primary Region (us-east-1): Hosts the primary ALB and is the default traffic target.
Secondary Region (us-west-2): Hosts the secondary ALB and serves as a failover in case of primary region failure.
Route 53 Failover Configuration: Contains health checks for automatic redirection to us-west-2 when us-east-1 is unavailable.
2. Custom S3 Bucket Module
Versioning: Configurable option to enable or disable versioning on the S3 bucket.
Lifecycle Policies: Lifecycle rules to transition objects to different storage classes or delete them after a set period, reducing storage costs and optimizing data management.
3. AWS Organizations and Service Control Policies (SCPs)
SCPs applied to Organizational Units (OUs) to enforce region restrictions and prevent unauthorized region access.
Supports regulatory compliance and cost control by limiting deployments to specified AWS regions only.
Getting Started
Prerequisites
Terraform v0.13 or later
AWS CLI
AWS account with permissions to configure Route 53, ALB, S3, and AWS Organizations.
Setup
Multi-Region Failover:

Navigate to the multi-region-failover directory and apply the Terraform configurations for us-east-1 and us-west-2 to set up ALBs and Route 53 records.
S3 Bucket Module:

Use the s3-bucket-module to create an S3 bucket with versioning and lifecycle policies.
SCP Module:

Apply the scp-module in us-east-1 and us-west-2 directories to restrict or allow access in specified regions only.
Example Usage
bash
Copy code
# Initialize Terraform
terraform init

# Apply Terraform configurations
terraform apply
