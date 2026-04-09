# Encontro 01 — O que é IaC? Conhecendo o AWS Academy Learner Lab

**Duração:** 2h  
**Bloco:** Fundamentos  
**Ambiente:** AWS Academy Learner Lab

---

## Objetivos do Encontro
- Compreender o conceito de Infraestrutura como Código e por que ele surgiu
- Diferenciar abordagem imperativa vs. declarativa
- Conhecer o AWS Academy Learner Lab e suas características específicas
- Realizar o primeiro acesso ao console AWS pelo Learner Lab
- Entender as limitações e boas práticas do ambiente de laboratório

---

## Roteiro (2h)

| Tempo | Atividade |
|-------|-----------|
| 0:00 – 0:15 | Apresentação do curso, objetivos, avaliação e regras do Lab |
| 0:15 – 0:50 | Exposição: O que é IaC e por que usar |
| 0:50 – 1:10 | Exposição: Panorama de ferramentas — onde o Terraform se encaixa |
| 1:10 – 1:50 | Laboratório guiado: primeiro acesso ao AWS Academy Learner Lab |
| 1:50 – 2:00 | Síntese, dúvidas e orientações para o próximo encontro |

---

## Conteúdo Expositivo

### 1.1 O problema antes da IaC

Antes da IaC, servidores eram configurados manualmente — o chamado **"ClickOps"**:

- Passos executados no console sem documentação → impossível reproduzir
- Ambientes diferentes entre dev, staging e produção → bugs que só aparecem em prod
- Tempo longo para criar novos ambientes
- Erro humano constante

**Frase que resume o problema:**
> "Funciona na minha máquina" — e na produção não.

### 1.2 O que é IaC

IaC é a prática de **definir e gerenciar infraestrutura através de arquivos de código**, tratando servidores, redes e bancos da mesma forma que tratamos código de aplicação:

| Característica | Como o código de IaC resolve |
|----------------|------------------------------|
| Reprodutibilidade | Mesmo arquivo → mesmo ambiente em qualquer conta |
| Rastreabilidade | Histórico de mudanças no Git |
| Velocidade | Provisionar em minutos com um comando |
| Colaboração | Pull Requests revisam mudanças de infra |
| Redução de drift | Infraestrutura sempre igual ao que está descrito |

### 1.3 Imperativo vs. Declarativo

| Abordagem | Descrição | Analogia |
|-----------|-----------|----------|
| **Imperativa** | Você diz *como* fazer passo a passo | Receita de bolo com cada etapa |
| **Declarativa** | Você diz *o que* quer; a ferramenta resolve o como | Pedir uma pizza sem especificar a rota do entregador |

Terraform é **declarativo**: você descreve o estado desejado e ele calcula o que precisa criar, alterar ou destruir para chegar lá.

### 1.4 Panorama de ferramentas

| Ferramenta | Tipo | Foco |
|------------|------|------|
| **Terraform** | IaC declarativa | Multi-cloud (AWS, GCP, Azure…) |
| AWS CloudFormation | IaC declarativa | Somente AWS |
| Ansible | Gerenciamento de configuração | Configuração pós-provisionamento |
| Pulumi | IaC em linguagem de programação | Multi-cloud |
| AWS CDK | IaC em linguagem real (Python, TypeScript) | AWS |

> Neste curso usamos **Terraform** por ser multi-cloud, com ampla adoção no mercado e documentação excelente.

---

## AWS Academy Learner Lab — O que é e como funciona

### O ambiente de vocês

No lugar de uma conta AWS pessoal com cartão de crédito, cada aluno recebe um **ambiente isolado** dentro do AWS Academy:

```
AWS Academy LMS (portal do curso)
└── Learner Lab (ambiente de cada aluno)
    ├── Console AWS completo (100+ serviços)
    ├── Terminal CLI integrado
    ├── Créditos: US$ 100 por aluno
    └── Painel de gasto em tempo real
```

### Como iniciar uma sessão

1. Acessar [awsacademy.com/LMS_Login](https://www.awsacademy.com/LMS_Login) → **Student Login**
2. Dentro do curso → **Modules** → **Learner Lab**
3. Clicar em **Start Lab**
4. Aguardar o ponto ficar **verde** (≈ 1–2 minutos)
5. Clicar em **AWS** para abrir o console

```
🔴 Vermelho  → Lab parado
🟡 Amarelo   → Iniciando
🟢 Verde     → Pronto para uso
```

### Sessão de laboratório — regras importantes

| Item | Detalhe |
|------|---------|
| **Duração da sessão** | 4 horas por padrão |
| **Estender** | Clicar em **Start Lab** novamente reinicia o timer |
| **Encerrar** | Botão **End Lab** — instâncias EC2 são paradas (não deletadas) |
| **Retomar** | Ao iniciar nova sessão, os recursos criados estão lá; EC2 reinicia automaticamente |
| **Reset** | ⚠️ **NUNCA usar** — apaga tudo e não recupera créditos |
| **IP público da EC2** | Pode mudar ao reiniciar a sessão — sempre verificar o novo IP |

### Créditos e orçamento

- Cada aluno tem **US$ 100** de crédito
- O painel exibe quanto foi consumido (atualiza a cada ~8h)
- RDS e NAT Gateway **continuam rodando mesmo com a sessão encerrada** → sempre parar esses recursos antes de encerrar
- EC2 é parada automaticamente ao encerrar a sessão

### Limitações do Learner Lab (diferenças de uma conta normal)

Esta informação é fundamental para adaptar os roteiros de laboratório:

| Limitação | Impacto no curso | Solução |
|-----------|-----------------|---------|
| **Não é possível criar usuários IAM** | Não usamos `aws configure` com chave de usuário | Usar a **role `LabRole`** já disponível no ambiente |
| **Não é possível criar IAM Roles customizadas** | Terraform não pode criar roles novas | Referenciar a `LabRole` existente no código Terraform |
| **Máximo de 20 EC2 simultâneas** | Não é problema para o curso | Sempre destruir recursos após cada lab |
| **Máximo de 32 vCPUs** | Não é problema usando t2.micro | Usar apenas instâncias t2.micro ou t3.micro |
| **Credenciais temporárias** | Mudam a cada sessão | Usar credenciais do painel do Lab, não configurar manualmente |
| **IP público da EC2 muda entre sessões** | URLs e SSH mudam | Verificar IP novo ao início de cada sessão |

### Como obter credenciais para o Terminal / CLI

No painel do Learner Lab, há um botão **"AWS CLI"** que exibe:
```
AWS Access Key ID:     ASIA...
AWS Secret Access Key: xxxx...
AWS Session Token:     xxxx... (obrigatório no Learner Lab)
```

Para usar no terminal do próprio Learner Lab (já configurado automaticamente) ou copiar para sua máquina local.

> **Dica:** o terminal integrado no Learner Lab já vem com AWS CLI e as credenciais configuradas. Para os labs iniciais, usem o terminal do próprio Learner Lab — é mais simples.

---

## Laboratório 1 — Primeiro Acesso e Exploração do Console

### Objetivo
Cada aluno realiza o primeiro acesso ao Learner Lab e explora o ambiente.

### Passo 1: Aceitar o convite
- Verificar e-mail com assunto: *"Your AWS Academy Course Invitation"* (remetente: `notifications@instructure.com`)
- Clicar em **Get Started** e definir senha

### Passo 2: Acessar o Learner Lab
```
1. Acessar: awsacademy.com/LMS_Login
2. Student Login → usar e-mail do convite
3. Selecionar o curso na dashboard
4. Modules → Learner Lab → Start Lab
5. Aguardar ponto verde → clicar em AWS
```

### Passo 3: Explorar o Console AWS
Com o console aberto, verificar:
```
1. Qual região está selecionada? (canto superior direito)
   → Sempre usar: us-east-1 (N. Virginia)

2. Serviços disponíveis: EC2, S3, RDS, VPC, IAM, CloudWatch
   → Clicar em cada um para ver a interface

3. IAM → Roles → pesquisar "LabRole"
   → Essa role é usada em todos os labs no lugar de criar novas roles
```

### Passo 4: Testar o terminal integrado
No painel do Learner Lab, há um terminal à esquerda. Executar:
```bash
# Verificar identidade da sessão
aws sts get-caller-identity

# Saída esperada (os números serão diferentes):
# {
#   "UserId": "AROA...",
#   "Account": "123456789012",
#   "Arn": "arn:aws:sts::123456789012:assumed-role/vocstartsoft/..."
# }
```

### Passo 5: Verificar o orçamento disponível
No topo do painel do Learner Lab, observar:
- **AWS:** crédito total e usado
- **Tempo restante na sessão**

### Passo 6: Encerrar a sessão corretamente
```
Botão "End Lab" → confirmar
```
Observar que nenhum recurso foi criado ainda — esta sessão foi apenas de exploração.

---

## Atividade para Casa
1. Assistir ao vídeo de orientação do Learner Lab disponível no portal do Academy
2. Explorar os 5 serviços que usaremos: EC2, S3, RDS, VPC, CloudWatch — anotar uma dúvida sobre cada
3. Ler: [Terraform — What is Infrastructure as Code?](https://developer.hashicorp.com/terraform/intro)

---

## Referências
- AWS Academy. *Learner Lab Student Guide.* https://josejuansanchez.org/iaw/taller-aws/resources/guia_aws_academy_learner_lab.pdf
- HashiCorp. *What is Infrastructure as Code?* https://developer.hashicorp.com/terraform/intro
- AWS. *Amazon Web Services Overview.* https://aws.amazon.com/what-is-aws/
