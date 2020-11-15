provider "aws" {
  region  = "us-east-2"
  version = "~> 3.13.0"
}
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.tablename}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "${var.hashkey_name}"
  range_key      = "${var.rangekey_name}"

  attribute {
    name = "${var.hashkey_name}"
    type = "${var.hashkey_type}"
  }

  attribute {
    name = "${var.rangekey_name}"
    type = "${var.rangekey_type}"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "${var.global_secondary_index_name}"
    hash_key           = "${var.hashkey_name}"
    range_key          = "${var.rangekey_name}"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["${var.hashkey_name}"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "dev"
  }
}
