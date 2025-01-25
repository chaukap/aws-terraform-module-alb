variable "environment" {
  description = "Environment name (e.g., prod, staging)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "health_check_path" {
  description = "Health check path for target groups"
  type        = string
  default     = "/health"
}

variable "certificate_arn" {
  description = "ARN of ACM certificate for HTTPS listener"
  type        = string
}