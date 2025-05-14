// Step 5: Move Resources to a Module (main)
@description('Name of the App Service Plan')
param planName string = 'myAppServicePlan'


module webAppModule 'modules/webAppModule.bicep' = {
  name: 'webAppDeployment'
  params: {
    planName: planName
    location: resourceGroup().location
  }
}

output webAppUrl string = webAppModule.outputs.url
