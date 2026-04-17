# Encontro 02 — Terraform no Learner Lab: Primeiros Recursos

---
**Duração:** 2h  
**Bloco:** Fundamentos  
**Ambiente:** AWS Academy Learner Lab

---

## Objetivos do Encontro
- Entender a sintaxe HCL (HashiCorp Configuration Language)
- Compreender o ciclo init → plan → apply → destroy
- Instalar e configurar o Terraform no terminal do Learner Lab
- Criar o primeiro recurso AWS (bucket S3) com Terraform dentro do Learner Lab
- Entender o state file e a role `LabRole` como substituta do usuário IAM

---

## Roteiro (2h)

| Tempo | Atividade |
|-------|-----------|
| 0:00 – 0:10 | Revisão do Encontro 1 + dúvidas da atividade de casa |
| 0:10 – 0:45 | Exposição: sintaxe HCL, providers, resources, variables, outputs |
| 0:45 – 1:05 | Exposição: ciclo de vida Terraform + state file |
| 1:05 – 1:50 | Laboratório: instalar Terraform no Learner Lab + criar S3 bucket |
| 1:50 – 2:00 | Síntese e dúvidas |

---

## Conteúdo Expositivo
---

### 2.1 Sintaxe HCL — HashiCorp Configuration Language

---
HCL é a linguagem dos arquivos `.tf`. Legível, declarativa e fortemente tipada.

**Estrutura básica de um projeto Terraform:**
```
meu-projeto/
├── main.tf        → recursos principais
├── variables.tf   → declaração de variáveis
├── outputs.tf     → valores a exibir após o apply
└── terraform.tfstate  → gerado automaticamente (não editar!)
```

---
**Blocos fundamentais:**

```hcl
# 1. terraform — configura a versão e os providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. provider — configura a região AWS
provider "aws" {
  region = "us-east-1"
}

# 3. resource — declara um recurso na AWS
resource "aws_s3_bucket" "meu_bucket" {
  bucket = "meu-bucket-iac-2024"

  tags = {
    Name    = "Bucket do Lab"
    Turma   = "IAC-AWS"
  }
}

# 4. variable — valor configurável
variable "bucket_name" {
  description = "Nome único do bucket S3"
  type        = string
}

# 5. output — exibe um valor após o apply
output "bucket_arn" {
  value = aws_s3_bucket.meu_bucket.arn
}
```

---
**Regra de nomenclatura dos resources:**
```
resource "TIPO_DO_RECURSO" "NOME_LOCAL" { ... }
         ↑                  ↑
     tipo na AWS        identificador interno
   (aws_s3_bucket)       (qualquer nome)
```
---
Referência a outro recurso:
```hcl
# Para referenciar o ARN do bucket acima:
aws_s3_bucket.meu_bucket.arn
# TIPO.NOME_LOCAL.ATRIBUTO
```
---
### 2.2 Ciclo de Vida Terraform
---

```
1. terraform init
   └── Baixa o provider AWS (~50 MB)
   └── Inicializa o diretório de trabalho

2. terraform fmt
   └── Formata o código automaticamente

3. terraform validate
   └── Valida sintaxe sem acessar a AWS

4. terraform plan
   └── Calcula o que será criado/modificado/destruído
   └── Mostra um "diff" da infraestrutura

5. terraform apply
   └── Executa as mudanças na AWS
   └── Cria o arquivo terraform.tfstate

6. terraform destroy
   └── Remove TODOS os recursos gerenciados
   └── ⚠️ Executar ao final de cada laboratório
```

---
**Símbolos no output do plan:**
```
+ create   → será criado
~ update   → será atualizado in-place
- destroy  → será destruído
-/+ replace → será destruído e recriado
```

---
### 2.3 State File — O inventário do Terraform
---

O `terraform.tfstate` é um arquivo JSON que mapeia:
```
Código .tf  ←→  Recursos reais na AWS
```

- Nunca edite manualmente
- Deve ser compartilhado em times (via S3 + DynamoDB — veremos em encontros avançados)
- No Learner Lab: fica local no terminal; **não é perdido entre sessões** se o arquivo existir no mesmo diretório
---
### 2.4 Diferença crucial no Learner Lab: sem `aws configure`
---
Em uma conta AWS normal, você executa `aws configure` para informar Access Key e Secret Key de um usuário IAM. No Learner Lab isso **não é necessário nem possível** da forma tradicional.

---
O Learner Lab já configura automaticamente as credenciais via **variáveis de ambiente** ao iniciar a sessão:

```bash
# Já estão configuradas automaticamente no terminal do Learner Lab:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN   ← obrigatório no Learner Lab, diferente de conta normal
AWS_DEFAULT_REGION
```

---

O Terraform detecta essas variáveis automaticamente — **não é preciso configurar nada**.

> ⚠️ Se usar o terminal da sua máquina local em vez do terminal do Learner Lab, copiar as credenciais do painel (botão "AWS CLI") e exportar as três variáveis antes de rodar o Terraform.
---

### 2.5 A role `LabRole` — substituta de roles IAM customizadas
---
Como não é possível criar IAM Roles no Learner Lab, todos os recursos que precisam de uma role (EC2 Instance Profile, por exemplo) devem usar a `LabRole` já existente:

```hcl
# ❌ NÃO funciona no Learner Lab:
resource "aws_iam_role" "minha_role" { ... }

# ✅ Funciona no Learner Lab — referenciar a LabRole existente:
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_iam_instance_profile" "lab" {
  name = "LabInstanceProfile"
  role = data.aws_iam_role.lab_role.name
}
```

---

## Laboratório 2 — Instalando Terraform e Criando o Primeiro Recurso

---
### Objetivo
Instalar o Terraform no terminal do Learner Lab e criar um bucket S3 gerenciado por código.

---
### Passo 1: Iniciar o Learner Lab
```
Academy LMS → Modules → Learner Lab → Start Lab
Aguardar ponto verde → terminal integrado à esquerda do console
```

---
### Passo 2: Instalar o Terraform no terminal do Learner Lab

---
O terminal do Learner Lab usa Amazon Linux. O Terraform não vem instalado — instalar assim:

```bash
# Método direto (binário)
wget -q https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip terraform_1.7.5_linux_amd64.zip

# Verificar
terraform version
# Saída esperada: Terraform v1.7.5
```
---
> **Atenção:** a instalação precisa ser feita a **cada nova sessão do Learner Lab** porque o terminal é redefinido. Salvar esse bloco de instalação para reutilizar nos próximos encontros.
---
### Passo 3: Verificar as credenciais (já configuradas)
---

```bash
# Verificar que as credenciais estão ativas
aws sts get-caller-identity

```

---
### Passo 4: Criar o diretório e o código Terraform

---
```bash
mkdir ~/lab-02-s3 && cd ~/lab-02-s3
```

---
Criar o arquivo `main.tf`:
```bash
cat > main.tf << 'EOF'
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "lab" {
  bucket = var.bucket_name

  tags = {
    Name    = "Lab IAC - 02"
    Turma   = "devops-epic-aws-iac"
    Aluno   = "seu-nome"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.lab.id
}

output "bucket_arn" {
  value = aws_s3_bucket.lab.arn
}
EOF
```
---
Criar o arquivo `variables.tf`:
```bash
cat > variables.tf << 'EOF'
variable "bucket_name" {
  description = "Nome único global do bucket (deve ser único em toda a AWS)"
  type        = string
}
EOF
```
---
### Passo 5: Executar o ciclo completo

```bash
# 1. Inicializar (baixa o provider AWS)
../terraform init

../terraform plan -var="bucket_name=lab-iac-SEU-NOME"

# Observe o output:
# + create  aws_s3_bucket.lab
# Plan: 1 to add, 0 to change, 0 to destroy.

# 3. Aplicar
../terraform apply -var="bucket_name=lab-iac-SEU-NOME"
# Digite "yes" quando solicitado

# 4. Verificar — listar buckets da conta
aws s3 ls
```
---
### Passo 6: Inspecionar o state file

```bash
# Ver o conteúdo do state
cat terraform.tfstate

# Listar recursos gerenciados
../terraform state list

# Ver detalhes de um recurso específico
../terraform state show aws_s3_bucket.lab
```
---
### Passo 7: Experimento — alterar um atributo
---
Editar `main.tf` e adicionar uma nova tag:
```hcl
tags = {
  Name    = "Lab IAC"
  Turma   = "IAC-AWS"
  Aluno   = "seu-nome"
  Projeto = "encontro-02"    # ← nova linha
}
```

```bash
../terraform plan -var="bucket_name=lab-iac-SEU-NOME"
# Observe: ~ update in-place (não recria o bucket, só altera a tag)

../terraform apply -var="bucket_name=lab-iac-SEU-NOME"
```
---
### Passo 8: Destruir ao final ⚠️

```bash
../terraform destroy -var="bucket_name=lab-iac-SEU-NOME"
# Digite "yes"

# Confirmar que não há mais buckets
aws s3 ls
```

---

## Script de inicialização rápida (salvar para próximas sessões)
---
Como o Terraform precisa ser reinstalado a cada sessão, criar um script de setup:

```bash
cat > ~/setup-terraform.sh << 'EOF'
#!/bin/bash
echo "Instalando Terraform..."
wget -q https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip -q terraform_1.7.5_linux_amd64.zip
echo "Terraform instalado: $(terraform version)"
echo "Credenciais ativas: $(aws sts get-caller-identity --query Arn --output text)"
EOF

chmod +x ~/setup-terraform.sh
```
---
Nos próximos encontros, basta executar:
```bash
~/setup-terraform.sh
```
---
## Bucket Policy

```bash
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::lab-iac-uiuq/*"
    }
  ]
}
```
---

## Atividade para Casa
1. Execute novamente o lab em uma nova sessão: inicie o Learner Lab, rode o script de setup, recrie o bucket e destrua
2. Adicione um `output` que exiba a região onde o bucket foi criado: `aws_s3_bucket.lab.region`
3. Pesquisa: o que é **Terraform drift**? Como o comando `terraform plan` ajuda a detectá-lo?
4. Pesquisa: o que é um **backend remoto** no Terraform e por que times usam S3 + DynamoDB?

---

## Resumo das diferenças Learner Lab vs. Conta AWS Normal

| Ponto                            | Conta Normal                              | Learner Lab                                         |
| -------------------------------- | ----------------------------------------- | --------------------------------------------------- |
| Autenticação                     | `aws configure` com Access Key permanente | Credenciais temporárias automáticas (Session Token) |
| Criar usuários IAM               | Sim                                       | Não                                                 |
| Criar roles IAM                  | Sim                                       | Não — usar `LabRole` existente                      |
| Terraform instalado              | Depende da máquina                        | Não — instalar a cada sessão                        |
| Estado do ambiente entre sessões | Persistente                               | Recursos persistem; terminal reinicia               |
| IP público da EC2                | Fixo (Elastic IP) ou dinâmico             | Muda ao reiniciar a sessão                          |
| Custo                            | Pago ou Free Tier                         | Crédito US$ 100 por aluno                           |

---

## Referências
- HashiCorp. *Terraform Language Documentation.* https://developer.hashicorp.com/terraform/language
- HashiCorp. *AWS Provider.* https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- AWS Academy. *Learner Lab Restrictions.* Disponível no README do próprio ambiente (botão "Readme" no Learner Lab)
