# Region
variable "region" {}
# tags: map of multiple strings
variable "name" {}
variable "project" {
  type        = string
  description = "Project"
  default     = "VT_d05_DevOps_Project _CICD_with_ Jenkins_Ansible_Kubernetes"
}
variable "folder" {
  type        = string
  description = "Folder of config files"
  default     = "a02_2024"
}
variable "managedby" {
  type        = string
  description = "Create By"
  default     = "Terraform"
}
variable "owner" {
  type        = string
  description = "Project owner"
  default     = "Arristide Tchatua"
}
variable "administrator" {
  type        = string
  description = "Contact Administrator"
  default     = "tchattua@gmail.com"
}