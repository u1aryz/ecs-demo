variable "access_key" {}
variable "secret_key" {}
variable "proxy_repo" {}
variable "api_repo" {}

variable "app_name" {
  default = "fargate-demo"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "az1" {
  default = "ap-northeast-1c"
}

variable "az2" {
  default = "ap-northeast-1d"
}

variable "root_segment" {
  default = "192.168.0.0/16"
}

variable "public_segment1" {
  default = "192.168.200.0/24"
}

variable "public_segment2" {
  default = "192.168.201.0/24"
}
