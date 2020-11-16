provider "aws" {
  region  = "us-east-2"
  version = "~> 3.13.0"
}
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  attribute {
    name = "${var.hash_key}"
    type = "${var.hash_key_type}"
  }

  attribute {
    name = "${var.range_key_name}"
    type = "${var.range_key_type}"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
  
  global_secondary_index_names {
    count = (var.enabled ? 1 : 0) * length(var.global_secondary_index_map)
   
    # Convert the multi-item `global_secondary_index_map` into a simple `map` with just one item `name` since `triggers` does not support `lists` in `maps` (which are used in `non_key_attributes`)
    triggers = {
      "name" = var.global_secondary_index_map[count.index]["name"]
    }
  }
  
  
/*
  global_secondary_index {
    name               = "${var.global_secondary_index_name}"
    hash_key           = "${var.global_secondary_index_hash_key_name}"
    range_key          = "${var.global_secondary_index_range_key_name}"
    write_capacity     = "${var.global_secondary_index_write_capacity}"
    read_capacity      = "${var.global_secondary_index_read_capacity}"
    projection_type    = "INCLUDE"
    non_key_attributes = ["${var.global_secondary_index_hash_key_name}"]
  }
*/
  tags = {
    Name        = "dynamodb-table-1"
    Environment = "dev"
  }
}
