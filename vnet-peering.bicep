
param location string = resourceGroup().location

param vnet1Name string = 'vnet1'
param vnet1Prefix string = '10.0.0.0/16'
param vnet1Subnet string = '10.0.1.0/24'

param vnet2Name string = 'vnet2'
param vnet2Prefix string = '10.1.0.0/16'
param vnet2Subnet string = '10.1.1.0/24'

resource vnet1 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnet1Prefix]
    }
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefix: vnet1Subnet
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnet2Prefix]
    }
    subnets: [
      {
        name: 'subnet2'
        properties: {
          addressPrefix: vnet2Subnet
        }
      }
    ]
  }
}

resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-02-01' = {
  name: '${vnet1Name}/peering-to-${vnet2Name}'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-02-01' = {
  name: '${vnet2Name}/peering-to-${vnet1Name}'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
