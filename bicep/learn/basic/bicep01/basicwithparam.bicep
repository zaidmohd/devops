param location string = resourceGroup().location
param storageAccountName string = 'sazc${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'appzc${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'aspzc01'
var appServicePlanSkuName = (environmentType == 'prod') ? 'pv_v3' : 'F1'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  kind: 'StorageV2'
  location: location
  sku: {
    name: storageAccountSkuName
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  location: location
  name: appServicePlanName
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  location: location
  name: appServiceAppName
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
