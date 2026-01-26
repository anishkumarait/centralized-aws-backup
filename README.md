# Centralized backup with AWS Backup service using Terraform
This repository provides a Terraform-based implementation of a centralized AWS Backup architecture for multi-account AWS environments. It enables consistent, secure, and automated backups across accounts while ensuring strong isolation and compliance.

# Architecture
![Architecture diagram](https://github.com/anishkumarait/centralized-aws-backup/blob/main/architecture-diagram.webp)
The solution follows a three-account model:
- **Management Account:** Enables AWS Backup organization-wide features and delegates backup administration.
- **Resource (Workload) Account(s):** Host application resources (EC2, EBS, RDS, DynamoDB, etc.) where backups are taken locally.
- **Central Backup Account:** Stores cross-account backup copies in dedicated vaults with stricter access controls.<br/>

Backups are created in workload accounts and automatically copied to the centralized backup account where they are re-encrypted using a KMS key owned by the backup account.

# How It Works
- AWS Backup plans are defined using policy-based automation.
- Backups are encrypted at source using customer-managed KMS keys.
- Recovery points are copied cross-account for disaster recovery and compliance.
- Centralized vaults protect backups from accidental deletion or compromised application accounts.
- Notifications and monitoring provide visibility into backup and copy failures.
- This design enforces separation of duties, improves security posture, and simplifies audits in large-scale AWS organizations.

# Detailed Design & Explanation

For a complete walkthrough of the architecture, design decisions, and Terraform implementation details, refer to the [blog post](https://medium.com/aws-tip/building-a-centralized-backup-strategy-on-aws-using-aws-backup-and-terraform-95dc162663fe)
