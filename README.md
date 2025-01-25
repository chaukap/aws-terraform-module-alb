# AWS Application Load Balancer Terraform Module for Mastodon

This Terraform module creates an Application Load Balancer (ALB) configured for Mastodon deployment on AWS ECS Fargate.

## Features

- HTTP to HTTPS redirection
- TLS 1.3 support with custom certificate
- Separate target groups for web and streaming services
- Configurable health checks
- IP-based targeting for Fargate tasks
- Security group with HTTP/HTTPS ingress rules

## Usage

```hcl
module "mastodon_alb" {
  source = "./modules/alb"

  environment     = "production"
  vpc_id         = "vpc-1234567890"
  public_subnets = ["subnet-1234567a", "subnet-1234567b"]
  certificate_arn = "arn:aws:acm:region:account:certificate/12345678-1234-1234-1234-123456789012"
  
  # Optional
  health_check_path = "/health"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

## Resources Created

- Application Load Balancer
- Security Group for ALB
- HTTP Listener (Port 80)
- HTTPS Listener (Port 443)
- Target Group for web service (Port 3000)
- Target Group for streaming service (Port 4000)

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| environment | Environment name (e.g., prod, staging) | string | yes |
| vpc_id | VPC ID where the ALB will be created | string | yes |
| public_subnets | List of public subnet IDs for ALB | list(string) | yes |
| certificate_arn | ARN of ACM certificate for HTTPS listener | string | yes |
| health_check_path | Health check path for target groups | string | no |

## Outputs

| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the ALB |
| alb_zone_id | Zone ID of the ALB |
| alb_security_group_id | Security group ID of the ALB |
| web_target_group_arn | ARN of the web target group |
| streaming_target_group_arn | ARN of the streaming target group |

## Security Considerations

- The ALB is configured with deletion protection enabled
- Security group allows inbound traffic only on ports 80 and 443
- Modern TLS policy (TLS 1.3) is enforced
- HTTP traffic is automatically redirected to HTTPS

## Recommended Additional Configuration

1. Set up Route53 records pointing to the ALB
2. Configure ECS services to use the target groups
3. Add WAF rules if additional security is needed
4. Consider customizing health check settings based on your application