# Encontro 03 — Rede na AWS: VPC, Subnets e Security Groups com Terraform
---

**Duração:** 2h  
**Bloco:** Fundamentos de Rede  
**Projeto associado:** Base para os Projetos 2 e 3

---

## Objetivos do Encontro
- Compreender o modelo de rede da AWS (VPC, subnets, gateways)
- Provisionar uma VPC completa com Terraform
- Criar e testar Security Groups
- Entender roteamento e acesso à internet

---

## Roteiro (2h)

| Tempo       | Atividade                                  |
| ----------- | ------------------------------------------ |
| 0:00 – 0:10 | Revisão + correção da atividade de casa    |
| 0:10 – 0:50 | Exposição: VPC, subnets, IGW, route tables |
| 0:50 – 1:05 | Exposição: Security Groups vs. NACLs       |
| 1:05 – 1:50 | Laboratório: VPC completa com Terraform    |
| 1:50 – 2:00 | Síntese e dúvidas                          |

---

## Conteúdo Expositivo

### 3.1 O que é uma VPC
**VPC (Virtual Private Cloud)** é uma rede privada virtual isolada dentro da AWS.
Tudo que você cria na AWS vive dentro de uma VPC.

```
AWS Region (us-east-1)
└── VPC (10.0.0.0/16)
    ├── Subnet Pública  (10.0.1.0/24)  → EC2 com IP público
    ├── Subnet Privada  (10.0.2.0/24)  → RDS, sem acesso direto
    └── Internet Gateway → rota para a internet
```

---
### 3.2 Componentes principais

| Componente                 | Função                                   |
| -------------------------- | ---------------------------------------- |
| **VPC**                    | Rede isolada — define o bloco CIDR geral |
| **Subnet**                 | Subdivisão da VPC em uma AZ específica   |
| **Internet Gateway (IGW)** | Permite tráfego entre a VPC e a internet |
| **Route Table**            | Define para onde vai cada faixa de IP    |
| **Security Group**         | Firewall a nível de instância (stateful) |
| **NACL**                   | Firewall a nível de subnet (stateless)   |

---
### 3.3 Subnet pública vs. privada

|                     | Pública               | Privada                       |
| ------------------- | --------------------- | ----------------------------- |
| Associada ao IGW?   | Sim                   | Não                           |
| EC2 com IP público? | Pode ter              | Não                           |
| Acesso à internet?  | Direto                | Via NAT Gateway               |
| Casos de uso        | EC2 de app, jump host | RDS, cache, serviços internos |

---
### 3.4 Security Groups
- Atuam como firewall **stateful** (a resposta de uma conexão permitida é automaticamente liberada)
- Regras de **ingress** (entrada) e **egress** (saída)
- Por padrão: todo ingress bloqueado, todo egress liberado
---

```hcl
resource "aws_security_group" "web" {
  name   = "sg-web"
  vpc_id = aws_vpc.main.id

  # Libera HTTP da internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Libera saída total
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---
## Glossário de Recursos — Encontro 3

Esta seção explica cada recurso AWS e Terraform utilizado neste encontro de forma detalhada.

---

### `aws_vpc`
**O que é:**  
A VPC (Virtual Private Cloud) é a sua rede privada dentro da AWS. Funciona como se fosse o roteador da sua casa, mas em escala corporativa: ela delimita um espaço de endereços IP exclusivo e isolado para os seus recursos. Nenhum recurso que você criar (EC2, RDS, Lambda) enxerga automaticamente recursos de outra VPC — o isolamento é total por padrão.

---
Imagine um condomínio fechado. A VPC é o terreno do condomínio — define os limites e o espaço total disponível. Tudo que existe dentro do condomínio (casas, ruas, portaria) vive dentro desse espaço.

---
**Argumento principal:**
```hcl
resource "aws_vpc" "lab" {
  cidr_block           = "10.0.0.0/16"   # Define o espaço total de IPs: 65.536 endereços
  enable_dns_hostnames = true             # Permite que EC2s recebam nome DNS automático
}
```
- `cidr_block`: notação CIDR define quantos IPs a VPC terá. `/16` = 65.536 IPs disponíveis para distribuir entre subnets.
- `enable_dns_hostnames`: quando `true`, cada EC2 criada na VPC recebe um nome como `ec2-54-123-45-67.compute-1.amazonaws.com`.

---
### `aws_subnet`
**O que é:**  
A Subnet é uma subdivisão da VPC. Se a VPC é o condomínio inteiro, as subnets são os blocos ou quadras dentro dele. Cada subnet existe dentro de uma única **Availability Zone (AZ)** — ou seja, dentro de um único datacenter físico da AWS.

---
**Por que dividir em subnets?**  
Organização e segurança. Recursos públicos (EC2 que atende à internet) ficam em subnets públicas. Recursos sensíveis (bancos de dados) ficam em subnets privadas, sem exposição direta à internet.

---
**Argumento principal:**
```hcl
resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.lab.id   # A qual VPC pertence
  cidr_block              = "10.0.1.0/24"   # 256 IPs dentro da VPC
  availability_zone       = "us-east-1a"    # AZ específica (datacenter)
  map_public_ip_on_launch = true            # EC2s criadas aqui recebem IP público automaticamente
}
```
- `cidr_block`: deve ser um subconjunto do CIDR da VPC. `10.0.1.0/24` cabe dentro de `10.0.0.0/16`.
- `map_public_ip_on_launch`: quando `true`, qualquer EC2 criada nessa subnet já nasce com IP público — é isso que torna a subnet "pública" do ponto de vista prático.

---

### `aws_internet_gateway`
**O que é:**  
O Internet Gateway (IGW) é a porta de entrada e saída da sua VPC para a internet pública. Sem ele, nenhum recurso dentro da VPC consegue se comunicar com o mundo externo — nem receber requisições nem fazer chamadas para fora.

---

Se a VPC é o condomínio, o IGW é o portão de entrada. Sem portão, ninguém entra nem sai.

**Argumento principal:**
```hcl
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab.id   # Associa o portão ao condomínio correto
}
```
- Um IGW só pode ser associado a uma VPC por vez.
- Criar o IGW não é suficiente — é preciso também criar uma rota na Route Table apontando para ele.
---
### `aws_route_table` e `aws_route_table_association`
**O que é:**  
A Route Table é a tabela de roteamento: uma lista de regras que diz "quando um pacote de rede tiver como destino o endereço X, enviá-lo para Y". Toda subnet precisa estar associada a uma Route Table para saber por onde o tráfego deve sair.

---
É o GPS da rede. Quando um pacote chega e precisa ir para a internet (`0.0.0.0/0`), a Route Table diz: "vá pelo Internet Gateway".

---
**Argumentos principais:**
```hcl
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"                    # "qualquer destino na internet"
    gateway_id = aws_internet_gateway.igw.id    # → sair pelo IGW
  }
}

# Associação: diz que a subnet usará esta Route Table
resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}
```
- `0.0.0.0/0` significa "qualquer endereço IP" — é a rota padrão (default route) para a internet.
- A **associação** é o que liga a subnet à tabela. Sem ela, a subnet usa a Route Table padrão da VPC, que não tem rota para a internet.

---

### `aws_security_group`
**O que é:**  
O Security Group é um firewall virtual que controla o tráfego de entrada (ingress) e saída (egress) de instâncias EC2, RDS e outros recursos. Diferente de um firewall tradicional, ele é **stateful**: se você permite uma conexão de entrada, a resposta de saída é automaticamente liberada, sem precisar de regra explícita.

---

É o segurança na porta de cada casa do condomínio. Ele verifica quem pode entrar (ingress) e para onde os moradores podem sair (egress).

**Comportamento padrão (sem regras customizadas):**
- Ingress: **tudo bloqueado**
- Egress: **tudo liberado**
---
**Argumentos principais:**
```hcl
resource "aws_security_group" "web" {
  name        = "sg-web-lab"
  description = "Permite SSH e HTTP"
  vpc_id      = aws_vpc.lab.id           # Deve estar na mesma VPC dos recursos

  # Regra de entrada: libera SSH (porta 22) de qualquer IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]          # 0.0.0.0/0 = qualquer IP (cuidado em produção!)
  }

  # Regra de saída: libera tudo
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                   # -1 = todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- `from_port` / `to_port`: definem o intervalo de portas. Para uma porta única, os dois têm o mesmo valor.
- `protocol`: `"tcp"`, `"udp"`, `"icmp"` ou `"-1"` (todos).
- Um recurso pode ter **múltiplos Security Groups** associados — as regras são combinadas (union).

---
## Laboratório — VPC Completa com Terraform

---
### Objetivo: Provisionar VPC + Subnet Pública + IGW + Route Table + SG

---
Crie `main.tf`:
```hcl
terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" { region = "us-east-1" }

# VPC
resource "aws_vpc" "lab" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "vpc-lab-iac" }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab.id
  tags   = { Name = "igw-lab" }
}

# Subnet Pública
resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "subnet-publica" }
}

# Route Table
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.lab.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "rt-publica" }
}

resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}

# Security Group
resource "aws_security_group" "web" {
  name        = "sg-web-lab"
  description = "Permite SSH e HTTP"
  vpc_id      = aws_vpc.lab.id

  ingress { from_port = 22;  to_port = 22;  protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 80;  to_port = 80;  protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress  { from_port = 0;   to_port = 0;   protocol = "-1";  cidr_blocks = ["0.0.0.0/0"] }

  tags = { Name = "sg-web-lab" }
}

output "vpc_id"    { value = aws_vpc.lab.id }
output "subnet_id" { value = aws_subnet.publica.id }
output "sg_id"     { value = aws_security_group.web.id }
```

---
```bash
terraform init && terraform apply
# Verifique os recursos no Console AWS: VPC → Sua VPC
terraform destroy
```

---

## Atividade para Casa
1. Adicione uma **subnet privada** (sem `map_public_ip_on_launch`) ao código
2. Crie um segundo Security Group que libere apenas a porta 5000 (Flask) vinda apenas do SG da web
3. Pesquisa: o que é **NAT Gateway** e quando ele é necessário?

---

## Referências
- AWS. *VPC Documentation.* https://docs.aws.amazon.com/vpc/latest/userguide/
- Terraform. *aws_vpc resource.* https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
