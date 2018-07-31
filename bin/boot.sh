!/usr/bin/env bash

# Where to place your cluster
REGION=us-west-2
AZ=us-west-2b

# What to name your CloudFormation stack
STACK=vanilla-stack-for-cms

# Which SSH key you want to allow access to the cluster
KEYNAME=temp_OR_KP

# What IP addresses should be able to connect over SSH and over the Kubernetes API
INGRESS=0.0.0.0/0

INSTANCETYPE=m4.large
DISKSIZE=40
LBTYPE=internet-facing
PASSWD=123qwe
SSHLOCATION=0.0.0.0/0
NODECAPA=2

aws ec2 --region $REGION import-key-pair --key-name $KEYNAME --public-key-material "$(cat ~/.ssh/id_rsa.pub)"

aws cloudformation create-stack \
  --region $REGION \
  --stack-name $STACK \
  --template-url "https://s3.amazonaws.com/" \
  --parameters \
    ParameterKey=AvailabilityZone,ParameterValue=$AZ \
    ParameterKey=InstanceType,ParameterValue=$INSTANCETYPE \
    ParameterKey=DiskSizeGb,ParameterValue=$DISKSIZE \
    ParameterKey=LoadBalancerType,ParameterValue=$LBTYPE \
    ParameterKey=NodePasswd,ParameterValue=$PASSWD \
    ParameterKey=SSHLocation,ParameterValue=$SSHLOCATION \
    ParameterKey=KeyName,ParameterValue=$KEYNAME \
    ParameterKey=K8sNodeCapacity,ParameterValue=$NODECAPA \
  --capabilities=CAPABILITY_IAM
