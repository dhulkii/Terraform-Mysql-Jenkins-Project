variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0" # Default value for AMI
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair" {
  description = "Key Pair for EC2 instance"
  type        = string
  default     = "dhulki-key-nvirgina-hp"
}
