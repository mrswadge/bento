#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
pushd "$SCRIPTPATH/packer_templates/windows"
tstamp=$(date '+%Y%m%d')
platform="windows"
edition="datacenter"
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

# Iterate through the values and print each one
for version in "${values[@]}"; do
  box_basename="${platform}-${version}-${edition}_v${tstamp}"
  box_log="build-${platform}-${version}.log"
  echo "Building $box_basename with packer. You can follow the log in ${box_log}."
  packer build -force -only=virtualbox-iso "-on-error=${onerror}" -var "box_basename=${box_basename}" -var "cpus=4" "${platform}-${version}.json" > "${box_log}" 2>&1
done
popd