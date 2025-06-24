
param location string = resourceGroup().location
param vnetName string = 'appgateway-vnet'
param subnetName string = 'appgateway-subnet'
param appGwName string = 'appGateway'
param backend1IP string
param backend2IP string

resource appGatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' existing = {
  parent: resourceId('Microsoft.Network/virtualNetworks', vnetName)
  name: subnetName
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  name: '${appGwName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource appGw 'Microsoft.Network/applicationGateways@2023-02-01' = {
  name: appGwName
  location: location
  sku: {
    name: 'Standard_v2'
    tier: 'Standard_v2'
    capacity: 2
  }
  properties: {
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: appGatewaySubnet.id
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIP'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGwFrontendPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backendPool1'
        properties: {
          backendAddresses: [
            {
              ipAddress: backend1IP
            }
          ]
        }
      },
      {
        name: 'backendPool2'
        properties: {
          backendAddresses: [
            {
              ipAddress: backend2IP
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGwBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGwHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGwName, 'appGwFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGwName, 'appGwFrontendPort')
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGwName, 'appGwHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGwName, 'backendPool1')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGwName, 'appGwBackendHttpSettings')
          }
        }
      }
    ]
  }
}
