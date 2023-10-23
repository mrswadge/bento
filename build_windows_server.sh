#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
pushd "$SCRIPTPATH"
tstamp=$(date '+%Y%m%d')
platform="windows"
disk_size="131072"
memory="16384"
onerror="cleanup"
vm_values=""

# Check for packer on the path.
if ! which packer >/dev/null; then
  echo "Packer is not found on the PATH."
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
  packer build -force -only=virtualbox-iso.vm "-on-error=${onerror}" -var-file="os_pkrvars/${box_basename}.pkrvars.hcl" -var "cpus=4" -var "memory=${memory}" -var "disk_size=${disk_size}" ./packer_templates > "${box_log}" 2>&1
done
popd