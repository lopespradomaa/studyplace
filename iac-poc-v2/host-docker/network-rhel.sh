# Configura a rede e conexão SSH
# Requisitos: Terminal da VM
# -----------------------------------------------------------------------------

# Verificar interface de rede disponivel
nmcli device status

# Configurar IP estatico
# Substitua <interface> pelo nome exibido acima (ex: eth0)

sudo nmcli con mod <interface> \
    ipv4.addresses <vm-ip>/24 \
    ipv4.gateway   <gateway-ip> \
    ipv4.dns       8.8.8.8 \
    ipv4.method    manual

sudo nmcli con up <interface>

# Testar conectividade
ping -c 4 8.8.8.8


# Gerar par de chaves na VM
ssh-keygen -t ed25519
# Salvo em: ~/.ssh/id_ed25519 (privada) e ~/.ssh/id_ed25519.pub (publica)

# Exibir chave publica da VM
cat ~/.ssh/id_ed25519.pub

# Autorizar chave publica do Windows na VM
# Cole a chave obtida com: cat $env:USERPROFILE\.ssh\id_ed25519.pub
echo "<ssh-public-key>" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Verificar authorized_keys
cat ~/.ssh/authorized_keys
