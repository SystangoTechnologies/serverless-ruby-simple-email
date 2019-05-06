# Serverless Rest APIs
This is a simple serverless application build over Jets framework of ruby. The application illustrate how we can create simple serverless email service using jets framework.
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
  'http://localhost:8888/send_email?sender=john@yopmail.com&recipient=david@yopmail.com&subject=this%20is%20the%20test%20subject&htmlbody=%3Ch1%3Ehi,%20David%3C/h1%3E' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 287d4c1b-9d4b-4ce9-943b-315d743195dd' \
  -H 'cache-control: no-cache'
```
The required parameters in the request are:
* sender
* recipient
* subject
* htmlbody
* textbody

You can send either htmlbody or textbody parameters, No need to send both the parameters in the request.

## Deployment
To deploy your application to AWS, you need to just run single command

```ruby_on_rails
$ jets deploy
```

Once the application is deployed you will get the API endpoint using which you can access Live API.
