#!/bin/zsh
# Deploy AVM Bicep: App Service Plan + Web App
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

# Verify the Bicep file
if ! az bicep lint --file main.bicep; then
  echo "Bicep file validation failed. Exiting."
  exit 1
fi

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file main.bicep
