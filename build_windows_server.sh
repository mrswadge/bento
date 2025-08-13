#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
pushd "$SCRIPTPATH"

mkdir -p ./tools
if [ ! -f ./tools/jq.exe ]; then
  # Download and extract the latest version of jQ (windows 64) to ./tools
  curl -Ls "https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe" -o ./tools/jq.exe
else
  echo "jQ already exists in ./tools"
fi

# Download and extract the latest version of packer (windows 64) to ./tools
# Fetch the latest Packer version from HashiCorp releases API
# PACKER_LATEST_VERSION=$(curl -s https://api.releases.hashicorp.com/v1/releases/packer | ./tools/jq -r '.[].version' | sort -V | tail -n 1)
if [ ! -f ./tools/packer.exe ]; then
  PACKER_LATEST_VERSION=1.13.0
  curl -Ls "https://releases.hashicorp.com/packer/${PACKER_LATEST_VERSION}/packer_${PACKER_LATEST_VERSION}_windows_amd64.zip" -o ./tools/packer.zip
  unzip -o ./tools/packer.zip -d ./tools
  rm ./tools/packer.zip
else
  echo "Packer already exists in ./tools"
fi

tstamp=$(date '+%Y%m%d')
platform="windows"
disk_size="131072"
memory="4096"
onerror="cleanup"
vm_values=""

# Check for packer on the path.
if ! which packer >/dev/null; then
  # Add ./tools to the PATH if it is not already there
  if [[ ":$PATH:" != *":$SCRIPTPATH/tools:"* ]]; then
    echo "Adding ./tools to PATH"
    export PATH="$PATH:$SCRIPTPATH/tools"
  fi
fi

# Add oscdimg to the PATH if it is not already there (C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg)
# Install Windows ADK if not installed: https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
if ! which oscdimg >/dev/null; then
  if [[ ":$PATH:" != *":/c/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit/Deployment Tools/amd64/Oscdimg:"* ]]; then
    echo "Adding oscdimg to PATH"
    export PATH="$PATH:/c/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit/Deployment Tools/amd64/Oscdimg"
  fi
  if ! which oscdimg >/dev/null; then
    echo "oscdimg not found in PATH. Please install Windows ADK: https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install"
    exit 1
  fi
fi

# Function to print usage information and exit
print_usage() {
  echo "Usage: $0 [-onerror <abort|cleanup>] -vm <comma-separated-values>"
  exit 1
}

# Parse command line options
while [[ $# -gt 0 ]]; do
  case "$1" in
    -onerror)
      shift
      case "$1" in
        "abort" | "cleanup")
          onerror="$1"
          ;;
        *)
          echo "Invalid -onerror option. Use 'abort' or 'cleanup'."
          print_usage
          ;;
      esac
      shift
      ;;
    -vm)
      shift
      if [ -n "$1" ]; then
        vm_values="$1"
      else
        echo "Missing argument for -vm option."
        print_usage
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Check if the user provided at least one argument value for -vm
if [ -z "$vm_values" ]; then
  echo "Missing comma-separated values for -vm option."
  print_usage
fi

# Use the IFS (Internal Field Separator) to split the values by comma
IFS=', ' read -ra values <<< "$vm_values"

packer init -upgrade ./packer_templates

# Iterate through the values and print each one
for version in "${values[@]}"; do
  box_log="build-${platform}-${version}.log"
  box_basename="${platform}/${platform}-${version}-x86_64"
  echo "Building $box_basename with packer. You can follow the log in ${box_log}."
  ./tools/packer build -force -only=virtualbox-iso.vm "-on-error=${onerror}" -var-file="os_pkrvars/${box_basename}.pkrvars.hcl" -var "cpus=4" -var "memory=${memory}" -var "disk_size=${disk_size}" ./packer_templates > "${box_log}" 2>&1 &
done

wait
popd