# Serverless Email Service
This is a simple serverless application build over Jets framework of the ruby. The application illustrates how we can create a simple serverless email service using jets framework.
## Requirements
* AWS CLI

## Setup

### Step 1 - Install AWS CLI
```sh
$ sudo apt install awscli
```

### Step 2 - Configure AWS CLI
```sh
$ aws configure
```
### Step 3 - Take clone of the repository

```ruby_on_rails
$ git clone https://gitlab.com/prateek-systango/serverless-email-service.git
$ cd serverless-rest-apis
$ bundle install
```
### Step 5 - Run Application

To start your the jets server locally, you need to run

```ruby_on_rails
$ jets s
```
Your Service must be running on http://localhost:8888.

To send email, you can hit the following endpoint as a POST request.

```ruby_on_rails
$ curl -X POST \
  http://localhost:8888/send_email \
  -H 'Authorization: {YOUR AUTHORIZATION KEY}' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'cache-control: no-cache'
  -d '{"sender": "sender@domain.com", "recipients": ["recipient1@domain.com", "recipient2@domain.com"],"subject": "Test email", "body": "<h1>Hi User!</h1>"}'
```
The required parameters in the request are:
* **sender** [string]: Email address of sender
* **recipients** [array]: Array of recipients emails.
* **subject** [string]: Subject of Email
* **body** [string]: Body of subject(HTML or normal text)

## Deployment
To deploy your application to AWS, you need to just run single command

```ruby_on_rails
$ jets deploy
```

Once the application is deployed you will get the API endpoint using which you can access Live API.
