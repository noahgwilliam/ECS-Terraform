variable "ecs_cluster_id" {
  description = "The ECS cluster identifier"
  default     = "UNSET"
}

variable "ecs_cluster_name" {
  description = "The ECS cluster name"
  default     = "UNSET"
}

variable "environment" {
  default = "UNSET"
}

variable "application" {
  default = "UNSET"
}

variable "vpc_id" {
  default = "UNSET"
}

variable "private-aza" {
  default = "UNSET"
}

variable "private-azb" {
  default = "UNSET"
}

variable "private-azc" {
  default = "UNSET"
}

variable "ecs_desired_containers_count" {
  default = "UNSET"
}

variable "ecs_task_definition_arn" {
  default = "UNSET"
}

variable "codedeploy_app_name" {
  default = "UNSET"
}

variable "ecs_autoscale_max_instances" {
  default = "UNSET"
}

variable "ecs_autoscale_min_instances" {
  default = "UNSET"
}

variable "cluster_name" {
  default = "UNSET"
}

variable "cluster_id" {
  default = "UNSET"
}

variable "live_listener_arn" {
  default = "UNSET"
}

variable "test_listener_arn" {
  default = "UNSET"
}

