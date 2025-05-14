#!/bin/bash
# ...existing code...

# Check if logged in with Azure CLI
if ! az account show > /dev/null 2>&1; then
  echo "You are not logged in to Azure CLI. Please run 'az login' first."
  exit 1
fi

# Parse parameters
RESOURCE_GROUP_NAME="bicep-course-demo"
REGISTRY_NAME="acrgebabicep"
LOCATION="westeurope"

if [ -z "$RESOURCE_GROUP_NAME" ] || [ -z "$REGISTRY_NAME" ] || [ -z "$LOCATION" ]; then
  echo "Usage: $0 <resource-group-name> <registry-name> <location>"
  exit 1
fi

# Create Azure Container Registry
az acr create --resource-group "$RESOURCE_GROUP_NAME" --name "$REGISTRY_NAME" --sku Basic --location "$LOCATION"

# Publish model.bicep to ACR
az bicep publish --file webapp_module.bicep --target br:${REGISTRY_NAME}.azurecr.io/bicep/modules/webapp:v1

