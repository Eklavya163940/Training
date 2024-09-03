# modules/s3/variables.tf

variable "bucket_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "static_files" {
  type = list(object({
    key    = string
    source = string
  }))
}

variable "enable_public_read" {
  type    = bool
  default = false
}
