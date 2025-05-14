#!/bin/zsh
# Deploy step 5: Using modules
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ../step5_main.bicep
