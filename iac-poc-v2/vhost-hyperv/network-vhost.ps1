# Prepara o ambiente de rede, simulando o vHost como Firewall
# utilizando NAT
# =============================================================================

# Criar switch interno
New-VMSwitch -SwitchName "<vswitch-lab>" -SwitchType Internal

# Configurar IP do gateway no host
New-NetIPAddress -IPAddress "<gateway-ip>" -PrefixLength 24 `
    -InterfaceAlias "vEthernet (<vswitch-lab>)"

# Criar NAT
New-NetNat -Name "<nat-lab>" -InternalIPInterfaceAddressPrefix "<gateway-ip>/24"
    
# Verificar
Get-VMSwitch
Get-NetNat
Get-NetIPAddress -InterfaceAlias "vEthernet (<vswitch-lab>)"