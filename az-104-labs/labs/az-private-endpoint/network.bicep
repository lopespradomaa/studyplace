param location string = 'northeurope'

resource hubVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet-az104-hub'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource spokeVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'vnet-az104-spoke'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.16.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-az104-vm'
        properties: {
          addressPrefix: '172.16.0.0/24'
        }
      }
      {
        name: 'snet-private-endpoint'
        properties: {
          addressPrefix: '172.16.1.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

resource hubToSpokePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: 'hub-to-spoke'
  parent: hubVnet
  properties: {
    remoteVirtualNetwork: {id: spokeVnet.id}
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    }
}

resource spokeToHubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
  name: 'spoke-to-hub'
  parent: spokeVnet
  properties: {
    remoteVirtualNetwork: {id: hubVnet.id}
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    useRemoteGateways: false
  }
}
