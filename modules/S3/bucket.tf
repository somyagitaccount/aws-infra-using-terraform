resource "aws_s3_bucket" "terraform-state" {
    bucket = "state-file-bucket"

    lifecycle {
      prevent_destroy = false
    }

    # versioning {
    #   enabled = false
    # }

    # server_side_encryption_configuration {
    #   rule {
    #       apply_server_side_encryption_by_default {
    #           sse_algorithm = "AES256"
    #       }
    #   }
    # }
  
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-test-locks"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
        name = "LockID"
        type = "S"
      
    }
  
}