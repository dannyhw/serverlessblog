# Serverless tech blog learning experiment

**This is a work in progress**

Made using [Phenomic](https://github.com/MoOx/phenomic) phenomic-theme-base

The beginning of my project with serverless architecture.
Test version currently being hosted on s3 via:

http://dannyhwtest.s3-website-eu-west-1.amazonaws.com/

deployment to s3 is done via deploy.sh

Requires node,npm,git. Deploy script will only work on a bash shell and requires aws cli to be setup with credentials.

More details on how to setup your own site can be found on the live site [dannyw.info](http://dannyw.info).

## Install dependencies

```shell
npm install
```

## Run development server

```shell
npm start
```

## Build for production

```shell
npm run build
```
