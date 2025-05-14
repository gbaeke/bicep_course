param name string = 'John Doe'
param location string = resourceGroup().location

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'greetUserScript'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.52.0'
    arguments: name
    scriptContent: '''
      echo "Hello, $1!"
      jq -n --arg msg "Hello, $1!" '{"greeting":$msg}' > $AZ_SCRIPTS_OUTPUT_PATH
    '''
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'PT1H'
  }
}

output greeting string = deploymentScript.properties.outputs.greeting
