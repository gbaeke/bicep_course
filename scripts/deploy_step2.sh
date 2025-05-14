#!/bin/zsh
# Deploy step 2: Add Web App
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ../step2.bicep
