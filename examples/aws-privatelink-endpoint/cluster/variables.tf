variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}
variable "project_id" {
  description = "Atlas project ID"
}
variable "cluster_name" {
  description = "Atlas cluster name"
  default     = "aws-private-connection"
}
variable "aws_region" {
  description = "AWS region name"
}
variable "atlas_region" {
  description = "Atlas region name"
}
variable "mongodb_version" {
  description = "MongoDB version"
}
variable "aws_instance" {
  description = "Size of the AWS instance to be deployed in the VPC"
}
variable "key_name" {
  description = "Name of the ssh key file which must be present in the selected AWS region"
}
# variable "key_path" {
  # descriptione = "Path to the key file"
# }
