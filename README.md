#

## backend.template
Contains a template of the backend file which is created as backend.tf on running tf-wrapper.sh
Variables in {} are interpolated by the equivalent shell variables picked up by the code 

## Variables 
Variables are picked up from common.tfvars.json then overwritten by a variable file specified as a parameter

## Usage
. ./tf-wrapper.json -e <var file> -c <terraform command>
e.g. -c apply

eg:

     . ./tf-wrapper.sh -e vars/env-1.tfvars.json
     . ./tf-wrapper.sh -e vars/env-2.tfvars.json
     . ./tf-wrapper.sh -e vars/env-3.tfvars.json
     . ./tf-wrapper.sh -e vars/prod.tfvars.json

further analysis, eg:

     . ./tf-wrapper.sh -e vars/env-1.tfvars.json | grep "created\|destroyed"
     . ./tf-wrapper.sh -e vars/env-2.tfvars.json | grep "created\|destroyed"