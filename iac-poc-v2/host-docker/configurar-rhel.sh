# Configura a rede, conexão SSH  e instala o Docker no host de controle
# Requisitos: executar dentro da VM <vm-docker-host>

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

# -----------------------------------------------------------------------------
# Instalação do Docker
# Adicionar repositorio oficial do Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

# Atualizar o sistema
sudo dnf update -y

# Instalar Docker
sudo dnf install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Habilitar e iniciar o servico
sudo systemctl enable docker --now
sudo systemctl status docker

# Adicionar usuario ao grupo docker
sudo usermod -aG docker <vm-user>
newgrp docker

# Instalar Git
sudo dnf install -y git

# Testar Docker
docker run hello-world
