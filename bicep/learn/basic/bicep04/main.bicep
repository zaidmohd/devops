param locations array = [
  'eastus2'
]

@secure()
param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorLoginPassword string

param virtualNetworkAddressPrefix string = '10.10.0.0/16'

param subnets array = [
  {
    name: 'frontend'
    ipAddressRange: '10.10.5.0/24'
  }
  {
    name: 'backend'
    ipAddressRange: '10.10.10.0/24'
  }
]

var subnetProperties = [for subnet in subnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]

module databases 'modules/database.bicep' = [for location in locations: {
  name: 'database-${location}'
  params: {
    location: location
    sqlServerAdminLogin: sqlServerAdministratorLogin 
    sqlServerAdminPassword: sqlServerAdministratorLoginPassword
  }  
}]

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2020-11-01' = [for location in locations: {
  name: 'zc-${location}'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        virtualNetworkAddressPrefix
      ]
    }
    subnets: subnetProperties
  }
}]

output serverInfo array = [for i in range(0, length(locations)): {
  name: databases[i].outputs.serverName
  location: databases[i].outputs.location
  fullyQualifiedDomainName: databases[i].outputs.serverFullyQualifiedDomainName
}]
