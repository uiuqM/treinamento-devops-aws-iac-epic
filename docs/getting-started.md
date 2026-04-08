# Início Rápido

Este guia ajuda você a configurar o ambiente necessário para os laboratórios do treinamento.

## 1. Configurar a AWS CLI

Instale a AWS CLI e configure suas credenciais:

```bash
# Instalar AWS CLI (Linux/macOS)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configurar credenciais
aws configure
```

## 2. Instalar o Terraform

```bash
# macOS (Homebrew)
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verificar instalação
terraform -version
```

## 3. Instalar o Node.js e AWS CDK

```bash
# Instalar Node.js (LTS)
# Acesse https://nodejs.org e baixe o instalador

# Instalar AWS CDK globalmente
npm install -g aws-cdk

# Verificar instalação
cdk --version
```

## 4. Clonar este repositório

```bash
git clone https://github.com/uiuqM/treinamento-devops-aws-iac-epic.git
cd treinamento-devops-aws-iac-epic
```

## 5. Verificar o ambiente

```bash
aws --version
terraform -version
cdk --version
```

!!! success "Pronto!"
    Com todas as ferramentas instaladas, você está pronto para começar o treinamento.
