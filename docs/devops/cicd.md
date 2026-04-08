# CI/CD na AWS

**CI/CD** (Integração Contínua / Entrega Contínua) é o conjunto de práticas que automatiza a construção, teste e implantação de aplicações.

## Fluxo Típico de CI/CD

```
Commit → Build → Test → Security Scan → Deploy (Staging) → Aprovação → Deploy (Prod)
```

## Serviços AWS para CI/CD

### AWS CodePipeline
Orquestrador de pipelines de entrega contínua totalmente gerenciado.

### AWS CodeBuild
Serviço gerenciado de build que compila código, executa testes e gera artefatos.

### AWS CodeDeploy
Serviço de implantação automática para EC2, Lambda e ECS.

## Exemplo: Pipeline com GitHub Actions + AWS

```yaml
# .github/workflows/deploy.yml
name: Deploy para AWS

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do código
        uses: actions/checkout@v4

      - name: Configurar credenciais AWS
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Login no Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build e push da imagem Docker
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          IMAGE_TAG: ${{ github.sha }}
        run: |
          docker build -t $ECR_REGISTRY/minha-app:$IMAGE_TAG .
          docker push $ECR_REGISTRY/minha-app:$IMAGE_TAG

      - name: Deploy no ECS
        run: |
          aws ecs update-service \
            --cluster meu-cluster \
            --service meu-servico \
            --force-new-deployment
```

## Estratégias de Deploy

| Estratégia | Descrição | Risco |
|------------|-----------|-------|
| **Rolling** | Substituição gradual das instâncias | Baixo |
| **Blue/Green** | Dois ambientes paralelos com troca de tráfego | Muito Baixo |
| **Canary** | Percentual do tráfego vai para a nova versão | Muito Baixo |
| **In-place** | Substituição direta (downtime possível) | Alto |

## Boas Práticas

!!! tip "Boas práticas de CI/CD"
    - **Nunca** faça deploy manual em produção
    - Mantenha os pipelines **rápidos** (< 10 minutos para feedback)
    - Execute testes de segurança (**SAST/DAST**) como parte do pipeline
    - Use **ambientes efêmeros** para testes de pull requests
    - Implemente **rollback automático** baseado em métricas de saúde
    - Armazene **segredos** no AWS Secrets Manager ou Parameter Store
