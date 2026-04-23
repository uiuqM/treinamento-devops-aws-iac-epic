# Encontro 04 — IAM e EC2 com Terraform
---
**Duração:** 2h  
**Bloco:** Computação e Identidade  
**Projeto associado:** Base para o Projeto 2

---

## Objetivos do Encontro
- Entender o modelo de identidade e acesso da AWS (IAM)
- Criar usuários, roles e policies com Terraform
- Provisionar uma instância EC2 e conectar via SSH
- Entender AMIs, key pairs e user_data

---

## Roteiro (2h)

| Tempo       | Atividade                                          |
| ----------- | -------------------------------------------------- |
| 0:00 – 0:10 | Revisão + correção da atividade de casa            |
| 0:10 – 0:40 | Exposição: IAM — usuários, grupos, roles, policies |
| 0:40 – 1:00 | Exposição: EC2 — AMI, key pair, user_data          |
| 1:00 – 1:50 | Laboratório: EC2 com Terraform + acesso SSH        |
| 1:50 – 2:00 | Síntese e dúvidas                                  |

---

## Conteúdo Expositivo
---
### 4.1 IAM — Identity and Access Management
---
IAM controla **quem pode fazer o quê** na AWS.

| Conceito   | Descrição                                               |
| ---------- | ------------------------------------------------------- |
| **User**   | Pessoa ou sistema com credenciais de longo prazo        |
| **Group**  | Conjunto de users com as mesmas permissões              |
| **Role**   | Identidade temporária assumida por serviços ou usuários |
| **Policy** | Documento JSON que define permissões (Allow/Deny)       |

---
**Princípio do menor privilégio:** conceda apenas as permissões estritamente necessárias.

```json
// Exemplo de policy: somente leitura no S3
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:ListBucket"],
    "Resource": "*"
  }]
}
```

---
### 4.2 EC2 — Elastic Compute Cloud

---
**Conceitos-chave:**

| Conceito          | Descrição                                         |
| ----------------- | ------------------------------------------------- |
| **AMI**           | Imagem de máquina (SO + software pré-instalado)   |
| **Instance Type** | Combinação de CPU, memória, rede (ex: t2.micro)   |
| **Key Pair**      | Par de chaves SSH para acesso à instância         |
| **user_data**     | Script executado automaticamente no primeiro boot |
| **EBS**           | Disco virtual acoplado à EC2                      |

---
**Free Tier EC2:**
- `t2.micro` ou `t3.micro` — 750 horas/mês por 12 meses
- 30 GB de EBS gp2/gp3
---
### 4.3 user_data — bootstrap automático
```hcl
resource "aws_instance" "web" {
  # ...
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
}
```
O script roda como root no primeiro boot — ideal para instalar Docker, clonar repos, etc.

---

## Laboratório — EC2 com Terraform

### Passo 1: Gerar par de chaves SSH
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/lab-iac
# Gera: ~/.ssh/lab-iac (privada) e ~/.ssh/lab-iac.pub (pública)
```
---
### Passo 2: Terraform

Crie `main.tf` (reuse a VPC do encontro anterior ou crie nova):
```hcl
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

# --- Rede (simplificada) ---
resource "aws_vpc" "lab" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-ec2-lab"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab.id
}

resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.rt.id
}

# --- Security Group ---
resource "aws_security_group" "ec2" {
  name   = "sg-ec2-lab"
  vpc_id = aws_vpc.lab.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- Key Pair ---
resource "aws_key_pair" "lab" {
  key_name   = "chave-lab-iac"
  public_key = file("~/.ssh/lab-iac.pub")
}

# --- AMI mais recente Amazon Linux 2023 ---
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# --- EC2 ---
resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.publica.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.lab.key_name

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>EC2 via Terraform - IAC AWS</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "ec2-lab-iac"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ssh_cmd" {
  value = "ssh -i ~/.ssh/lab-iac ec2-user@${aws_instance.web.public_ip}"
}

output "http_url" {
  value = "http://${aws_instance.web.public_ip}"
}
```
---
```bash
terraform apply

# Conectar via SSH
ssh -i ~/.ssh/lab-iac ec2-user@<IP_DO_OUTPUT>

# Testar Nginx
curl http://<IP_DO_OUTPUT>

# DESTRUIR ao final
terraform destroy
```

---

## Atividade para Casa
1. Adicione ao `user_data` a instalação do **Docker** (além do Nginx)
2. Crie uma **IAM Role** com policy `AmazonS3ReadOnlyAccess` e associe à EC2 via `iam_instance_profile`
3. Pesquisa: qual a diferença entre **key pair** e **SSM Session Manager** para acesso a instâncias EC2?

---

## Referências
- AWS. *Amazon EC2 Documentation.* https://docs.aws.amazon.com/ec2/
- AWS. *IAM Best Practices.* https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
- Terraform. *aws_instance resource.* https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
