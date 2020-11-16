variable "table_name" {
  type        = string
  default     = ""
  description = "table name, e.g. 'app' or 'jenkins'"
}

variable "hash_key" {
  type        = string
  description = "DynamoDB table Hash Key"
}

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "range_key" {
  type        = string
  default     = ""
  description = "DynamoDB table Range Key"
}

variable "range_key_type" {
  type        = string
  default     = "S"
  description = "Range Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "read_capacity" {
  type = number
  default = 10
  description = "cost will effect as the read capacity units number increase"
}

variable "write_capacity" {
  type = number
  default = 10
  description = "cost will effect as the write capacity units number increase"  
}

/*
variable "global_secondary_index_name" {}

variable "global_secondary_index_map" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values"
}

variable "local_secondary_index_map" {
  type = list(object({
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
  }))
  default     = []
  description = "Additional local secondary indexes in the form of a list of mapped values"
}


*/
