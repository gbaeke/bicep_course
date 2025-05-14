// Parameters
@description('Name of the App Service Plan')
param planName string = 'myAppServicePlan'

@description('Location for all resources')
param location string = resourceGroup().location

// Deploy App Service Plan using AVM
module appServicePlanModule 'br/public:avm/res/web/serverfarm:0.4.1' = {
  name: 'appServicePlanDeployment'
  params: {
    name: planName
    location: location
    skuName: 'B1'
    kind: 'linux'
    targetWorkerCount: 1
    reserved: true
  }
}

// Generate a unique Web App name
var webAppName = uniqueString(subscription().subscriptionId, resourceGroup().name)

// Deploy Web App using AVM
module webAppModule 'br/public:avm/res/web/site:0.15.1' = {
  name: 'webAppDeployment'
  params: {
    kind: 'app'
    name: webAppName
    location: location
    serverFarmResourceId: appServicePlanModule.outputs.resourceId
    httpsOnly: true
    }
}

// Output the Web App URL
output webAppUrl string = webAppModule.outputs.defaultHostname
