#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
pushd "$SCRIPTPATH/packer_templates/windows"
tstamp=$(date '+%Y%m%d')
platform="windows"
edition="datacenter"
#onerror="abort"
onerror="cleanup"
for version in 2012r2 2016 2019; do
    box_basename="${platform}-${version}-${edition}_v${tstamp}"
    packer build -force -only=virtualbox-iso "-on-error=${onerror}" -var "box_basename=${box_basename}" -var "cpus=4" "${platform}-${version}.json"
done
popd