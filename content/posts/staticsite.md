---
title: Creating a static serverless website
date: 2016-12-27
layout: Post
# hero credit: https://www.flickr.com/photos/igotz/15669216853/
hero: https://farm8.staticflickr.com/7479/15669216853_aa8e70eae1_o.jpg
---

# Under the hood

Here I'll explain what is behind the scenes making the site run and how is it
built and deployed.

## The source

This website was created using phenomic and is hosted in S3.
This site is open source and available to view and re-use on
[github](https://github.com/dannyhw/serverlessblog).

## Pre-requisites

NodeJs, npm and git are required.

## Setup

### Phenomic

Phenomic is a static site generator which turns markdown content into html. It
uses react and vaious other libraries to get things going, but the genious part
is that you need very limited knowledge of this to get started.

Visit [http://phenomic.io](http://phenomic.io) to find out more.

#### Setting up the template for the site

These steps will work for Linux/MacOS, please visit the phenomic site for windows steps.

Open up your terminal and run the following commands in an appropriate location.
This will setup your workspace environment.

_I like to use ~/workspace/web as my working directory for web projects. So I would first
cd into that location._

```shell
DIR=your-website-folder
mkdir $DIR && cd $DIR && mkdir node_modules
```

Then to setup your Javascript libraries run the following:

```shell
npm install phenomic && ./node_modules/.bin/phenomic setup
npm install && npm start
```

Don't worry about unmet dependencies after the initial npm install, these will be
resolved once you have run the setup script and then run install again.
This is because the setup script creates the "package.json" file which will include all
the dependencies when you next run install.

#### Your site

The template site will now be setup and running locally
[http://localhost:3333/](http://localhost:3333/).
This is a locally hosted version of the site (not static) that will change as you update
your content. This is where you will want to play around until you get it just right.

#### Building the site

Now to generate a static version of your website
Use the following command:

```shell
npm run build
```

Once this command has finished executing you will find your files in the "Dist" folder of
your project. These are the files you will want to host on S3 or a hosting solution of your
choice. Github Pages and Netlifly are recommended by Phenomic.

### Hosting in S3

I chose to host my site using S3 since aws is what I'm familiar with and it's also free since
I'm still in the free tier.

#### Setup your S3 bucket

Create a bucket in S3 and enable it as a website bucket.

Then to make it available to the public add the following bucket policy.

```json
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

