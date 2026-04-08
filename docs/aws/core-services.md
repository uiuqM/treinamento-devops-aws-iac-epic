# Serviços Principais da AWS

Conheça os serviços AWS mais utilizados em ambientes DevOps.

## Computação

### Amazon EC2
Máquinas virtuais (instâncias) na nuvem.

```bash
# Listar instâncias EC2
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType]' --output table
```

### AWS Lambda
Execução de código sem servidor (serverless).

### Amazon ECS / EKS
Orquestração de contêineres com Docker (ECS) ou Kubernetes (EKS).

## Armazenamento

### Amazon S3
Armazenamento de objetos altamente durável e escalável.

```bash
# Criar bucket S3
aws s3 mb s3://meu-bucket-treinamento

# Listar objetos
aws s3 ls s3://meu-bucket-treinamento
```

### Amazon EBS
Volumes de armazenamento em bloco para instâncias EC2.

## Rede

### Amazon VPC
Rede virtual privada isolada na AWS.

```
VPC (10.0.0.0/16)
├── Subnet Pública  (10.0.1.0/24)  ─── Internet Gateway
└── Subnet Privada  (10.0.2.0/24)  ─── NAT Gateway
```

### AWS IAM
Controle de acesso e identidade.

```bash
# Criar política IAM
aws iam create-policy \
  --policy-name MinhaPolicy \
  --policy-document file://policy.json
```

## Monitoramento

### Amazon CloudWatch
Métricas, logs e alarmes para seus recursos AWS.

```bash
# Ver logs de um grupo
aws logs tail /aws/lambda/minha-funcao --follow
```
