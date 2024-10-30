variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "lifecycle_policy" {
  description = "JSON configuration for lifecycle policy rules"
  type        = list(object({
    id      = string
    enabled = bool
    transition_days = number
    storage_class   = string
  }))
  default = []
}

