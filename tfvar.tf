variable "Region1" {
    type    = string
    default = "brazilsouth"
}
variable "Region2" {
    type    = string
    default = "westeurope"
}
variable "RSG" {
    type    = string
    default = "RSG"
}
variable "VnetBR" {
    type    = string
    default = "VnetBR"
}
variable "VnetWE" {
    type    = string
    default = "VnetWE"
}
variable "PIP1" {
    type    = string
    default = "PIPLBBR"
}
variable "PIP2" {
    type    = string
    default = "PIPLBWE"
}
variable "Subnetbr" {
    type = string
    default = "Subnetbr"
}
variable "Subnetwe" {
    type = string
    default = "Subnetwe"
}
variable "pass" {
    type = string
    default = "PassVitor123!"
}
variable "scalesetbr" {
    type = string
    default = "ScalesetBR"
}
variable "scalesetwe" {
    type = string
    default = "ScalesetWE"
}
variable "dnszone" {
    type = string
    default = "camargo.com"
}
