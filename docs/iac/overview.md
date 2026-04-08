# Infraestrutura como Código

**Infraestrutura como Código (IaC)** é a prática de gerenciar e provisionar infraestrutura por meio de arquivos de configuração legíveis por máquinas, em vez de processos manuais.

## Por que IaC?

| Benefício | Descrição |
|-----------|-----------|
| **Reprodutibilidade** | Mesma infraestrutura em dev, staging e prod |
| **Versionamento** | Histórico de mudanças via Git |
| **Automação** | Provisionamento sem intervenção manual |
| **Documentação viva** | O código é a documentação da infraestrutura |
| **Redução de erros** | Elimina configurações manuais inconsistentes |

## Ferramentas cobertas neste treinamento

### Terraform
Ferramenta open-source da HashiCorp, agnóstica de nuvem, com linguagem declarativa (HCL).

→ [Ver módulo Terraform](terraform.md)

### AWS CDK (Cloud Development Kit)
Framework da AWS que permite definir infraestrutura usando linguagens de programação (TypeScript, Python, Java, etc.).

→ [Ver módulo AWS CDK](cdk.md)

## Comparativo

| Característica | Terraform | AWS CDK |
|----------------|-----------|---------|
| Linguagem | HCL (declarativa) | TypeScript, Python, Java, C# |
| Provedor | Multi-cloud | Primariamente AWS |
| State management | Arquivo de estado (.tfstate) | CloudFormation |
| Curva de aprendizado | Moderada | Depende da linguagem |
