param location string = resourceGroup().location
param subnets array = [
  {
    name: 'sn1'
    addressPrefix: '10.0.1.0/24'
  }
  {
    name: 'sn2'
    addressPrefix: '10.0.2.0/23'
  }
]

param resourceNames object = {
  vnet: 'vnet-vnet1'
  containerEnv: 'acae-${uniqueString(subscription().subscriptionId, resourceGroup().name)}'
  keyVault: 'kv-${uniqueString(subscription().subscriptionId, resourceGroup().name)}'
  storageAccount: 'sa${uniqueString(subscription().subscriptionId, resourceGroup().name)}'
  kvDnsZone: 'privatelink.vaultcore.azure.net'
  storageDnsZone: 'privatelink.blob.${environment().suffixes.storage}'
  kvDnsZoneLink: 'kvDnsZoneLink'
  storageDnsZoneLink: 'storageDnsZoneLink'
}

var subnetNames = [for subnet in subnets: subnet.name]

var baseTags = {
  environment: 'production'
  owner: 'team-xyz'
  costCenter: '12345'
}

module vnet 'br/public:avm/res/network/virtual-network:0.6.1' = {
  name: 'vnetDeployment'
  params: {
    tags: {
      ...baseTags
      someOtherTag: 'someOtherTag'
    }
    name: resourceNames.vnet
    location: location
    addressPrefixes: ['10.0.0.0/16']
    subnets: [for subnet in subnets: {
      name: subnet.name
      addressPrefix: subnet.addressPrefix
    }]
  }
}

module containerEnv 'br/public:avm/res/app/managed-environment:0.11.1' = {
  name: 'containerEnvDeployment'
  params: {
    name: resourceNames.containerEnv
    location: location
    infrastructureSubnetResourceId: vnet.outputs.subnetResourceIds[indexOf(subnetNames, 'sn2')]
  }
}

module keyVault 'br/public:avm/res/key-vault/vault:0.12.1' = {
  name: 'keyVaultDeployment'
  dependsOn: [
    storageAccount
  ]
  params: {
    name: resourceNames.keyVault
    location: location
    enableRbacAuthorization: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
    secrets: [
      {
        name: 'storagekey'
        value: listkeys(resourceId('Microsoft.Storage/storageAccounts', resourceNames.storageAccount), '2024-01-01').keys[0].value
      }
    ]
    privateEndpoints: [
      {
        service: 'vault'
        subnetResourceId: vnet.outputs.subnetResourceIds[indexOf(subnetNames, 'sn1')]
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: kvDnsZone.outputs.resourceId
            }
          ]
        }
      }
    ]
  }
}

module storageAccount 'br/public:avm/res/storage/storage-account:0.19.0' = {
  name: 'storageAccountDeployment'
  params: {
    name: resourceNames.storageAccount
    location: location
    skuName: 'Standard_LRS'
    kind: 'StorageV2'
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
    privateEndpoints: [
      {
        service: 'blob'
        subnetResourceId: vnet.outputs.subnetResourceIds[indexOf(subnetNames, 'sn1')]
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: storageDnsZone.outputs.resourceId
            }
          ]
        }
      }
    ]
  }
}

module kvDnsZone 'br/public:avm/res/network/private-dns-zone:0.7.1' = {
  name: 'kvDnsZoneDeployment'
  params: {
    name: resourceNames.kvDnsZone
    location: 'global'
    virtualNetworkLinks: [
      {
        name: resourceNames.kvDnsZoneLink
        virtualNetworkResourceId: vnet.outputs.resourceId
        registrationEnabled: false
      }
    ]
  }
}

module storageDnsZone 'br/public:avm/res/network/private-dns-zone:0.7.1' = {
  name: 'storageDnsZoneDeployment'
  params: {
    name: resourceNames.storageDnsZone
    location: 'global'
    virtualNetworkLinks: [
      {
        name: resourceNames.storageDnsZoneLink
        virtualNetworkResourceId: vnet.outputs.resourceId
        registrationEnabled: false
      }
    ]
  }
}
