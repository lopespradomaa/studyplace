# Criar a VM de controle no Hyper-V e conexão SSH
# =============================================================================

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

