# Serverless tech blog learning experiment

### this is a work in progress.

Made using [Phenomic](https://github.com/MoOx/phenomic) phenomic-theme-base

The beginning of my project with serverless architecture.
Currently being hosted on s3 via:
http://dannyhwtest.s3-website-eu-west-1.amazonaws.com/

deployment to s3 is done via deploy.sh

Requires node,npm,git. Deploy script will only work on a bash shell and requires aws cli to be setup with credentials.

## S3 website hosting
enable webhosting in the bucket settings and add the following bucket policy.

```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "AddPerm",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::YOUR_BUCKET_NAME_HERE/*"
		}
	]
}
```

Then add your files from 'dist' into this folder. The deploy script does this.

## Install dependencies

```sh
npm install
```

## Run development server

```sh
npm start
```

## Build for production

```sh
npm run build
```
