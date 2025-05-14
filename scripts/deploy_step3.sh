#!/bin/zsh
# Deploy step 3: With parameters
RESOURCE_GROUP="bicep-course-demo"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ../step3.bicep \
  --parameters planName="myAppServicePlan"
