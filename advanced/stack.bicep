targetScope = 'resourceGroup'

param storageAccountNames array = [
  'sa1'
  'sa2'
]

var uniqueStorageAccountNames = [for name in storageAccountNames: '${name}${uniqueString(subscription().subscriptionId, resourceGroup().name, name)}']

param location string = resourceGroup().location

resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in uniqueStorageAccountNames: {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}]
