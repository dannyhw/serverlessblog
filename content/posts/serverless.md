---
title: Serverless.
date: 2016-12-28
layout: Post
hero: https://s3-eu-west-1.amazonaws.com/dannyhw.info.images/clouds.jpg
---

# Serverless Computing

## Definition

Taken from [wikipedia](https://en.wikipedia.org/wiki/Serverless_computing):

Serverless computing, also known as Function as a Service (FaaS), is a cloud computing
code execution model in which the cloud provider fully manages starting and stopping
virtual machines as necessary to serve requests, and requests are billed by an abstract
measure of the resources required to satisfy the request, rather than per virtual machine,
per hour.

## What this means

You can stick to writing code instead of setting up servers and configuration for things
like tomcat and apache. Code individual functionality that executes based on triggers
which you define. Only pay for what you use, this is great for individuals or startups where
servers could otherwise be idle for most of the time.

## How did we get here

The first step came with platform as a service (PaaS) which allows anyone to easily host
virtual machines in the cloud instead of having your own physical servers. This allows
you to piggyback off of big companies like Amazon for a base level of security and
reliability. It also opens up hosting to the little guy, especially with amazon's free tier.
You can host the lower tier machines on aws for free!

Amazon released AWS Lambda in 2014 which changed the game. Whilst amazon may not have been
the first to adopt this idea, they definitely were the biggest and they have the architecture
to back it up.