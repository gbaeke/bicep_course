// storage-accounts-multi.bicep
// Deploy multiple storage accounts based on an array of names

var unused = 'unused'

@description('Array of storage account names to deploy')
param storageAccountNames array = [
  'storacctdemo01'
  'storacctdemo02'
  'storacctdemo03'
]

@description('Location for the storage accounts')
param location string = resourceGroup().location

@description('Deploy storage accounts?')
param deployStorageAccounts bool = true

@description('Enable blob public access?')
param enableBlobPublicAccess bool = false

@description('Deployment environment')
param environment string = 'dev'

// Resource-level condition with 'if' and property-level ternary example
resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for name in storageAccountNames: if (deployStorageAccounts) {
  name: name
  location: location
  sku: {
    name: environment == 'prod' ? 'Standard_GRS' : 'Standard_LRS' // Ternary: choose SKU based on environment
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: enableBlobPublicAccess ? true : false
  }
}]

