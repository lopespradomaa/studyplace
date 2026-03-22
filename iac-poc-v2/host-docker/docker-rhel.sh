# Instalação do Docker
# -----------------------------------------------------------------------------

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
