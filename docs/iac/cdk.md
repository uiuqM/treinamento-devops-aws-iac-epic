# AWS CDK

O **AWS Cloud Development Kit (CDK)** é um framework open-source que permite definir infraestrutura na AWS usando linguagens de programação familiares como TypeScript, Python, Java e C#.

## Conceitos Fundamentais

- **App**: ponto de entrada da aplicação CDK
- **Stack**: unidade de implantação (equivale a um stack CloudFormation)
- **Construct**: bloco de construção reutilizável (L1, L2, L3)
- **Synth**: processo de gerar o template CloudFormation a partir do código

## Níveis de Constructs

| Nível | Descrição | Exemplo |
|-------|-----------|---------|
| **L1** | Mapeamento direto de recursos CloudFormation | `CfnBucket` |
| **L2** | Abstrações com padrões e defaults sensatos | `Bucket` |
| **L3** | Padrões de alto nível (patterns) | `ApplicationLoadBalancedFargateService` |

## Estrutura de um Projeto CDK (TypeScript)

```
meu-projeto-cdk/
├── bin/
│   └── app.ts          # Ponto de entrada
├── lib/
│   └── meu-stack.ts    # Definição do stack
├── test/
│   └── meu-stack.test.ts
├── cdk.json            # Configuração do CDK
├── package.json
└── tsconfig.json
```

## Exemplo: Bucket S3 com TypeScript

```typescript
// lib/meu-stack.ts
import * as cdk from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';
import { Construct } from 'constructs';

export class MeuStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const bucket = new s3.Bucket(this, 'MeuBucket', {
      versioned: true,
      encryption: s3.BucketEncryption.S3_MANAGED,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });

    new cdk.CfnOutput(this, 'BucketName', {
      value: bucket.bucketName,
      description: 'Nome do bucket S3',
    });
  }
}

// bin/app.ts
import * as cdk from 'aws-cdk-lib';
import { MeuStack } from '../lib/meu-stack';

const app = new cdk.App();
new MeuStack(app, 'MeuStack', {
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});
```

## Comandos Principais

```bash
# Criar novo projeto CDK
cdk init app --language=typescript

# Listar stacks disponíveis
cdk list

# Sintetizar o template CloudFormation
cdk synth

# Comparar mudanças com o stack implantado
cdk diff

# Implantar o stack
cdk deploy

# Destruir o stack
cdk destroy

# Fazer bootstrap da conta/região (primeira vez)
cdk bootstrap aws://ACCOUNT_ID/REGION
```

## Boas Práticas

!!! tip "Boas práticas AWS CDK"
    - Use constructs L2 sempre que possível para aproveitar os defaults seguros
    - Escreva testes unitários para seus stacks com **Jest** ou **pytest**
    - Separe ambientes usando propriedades de contexto (`cdk.json`)
    - Use `cdk diff` antes de `cdk deploy` em produção
    - Faça bootstrap de cada conta/região antes do primeiro deploy
