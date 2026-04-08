# Visão Geral de DevOps

**DevOps** é uma cultura e conjunto de práticas que une desenvolvimento de software (Dev) e operações de TI (Ops) para encurtar o ciclo de desenvolvimento e entregar software com maior qualidade e frequência.

## Pilares do DevOps

```
  Cultura → Automação → Medição → Compartilhamento
```

| Pilar | Descrição |
|-------|-----------|
| **Cultura** | Colaboração entre Dev e Ops, responsabilidade compartilhada |
| **Automação** | CI/CD, IaC, testes automatizados |
| **Medição** | Métricas, monitoramento, observabilidade |
| **Compartilhamento** | Conhecimento, ferramentas e boas práticas |

## Práticas Essenciais

- **Integração Contínua (CI)**: integrar código frequentemente com validação automática
- **Entrega Contínua (CD)**: entregar software em qualquer momento com confiança
- **Infraestrutura como Código (IaC)**: infraestrutura versionada e automatizada
- **Monitoramento e Observabilidade**: visibilidade total do sistema em produção
- **Segurança Shift-Left**: incorporar segurança desde o início do ciclo

## Ferramentas no Ecossistema AWS

| Categoria | Serviço AWS |
|-----------|-------------|
| Controle de versão | AWS CodeCommit / GitHub |
| CI/CD | AWS CodePipeline, CodeBuild, CodeDeploy |
| Contêineres | Amazon ECS, EKS, ECR |
| Monitoramento | CloudWatch, X-Ray |
| Segurança | IAM, Secrets Manager, Inspector |
| IaC | CloudFormation, AWS CDK, Terraform |

!!! info "AWS DevOps Competency"
    A AWS oferece a certificação **AWS DevOps Engineer – Professional** que valida o conhecimento nessas práticas.
