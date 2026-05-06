# Projeto 1 — Site Estático no S3 com Terraform

## Objetivo
Provisionar um bucket S3 configurado para hospedagem de site estático usando Terraform.

## Estrutura
```
projects/01/
├── terraform/
│   ├── main.tf        # Recursos principais (S3, política, website)
│   ├── variables.tf   # Variáveis configuráveis
│   └── outputs.tf     # Saídas (URL do site)
└── site/
    ├── index.html     # Página principal
    └── error.html     # Página de erro 404
```

## Como usar

### 1. Inicializar o Terraform
```bash
cd terraform
terraform init
```

### 2. Planejar a infraestrutura
```bash
terraform plan"
```

### 3. Aplicar
```bash
terraform apply"
```

### 4. Acessar o site
Após o apply, o Terraform exibirá a URL. Exemplo:
```
website_url = "meu-site-treinamento.s3-website-us-east-1.amazonaws.com"
```

### 5. Destruir (evitar custos)
```bash
terraform destroy"
```

## ⚠️ Atenção — Free Tier
- S3 oferece **5 GB de armazenamento** e **20.000 requisições GET** gratuitas por mês.
- Execute `terraform destroy` ao final de cada laboratório.
