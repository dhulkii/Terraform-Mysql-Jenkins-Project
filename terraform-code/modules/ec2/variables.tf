variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro" # Optional default value
}

variable "key_pair" {
  description = "EC2 Key Pair"
  type        = string
  default     = "dhulki-key-nvirgina-hp"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "ID of the subnet in which the EC2 instance will be created"
  type        = string
}