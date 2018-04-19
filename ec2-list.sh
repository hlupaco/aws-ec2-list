#!/bin/bash

if [ "$#" -gt 0 ] ; then
  echo "Usage: $0"
  echo "Output is in format ID:IP"
  exit 1
fi

for reg in \
    $(aws ec2 describe-regions | jq '.Regions[].RegionName' | tr -d '"') ; do

  (
  aws ec2 describe-instances --region="${reg}" \
    | jq '.Reservations[].Instances[] | "\(.InstanceId):\(.PublicIpAddress)"' \
    | tr -d '"'
  ) &

done

wait


