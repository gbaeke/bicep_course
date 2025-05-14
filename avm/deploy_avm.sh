#!/bin/zsh
# Deploy AVM Bicep: App Service Plan + Web App
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file main.bicep
