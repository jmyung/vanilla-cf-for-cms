# vanilla CloudFormation template for cms
CloudFormation Template using Vanilla AMI (ubuntu 16.04) for Kubernetes

## Spec
- create vpc, public subnet
- create vanilla nodes (pure 16.04 ubuntu) in public subnet
- access from external internet with public key
- adjust node count with autoscale policy

## How to use
- upload `templates/vanilla-cluster.template` to CloudFormation template
- to get node ip
```
# worker node
$ aws ec2 describe-instances --filters "Name=tag:KubernetesCluster,Values=Vanilla-node-stack" "Name=tag:Name,Values=k8s-node" --query "Reservations[*].Instances[*].PublicIpAddress
[
    [
        "34.217.85.132",
        "52.12.193.46"
    ]
]
```
- to adjust node count
```
aws autoscaling update-auto-scaling-group --auto-scaling-group-name Vanilla-node-stack-K8sNodeGroup-CPCMUU51N4YG --desired-capacity 3
```
### reference
https://samsung-cnct.atlassian.net/wiki/spaces/AG/pages/233406484/Discovery+of+AWS+Provisioner+using+CloudFormation
