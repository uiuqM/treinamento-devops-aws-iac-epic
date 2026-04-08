# Terraform

O **Terraform** é uma ferramenta de IaC open-source desenvolvida pela HashiCorp que permite provisionar e gerenciar infraestrutura de forma declarativa usando a linguagem HCL (HashiCorp Configuration Language).

## Conceitos Fundamentais

- **Provider**: plugin que conecta o Terraform a um serviço (AWS, Azure, GCP, etc.)
- **Resource**: bloco que representa um recurso de infraestrutura
- **State**: arquivo que rastreia o estado atual da infraestrutura
- **Module**: conjunto reutilizável de recursos Terraform

## Ciclo de Vida

```
terraform init → terraform plan → terraform apply → terraform destroy
```

## Estrutura de um Projeto

```
projeto/
├── main.tf          # Recursos principais
├── variables.tf     # Declaração de variáveis
├── outputs.tf       # Saídas do módulo
├── versions.tf      # Versões do Terraform e providers
└── terraform.tfvars # Valores das variáveis (não commitar segredos!)
```

## Exemplo: Bucket S3

```hcl
# versions.tf
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# main.tf
provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# variables.tf
variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev/staging/prod)"
  type        = string
}

# outputs.tf
output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.example.arn
}
```

## Comandos Principais

```bash
# Inicializar o projeto (baixar providers)
terraform init

# Visualizar o plano de mudanças
terraform plan

# Aplicar as mudanças
terraform apply

# Destruir a infraestrutura
terraform destroy

# Formatar o código
terraform fmt

# Validar a configuração
terraform validate
```

## Boas Práticas

!!! tip "Boas práticas Terraform"
    - Armazene o **state** remotamente (S3 + DynamoDB para lock)
    - Use **módulos** para reutilizar código
    - Nunca commite o arquivo `.tfvars` com segredos
    - Use `terraform fmt` e `terraform validate` no CI/CD
    - Separe ambientes em workspaces ou diretórios distintos
