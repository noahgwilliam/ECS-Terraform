#!/bin/bash

# Wrapper for terraform to enable:
#   interpolation of parameters into the state file location


# Config
# This will read through a file called common.tfvars.json in the local dir
# Also a config file passed as a tfvars.json file
# It will then extract key variables and these will be exported as environment variables which can be used in the main.tf
# Then terraform will run an init and a plan/apply (parameter option)

# References
# https://stackoverflow.com/questions/53330060/can-terraform-use-bash-environment-variables


ENV_FILE=""
DEFAULT="N"
TF_COMMAND="plan"
# find default var file.

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|-var-file)
    ENV_FILE="$2"
    shift # past argument
    shift # past value
    printf "Env File: ${ENV_FILE}\n"
    ;;
    -c|--command)
    TF_COMMAND="$2"
    shift # past argument
    shift # past value
    printf "Env File: ${ENV_FILE}\n"
    ;;    
    apply|--apply)
    TF_COMMAND="apply"
    shift # past argument
    printf "Default: ${TF_COMMAND}\n"
    ;;
    destroy|--destroy)
    TF_COMMAND="destroy"
    shift # past argument
    printf "Default: ${TF_COMMAND}\n"
    ;;
    state|--state)
    TF_COMMAND="state list"
    shift # past argument
    shift # past value
    printf "Default: ${TF_COMMAND}\n"
    ;;
    --default|-d)
    DEFAULT=YES
    shift # past argument
    printf "Default: ${DFAULT}\n"
    ;;
    *)    # unknown option
    shift # past argument
    printf "Unknown: \n"
    ;;
esac
done


if [[ ! -f "${ENV_FILE}" ]]; then
    echo "Must supply a valid variables file"
    return 0
fi

ENVIRONMENT=""
AWS_ACCOUNT_NO=""
APPLICATION=""
# Read values from common.tfvars.json
if [ -f ./common.tfvars.json ]; then
    printf "Reading common.tfvars.json \n"
    ENVIRONMENT=$(grep -i "environment" common.tfvars.json |awk -F\" '{print $4}')
    AWS_ACCOUNT_NO=$(grep -i "account" common.tfvars.json |awk -F\" '{print $4}')
    APPLICATION=$(grep -i "application" common.tfvars.json |awk -F\" '{print $4}')
fi

# Read override values from 
if [ -f ${ENV_FILE} ]; then
    printf "Reading variables from ${ENV_FILE} \n"
    if [[ $(grep -i "environment" ${ENV_FILE}) ]]; then ENVIRONMENT=$(grep -i '"environment"' ${ENV_FILE} |awk -F\" '{print $4}'); fi
    
fi



export ENVIRONMENT
export AWS_ACCOUNT_NO
export APPLICATION

printf "ENVIRONMENT: ${ENVIRONMENT}\n"
printf "APPLICATION: ${APPLICATION}\n"

cat backend.template|sed "s/{ENVIRONMENT}/${ENVIRONMENT}/" \
                    |sed "s/{APPLICATION}/${APPLICATION}/" > backend.tf

printf "terraform ${TF_COMMAND}  --var-file=${ENV_FILE} \n"

rm -rf .terraform .terraform.lock.hcl
terraform init
terraform ${TF_COMMAND}  --var-file common.tfvars.json --var-file=${ENV_FILE}

# terraform apply -var-file=env-1.tfvars.json OR terraform apply -var-file=env-2.tfvars.json terraform destroy -var-file=env-1.tfvars.json OR terraform destroy -var-file=env-2.tfvars.json