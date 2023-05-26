output "s3_state_bucket" {
    value = module.remote-state-s3-backend.state_bucket.bucket
}

output "dynamo_state_table" {
    value = module.remote-state-s3-backend.dynamodb_table.id
}

output "kms_key_id" {
    value = module.remote-state-s3-backend.kms_key.id
}