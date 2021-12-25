resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'sazaidc01'
  kind: 'StorageV2'
  location: 'eastus2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  location: 'eastus2'
  name: 'aspzc01'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  location: 'eastus2'
  name: 'appzc01'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
