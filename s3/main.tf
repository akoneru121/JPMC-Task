module "example_bucket" {
  source = "./modules/s3"

  bucket_name = "test-bucket-name"
  
  # Enable versioning
  enable_versioning = true
  
  # Enable lifecycle rules
  enable_lifecycle_rules = true
  
  # Standard-IA transition
  enable_standard_ia_transition = true
  standard_ia_transition_days  = 30
  
  # Glacier transition
  enable_glacier_transition = true
  glacier_transition_days  = 60
  
  # Noncurrent version management
  enable_noncurrent_version_transitions = true
  noncurrent_version_transition_days   = 30
  enable_noncurrent_version_expiration = true
  noncurrent_version_expiration_days   = 90
  
  # Optional: Enable current object expiration
  enable_current_object_expiration = false
  current_object_expiration_days  = 365
  
  # Optional: Use KMS encryption
  # kms_key_arn = "arn:aws:kms:region:account-id:key/key-id"
  
  tags = {
    Environment = "Production"
    Project     = "MyProject"
    Owner       = "Aditya"
  }
}
