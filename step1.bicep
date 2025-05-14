// Step 1: Define Your First Resource (App Service Plan)
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'myAppServicePlan'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}
