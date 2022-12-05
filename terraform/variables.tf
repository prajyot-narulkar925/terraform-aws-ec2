variable "access_key" {
   type = string
   default = ""
}
variable "secret_key" {
   type = string
   default = ""
}

variable "domain" {
    type = string
    default =  "prajyot-test-opensearch"
}
variable "instance_type" {
    type = string
    default = "t3.small.elasticsearch"
}
variable "tag_domain" {
    type = string
    default = "NewDomain"
}
variable "volume_type" {
    type = string
    default="gp2"
}
variable "ebs_volume_size" {
   default= 10
}