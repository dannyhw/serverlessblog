#!/bin/bash
S3BUCKET="dannyhwtest"
npm run build
aws s3 sync --delete dist/ s3://$S3BUCKET