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


## Setup

### Pre-requisites

NodeJs, npm and git are required.

### Phenomic

Phenomic is a static site generator which turns markdown content into HTML. It
uses react and various other libraries to get things going, but the genius part
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

#### Upload your HTML

There's two ways you can do this. The first is to sync from your local working directory and
the other is to automatically sync to s3 using a lambda function.

** 1. From local to s3: **

To get your files into s3 you can use the aws cli or directly upload the files via the
console. To do this via the cli is fairly simple. You can use the `cp` command or the `sync`
command. Using sync is preferable since some files will be created with new names each time
you build the static site.

** 1a. Sync **

This will only upload changed files and the delete flag deletes any files that no
longer exist in the local copy.

```shell

aws s3 sync --delete dist/ s3://YOUR_BUCKET_NAME_HERE

```

** 1b. Clean and copy **

Run the following for a simple copy to your s3 bucket. Bear in mind that you will want to
occasionally clear out your s3 bucket if you choose this route since it doesn't delete any
existing files.

To clear out the bucket.

```shell

aws s3 rm --recursive s3://YOUR_BUCKET_NAME_HERE/

```

To copy the files.

```shell

aws s3 cp --recursive dist/ s3://YOUR_BUCKET_NAME_HERE

```

** 2. Sync automatically with lambda **

I've not set this up yet so watch this space, however there is a blog post from amazon that
may prove useful.

[Github+lambda](https://aws.amazon.com/blogs/compute/dynamic-github-actions-with-aws-lambda/).

** 3. Script it **

you can also script the whole deployment. Create a file called deploy.sh and add the
following lines to it.

```shell

#!/bin/bash
S3BUCKET="YOUR_BUCKET_NAME_HERE"
npm run build
aws s3 sync --delete dist/ s3://$S3BUCKET

```

Change the bucket name with your own of course.

#### Checkout your new website

Find the url that aws has assigned for your s3 bucket and navigate to that in your browser.
Your site should look just like the one you were hosting locally but lightning fast!

You can also use route 53 to setup your site to use your own domain name, I can write about
that if anyone needs help with it.

