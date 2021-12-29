variable "aws_profile" {
  type        = string
  description = "AWS profile name"
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "us-east-1"
}

variable "name" {
  description = "the name of your stack, e.g. \"demo\""
  default     = "demo-hw"
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "demo"
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "us-east-1"
}

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "172.31.0.0/16"
}

variable "vpc_id" {
  description = "VPC ID for ecs services"
  default     = "vpc-00e0634c2cec9b145"
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["172.31.80.0/20","172.31.16.0/20","172.31.32.0/20"] 
}

variable "public_subnets_ids" {
  type        = list(any)
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["subnet-070faab78ed2718be", "subnet-0899eed80f1a25c5a", "subnet-02d6fa51a8006dcdf"] 
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  default     = 2
}

variable "container_port" {
  description = "The port where the Docker is exposed"
  default     = 80
}

variable "container_cpu" {
  description = "The number of cpu(mi) units used by the task"
  default     = 256
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 512
}

variable "container_image" {
  default = ""
}

variable "ecs_cluster" {
  default = ""
}
