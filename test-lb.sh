#!/bin/bash

if ! echo true | terraform console|grep -v "state lock." &> /dev/null; then
  echo "Terraform has not been initialized properly"
  exit 1
fi

terraform_get() {
  echo $(echo "$1"|terraform console|grep -v "state lock.")
}

loadbalancer_dns=$(terraform_get aws_lb.webserver[0].dns_name)

set e-

while :
do
  curl $loadbalancer_dns
  echo
  sleep 1
done
