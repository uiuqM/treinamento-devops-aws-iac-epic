# Visão Geral da AWS

A **Amazon Web Services (AWS)** é a plataforma de nuvem mais abrangente e amplamente adotada do mundo, oferecendo mais de 200 serviços gerenciados.

## Por que AWS?

- **Escalabilidade**: expanda ou reduza recursos conforme a demanda
- **Modelo pay-as-you-go**: pague apenas pelo que usar
- **Alcance global**: regiões e zonas de disponibilidade ao redor do mundo
- **Segurança**: conformidade com os principais padrões do mercado

## Estrutura Global

| Conceito | Descrição |
|----------|-----------|
| Região | Localização geográfica com múltiplas zonas de disponibilidade |
| Zona de Disponibilidade (AZ) | Data center(s) isolado(s) dentro de uma região |
| Edge Location | Ponto de presença para entrega de conteúdo (CloudFront) |

## Categorias de Serviços

- **Computação**: EC2, Lambda, ECS, EKS
- **Armazenamento**: S3, EBS, EFS, Glacier
- **Banco de Dados**: RDS, DynamoDB, ElastiCache, Aurora
- **Rede**: VPC, Route 53, CloudFront, API Gateway
- **Segurança**: IAM, KMS, Secrets Manager, WAF
- **Monitoramento**: CloudWatch, CloudTrail, X-Ray

!!! info "Região recomendada"
    Para os laboratórios deste treinamento, use a região **us-east-1 (N. Virginia)** para maximizar a disponibilidade de serviços.
