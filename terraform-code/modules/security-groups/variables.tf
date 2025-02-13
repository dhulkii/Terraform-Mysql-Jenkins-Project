variable "dev_vpc" {
  description = "VPC ID to associate the security group with"
  type        = string
}

variable "private_SG_id" {
  description = "The security group ID for the private instances"
  type        = string
}

