# Base setup 

This sets up the backend s3 buckets and a dynamo table for locking. An elastic container repository is also setup to hold the environment containers.

- dynamo db for locking  
- s3 bucket state (applies public access block) 
- s3 bucket state replica (applies public access block)
- iam_policy 
- iam_policy attachment 
- kms keys for encrypt and decrypt of backend state
- ECR Repo 