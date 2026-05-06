# Encontro 06 — Projeto 01: Site Estático no S3 com Terraform

---

**Duração:** 2h  
**Bloco:** Projeto Prático 1  
**Projeto associado:** `projeto-01-s3-site-estatico/`

---

## Objetivos do Encontro
- Provisionar um site estático no S3 com Terraform do zero ao ar
- Entender políticas de bucket e hospedagem estática
- Praticar o ciclo completo: código → apply → acesso → destroy
- Introduzir outputs e data sources

---

## Roteiro (2h)

| Tempo       | Atividade                                       |
| ----------- | ----------------------------------------------- |
| 0:00 – 0:10 | Revisão + dúvidas                               |
| 0:10 – 0:35 | Exposição: S3 como hosting estático + políticas |
| 0:35 – 0:50 | Walkthrough do código do Projeto 1              |
| 0:50 – 1:45 | Laboratório guiado: executar o Projeto 1        |
| 1:45 – 2:00 | Revisão coletiva + síntese                      |

---

## Conteúdo Expositivo

---

### 6.1 Amazon S3 para sites estáticos

---
S3 pode hospedar sites com HTML/CSS/JS **sem servidor** — é serverless por natureza:
- Altíssima disponibilidade (99,99%)
- Escalável automaticamente
- Custo baixíssimo (Free Tier: 5 GB + 20k GET/mês)
- Não suporta código server-side (Python, Node) — apenas arquivos estáticos

---

**Fluxo:**
```
Terraform cria bucket → configura website hosting → define policy pública → upload dos arquivos
```

---
### 6.2 Recursos Terraform envolvidos

---

```hcl
aws_s3_bucket                      # cria o bucket
aws_s3_bucket_public_access_block  # libera acesso público
aws_s3_bucket_website_configuration # ativa hosting estático
aws_s3_bucket_policy               # policy de leitura pública
aws_s3_object                      # faz upload de cada arquivo
```

---
### 6.3 Política de acesso público

---

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::NOME-DO-BUCKET/*"
  }]
}
```

> ⚠️ Essa política libera o bucket publicamente para leitura. Use APENAS para sites públicos intencionalmente.

---
### 6.4 O argumento `etag` nos uploads
---

```hcl
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.site.id
  key    = "index.html"
  source = "${path.module}/../site/index.html"
  content_type = "text/html"
  etag   = filemd5("${path.module}/../site/index.html")
}
```

---
O `etag = filemd5(...)` força o Terraform a re-fazer o upload quando o arquivo mudar — sem isso, o Terraform não detecta alterações no conteúdo do arquivo.

---

## Laboratório — Executando o Projeto 1

---

```bash
cd exemplos-treinamento-iac-aws/projeto-1-s3-site-estatico/terraform

terraform init

terraform plan

terraform apply
```

---
Após o apply, copie a URL do output `website_url` e acesse no navegador.

---
### Experimento: atualizar o site sem recriar a infra
1. Edite `site/index.html` — troque a cor, o texto, etc.
2. Execute `terraform apply"` novamente
3. Observe: apenas o arquivo muda (`~ update in-place`), o bucket não é recriado

---
### Verificar o estado
```bash
terraform show        # mostra o estado atual
terraform state list  # lista recursos gerenciados
```

---
### Destruir ao final
```bash
terraform destroy -var="bucket_name=iac-site-SEU-NOME-2024"
```

---

## Desafio (para quem terminar cedo)
Adicione um segundo arquivo `sobre.html` com uma página "Sobre o Projeto" e crie o `aws_s3_object` correspondente no `main.tf`. Faça o upload via `terraform apply`.

---

## Atividade para Casa
1. Personalize o `index.html` com seu nome e informações do grupo
2. Adicione uma variável `var.environment` e use como tag em todos os recursos
3. Pesquisa: o que é **CloudFront** e como ele complementaria este projeto?

---

## Referências
- AWS. *Hosting a Static Website on S3.* https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html
- Terraform. *aws_s3_bucket_website_configuration.* https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
