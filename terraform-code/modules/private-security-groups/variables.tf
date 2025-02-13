variable "dev_vpc" {
  description = "VPC ID to associate the security group with"
  type        = string
}

variable "dev_SG_id" {
  description = "Security group ID of the public EC2 instance to allow access"
  type        = string
}
