#!/bin/zsh
# Deploy step 1: App Service Plan only
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ../step1.bicep
