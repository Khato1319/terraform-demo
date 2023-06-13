#!/bin/bash

cd frontend/src || exit
npm run build
npm run export
cd ../../iac || exit
terraform init && terraform apply --auto-approve