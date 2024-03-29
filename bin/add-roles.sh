#!/usr/bin/env bash

set -eu
source ./bin/set-environment-variables.sh

dir=$(dirname ${0})
jq -r '[(.[] | .roles | split(",")) | .[] ] | unique[]' ${dir}/users.json | while read args; do
  ${dir}/utils/idam-add-role.sh "$args"
done
