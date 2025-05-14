#!/bin/zsh
# Deploy step 6: Using bicepparam file
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

# login to acr
az acr login --name acrgebabicep

# no need to provide bicep script; param file is enough
az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --parameters main.bicepparam
