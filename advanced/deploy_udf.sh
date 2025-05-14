#!/bin/zsh
# Usage: ./deploy.sh <bicep-file> [<parameters>]
# Example: ./deploy.sh udf.bicep

set -e

RESOURCE_GROUP="bicep-course-demo"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <bicep-file> [<parameters>]"
  exit 1
fi

BICEP_FILE="$1"
shift 1
PARAMS="$@"

echo "Deploying $BICEP_FILE to resource group $RESOURCE_GROUP..."

DEPLOYMENT_OUTPUT=$(az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file "$BICEP_FILE" \
  $PARAMS \
  --query '{outputs: properties.outputs}' \
  --output json)

echo "\nDeployment outputs:"
echo "$DEPLOYMENT_OUTPUT" | jq .outputs
