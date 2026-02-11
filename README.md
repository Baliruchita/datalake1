


# Data Lake Platform – Core Infrastructure (Hyderabad)

This repository provisions the **core AWS Data Lake platform infrastructure** using Terraform.

It is a **platform / foundation repository**, focused strictly on infrastructure and governance.  
All workload execution (Glue jobs, Lambda, ingestion pipelines) is intentionally **out of scope** and owned by downstream repositories.

---

## Purpose

The goal of this repository is to:

- Provision the **foundational Data Lake architecture**
- Enable **data governance using AWS Lake Formation**
- Provide a **reusable, secure base** for future data ingestion and processing workloads
- Support deployment to the **Hyderabad (testing) environment** via GitHub Actions

This repository fulfills the user story:

> **Provision core data lake architecture modules**

---

## What This Repository Creates

Terraform in this repository provisions:

- **Amazon S3 Data Lake buckets**
  - Raw
  - Processed
  - Curated
- **AWS Glue Data Catalog**
  - Glue databases for each data layer
- **AWS Lake Formation**
  - Enabled and configured
  - Data Lake admin role assigned
  - S3 buckets registered as governed resources
- **IAM roles**
  - Data Lake administrator role
  - AWS Glue service role
- **KMS CMK**
  - Used for S3 and Glue encryption
- **Remote Terraform state**
  - S3 backend with DynamoDB locking (pre-existing)

---

## What This Repository Does NOT Create

The following are **intentionally excluded** from this repository:

- AWS Glue jobs or crawlers
- Lambda functions
- Streaming or batch ingestion pipelines
- SQL schemas or utilities
- VPCs, subnets, or networking resources
- Application-specific IAM roles
- Device monitoring or processing logic

> **Rule of thumb:**  
> If it executes code, it does not belong in this platform repository.

---

## Environments

Currently supported:

- **Hyderabad** – Testing environment

Additional environments (e.g. staging, prod) can be added in future stories by extending the environment configuration and CI workflows.

---

## Repository Structure

.
├── .github/ # GitHub Actions workflows and custom actions
├── datalake/ # Core data lake Terraform module
│ ├── backend.tf # Terraform backend configuration
│ ├── provider.tf # AWS provider configuration
│ ├── versions.tf # Terraform & provider versions
│ ├── variables.tf # Input variables
│ ├── locals.tf # Naming and tagging conventions
│ ├── iam.tf # IAM roles (admin, Glue)
│ ├── kms-grants.tf # KMS CMK for encryption
│ ├── s3.tf # Raw / Processed / Curated S3 buckets
│ ├── glue.tf # Glue Data Catalog databases
│ ├── lakeformation.tf # Lake Formation governance configuration
│ └── environments/
│ └── hyderabad.tfvars # hyderabad environment configuration
├── .gitignore
└── README.md


---

## Prerequisites

### Terraform
- Terraform **>= 1.5**

Example using `tfenv`:
```bash
brew install tfenv
tfenv install 1.5.7
tfenv use 1.5.7
```

**AWS CLI**
```bash
brew install awscli
aws configure sso
```

### Local Development

cd datalake

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Optional plan
terraform plan


## CI/CD Deployment

Infrastructure is deployed using **GitHub Actions**.

### Workflows

#### Pull Request
- Static analysis
- Terraform validation
- Terraform plan (**hyderabad only**)

#### Manual Deployment
- Triggered via workflow dispatch
- Supports `plan` or `plan + apply`
- Manual approval required for apply

### Authentication
- GitHub Actions uses **OIDC** to assume AWS IAM roles
- No long-lived AWS credentials are stored in GitHub

---

## Verification After Deployment

After a successful deployment, verify in the AWS Console:

### S3
- Raw, Processed, and Curated buckets exist
- Encryption enabled using KMS

### Glue
- Glue databases for each data layer exist

### Lake Formation
- Lake Formation is enabled
- Data Lake admin role is configured
- S3 buckets are registered as data lake resources

---

## Contributing

1. Create a feature branch
2. Run Terraform validation locally (optional)
3. Open a pull request
4. Ensure CI checks pass
5. Request review from platform approvers

---

## Ownership

This repository is owned and reviewed by the **Compute / Platform team**, as defined in `CODEOWNERS`.

