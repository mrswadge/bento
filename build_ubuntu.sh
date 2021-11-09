#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
pushd "$SCRIPTPATH/packer_templates/ubuntu"
tstamp=$(date '+%Y%m%d')
platform="ubuntu"
edition="amd64"
for version in '16.04' '18.04' '20.04' '20.10' '21.04'; do
    box_basename="${platform}-${version}-${edition}_v${tstamp}"
    packer build -only=virtualbox-iso -var "box_basename=${box_basename}" -var "cpus=4" "${platform}-${version}-${edition}.json"
done
popd