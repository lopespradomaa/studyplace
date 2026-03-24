resource hubVnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'vnet-az104-hub'
}

resource spokeVnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'vnet-az104-spoke'
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink${environment().suffixes.sqlServerHostname}'
  location: 'global'
}

resource hubDnsLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: 'hub-dns-link'
  parent: privateDnsZone
  location: 'global'
  properties: {
    virtualNetwork: {id: hubVnet.id}
    registrationEnabled: false
  }
}

resource spokeDnsLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: 'spoke-dns-link'
  parent: privateDnsZone
  location: 'global'
  properties: {
    virtualNetwork: {id: spokeVnet.id}
    registrationEnabled: false
  }
}
