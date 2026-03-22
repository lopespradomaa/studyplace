# IAC-POC — Laboratório de Infrastructure as Code

Laboratório prático para aprender e praticar IaC com Terraform e Ansible,
usando Hyper-V como hypervisor local e Azure como nuvem alvo.

## Arquitetura

```
Windows Host (firewall/NAT)
└── Hyper-V
    └── VM de Controle (172.16.0.10) — AlmaLinux / RHEL
        └── Docker Compose
            ├── contêiner terraform → provisiona recursos no Azure
            └── contêiner ansible  → configura VMs via SSH
```

## Pré-requisitos

- Windows 10/11 Pro ou Enterprise com Hyper-V habilitado
- PowerShell como Administrador
- ISO do AlmaLinux 9 ou RHEL 10
- Conta no Azure com créditos

## Estrutura do Projeto

```
iac-poc-v2/
├── host-docker/
│   ├── network-rhel.ps1        # Configura IP e conexão SSH
│   ├── docker-rhel.ps1         # Instalar e iniciar Docker
│   vhost-hyperv/
│   ├── network-vhost.sh        # Criar Hyper-V SW e Habilitar NAT
│   └── create-hyperv-rhel.sh   # Cria VM que hospeda o RHEL
├── docker/
│   ├── terraform/Dockerfile    # contêiner Terraform
│   └── ansible/Dockerfile      # contêiner Ansible
├── terraform/
│   ├── azure/                  # recursos no Azure
│   └── hyperv/                 # recursos locais no Hyper-V
├── ansible/
│   ├── inventory/              # inventário de servidores
│   ├── playbooks/              # playbooks de configuração
│   └── roles/                  # roles reutilizáveis
├── docs/                       # documentação
├── .gitignore
└── README.md
```

## Como usar

### 1. Configurar a rede no Hyper-V (Windows — PowerShell Admin)

```powershell
. .\powershell\network_setup.ps1
Setup-Network
```

### 2. Criar a VM de controle

```powershell
. .\powershell\vm_management.ps1
New-LabVM -VMName "vm-controle" -ISOPath "C:\ISOs\AlmaLinux.iso"
```

### 3. Após instalar o SO — configurar a VM (dentro da VM)

```bash
sudo ./scripts/configure_network.sh eth0 172.16.0.10 172.16.0.1 8.8.8.8
sudo ./scripts/setup_environment.sh
```

### 4. Subir os contêineres

```bash
cd ~/iac-poc
docker compose up -d
```

## Rede do Lab

| Host | IP | Papel |
|---|---|---|
| Windows Host | 172.16.0.1 | Gateway / NAT / Firewall |
| VM Controle | 172.16.0.10 | Terraform + Ansible |

## Roadmap

- [x] Rede isolada no Hyper-V (NAT + switch interno)
- [x] VM de controle com RHEL/AlmaLinux
- [x] Docker instalado e funcionando
- [x] SSH com autenticação por chave Ed25519
- [ ] Contêiner Terraform
- [ ] Contêiner Ansible
- [ ] Primeiro recurso provisionado no Azure
- [ ] Primeiro playbook Ansible
- [ ] Pipeline completo: Terraform + Ansible

## Segurança

- Nunca commitar credenciais (`.tfvars`, chaves SSH, tokens)
- Usar Azure Key Vault para secrets em produção
- SSH apenas por chave — senha desabilitada após configuração

## Certificações alvo

- RHCSA (EX200) — Red Hat Certified System Administrator
