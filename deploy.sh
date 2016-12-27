#!/bin/bash
S3BUCKET="dannyhwtest"
npm run build
aws s3 cp --recursive dist/ s3://$S3BUCKET