---
title: First aws lambda function using Python.
date: 2016-01-01
layout: Post
hero: https://s3-eu-west-1.amazonaws.com/dannyhw.info.images/clouds.jpg
---

# Getting started with AWS Lambda

I've been experimenting with creating a lambda function with python. here I
outline my experience and offer some thoughts on the process. I will assume
basic Python and AWS knowledge.

# Initial thoughts

When you hit the "create function button" you are presented with a list of
available blueprints. These blueprints give a basic outline for common lambda
use cases. I started out with a blank function, however I think the best thing
do would be to look at some of the blueprints to get a better idea about how
functions come together as it would save some time.

Also AWS have some
[example use cases](http://docs.aws.amazon.com/lambda/latest/dg/use-cases.html)
in the documentation which I'd recommend taking a look at if you are thinking
about creating your own lambda functions.

You'll also need some basic understanding of IAM roles and policies since you
may need to set up some permissions so that your function can use other AWS
features. Even if you don't need to set this up I'd recommend getting an
understanding since you'll be able to better understand permission issues later
down the line.

Lastly make sure to take a look at the programming model for
[lambda functions](http://docs.aws.amazon.com/lambda/latest/dg/programming-model-v2.html).
This outlines the core concepts for writing lambda functions. Also take a look
at the language specific model, in this case
[Python](http://docs.aws.amazon.com/lambda/latest/dg/python-programming-model.html).

# First function

It's time to get the hello world function out of the way, and go over the
basics.

```Python
def lambda_handler(event, context):
    print 'Hello world!'
```

This is probably the most basic lambda function using Python.

Things to note before going forward are:

- You can write your functions in line using the AWS console if they're small
and don't use any external libraries.
- Your function must have a handler method which takes two arguments
(event and context)
- The underlying environment is a Amazon Linux instance based on the standard
AMI
- When you use `print` the output can be viewed in the cloudwatch logs
associated to that lambda function
- You can save and open files but you are restricted to the /tmp directory.
These files persist when the container is frozen (after execution ends).
- The same container is not always re-used for the same function. Don't assume
your files will always still be there on the next execution.

## Hello world 1.01

A better example of a lambda function is given by choosing the hello world
blueprint. This is what it looks like:

```Python
from __future__ import print_function

import json

print('Loading function')


def lambda_handler(event, context):
    # print("Received event: " + json.dumps(event, indent=2))
    print("value1 = " + event['key1'])
    print("value2 = " + event['key2'])
    print("value3 = " + event['key3'])
    return event['key1']  # Echo back the first key value
    # raise Exception('Something went wrong')
```

AWS python code tends to make use of Python
[dictionaries](https://docs.python.org/2/tutorial/datastructures.html#dictionaries)
alot so it's worth getting comfortable with using a python dictionary.
The event object that we get will provide us with information about the event
which triggered the function and is usually of the Python dictionary type. 
It can also be list, str, int, float, or NoneType type. The content will depend
on the event that triggered the function.
The context parameter is uses this parameter to provide runtime information to your
handler. This parameter is of the LambdaContext type.

So given that we've covered what the event object is, this function hello world
makes more sense. This function will take the event dictionary object and
print out the key value pairs for keys 'key1', 'key2' and 'key3'.


The example code here is based on the sample event used for testing a function
in the AWS console, it looks like this:

```json
{
  "key3": "value3",
  "key2": "value2",
  "key1": "value1"
}
```

So we'll be printing out "value1 = value1" and so on.

The handler can optionally return a value. What happens to this value depends
on how the function was triggered, if it was triggered asynchronously then the
value is discarded. If the function was triggered synchronously the value will
be returned to the entity that requested it. When you use the AWS lambda console
the value is returned and displayed on the console. If however your function is
triggered by an object being uploaded to S3 then the return value is discarded.
So in the case of this function when triggered from the console we will see
"value1" returned like so:

![Lambda hello world output](https://s3-eu-west-1.amazonaws.com/dannyhw.info.images/lambdaout.png)

You'll also see the print statements and some other information about the
request.
![Lambda hello world stats and logs](https://s3-eu-west-1.amazonaws.com/dannyhw.info.images/lambdout2.png)

That just about covers the basics of creating a first lambda function. I'll
be writing about my experience creating a function that responds to images
uploaded to an S3 bucket next.