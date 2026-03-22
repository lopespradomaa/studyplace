# =============================================================================
# Prepara o ambiente de rede e criar a VM de controle no Hyper-V

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

# Criar a VM
New-VM `
    -Name               "<vm-docker-host>" `
    -Generation         2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath         "<path-to-vhdx>" `
    -NewVHDSizeBytes    40GB `
    -SwitchName         "<vswitch-lab>"

# Configurar CPU
Set-VMProcessor -VMName "<vm-docker-host>" -Count 2

# Desabilitar Secure Boot (obrigatorio para Linux)
Set-VMFirmware -VMName "<vm-docker-host>" -EnableSecureBoot Off

# Adicionar ISO
Add-VMDvdDrive -VMName "<vm-docker-host>" -Path "<path-to-iso>"

# Iniciar
$vm = Get-VM -Name "<vm-docker-host>"
Start-VM -VM $vm

# Conectar a VM
# Reque configurações no Red Hat Enterprise Linux

# Gerar chave SSH
ssh-keygen -t ed25519
cat $env:USERPROFILE\.ssh\id_ed25519.pub

#Conectar
ssh <vm-user>@<vm-ip>

