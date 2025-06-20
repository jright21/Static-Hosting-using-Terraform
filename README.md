## Cloud-Native Static Website Hosting on AWS with Terraform and implementing CI/CD 

- This project deploys a static website on Amazon S3 using cloud-native services. 
- DNS management is handled through Route53 and SSL certificate management via ACM. 
- The website's performance is optimized using CloudFront as a CDN. 
- CI/CD is achieved through GitHub Actions.
- Terraform is used to create and manage the entire Infrastructure.

## AWS Services Used 

| Service        | Purpose                 |
| -------------- | ----------------------- |
| Amazon S3      | Host the static website |
| Route53        | Manage DNS              |
| ACM            | Manage SSL certificates |
| CloudFront     | Used for CDN            |
| GitHub Actions | CI/CD                   |
| Terraform | IaC                          |

## Architecture Diagram

## Function of each file 

| File                               | Description                                                                                                            |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| .github/workflows/deploy-to-s3.yml | Workflow to sync `demo_static_site/*` to the S3 bucket.                                                                |
| demo_static_site                   | Our static website.                                                                                                    |
| provider.tf                        | Defines the provider block for Terraform.                                                                              |
| backend.tf                         | Configures a remote S3 backend to store and manage the Terraform state file.                                           |
| vars.tf                            | Stores different variables to be used across the entire project.                                                           |
| s3_static_hosting.tf               | Creates a s3 bucket and enables static hosting.                                                                        |
| route_53.tf                        | Creates a public hosted zone and configures `A Record (Alias)` for CloudFront for our domain.                          |
| acm_cert.tf                        | Creates an SSL certificate and validates it for our domain and hosted zone.                                            |
| cloudfront.tf                      | Creates a CloudFront distribution with the above created S3 bucket and ACM, as the origin and SSL Certificate respectively. |

## Flow Diagram

### Automation Flow
<img src="https://github.com/user-attachments/assets/72706f8d-6376-468f-ab2d-2dd18f751a59" alt="automation" width="400" height="700">
</img>

### DNS Configuration and Certificate Validation flow
<img src="https://github.com/user-attachments/assets/8f2b9d8a-159e-4ddf-aac8-1155efcf724c" alt="configuration and validation" width="400" height="700">
</img>

