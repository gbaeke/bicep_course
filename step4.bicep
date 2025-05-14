// Step 4: Add Outputs
@description('Name of the App Service Plan')
param planName string = 'myAppServicePlan'



resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: planName
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

var webAppName = uniqueString(subscription().subscriptionId, resourceGroup().name)
resource webApp 'Microsoft.Web/sites@2024-04-01' = {
  name: webAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output webAppUrl string = webApp.properties.defaultHostName
