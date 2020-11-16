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
  
  local_secondary_index_names {
    count = (var.enabled ? 1 : 0) * length(var.local_secondary_index_map)
  
  # Convert the multi-item `local_secondary_index_map` into a simple `map` with just one item `name` since `triggers` does not support `lists` in `maps` (which are used in `non_key_attributes`)
    triggers = {
    "name" = var.local_secondary_index_map[count.index]["name"]
    }
  }
/*
  dynamic "attribute" {
    for_each = local.attributes_final
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  
*/
  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
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
