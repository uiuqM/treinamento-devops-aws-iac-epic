**DevOps e infraestrutura como Código na AWS**

**1\. Identificação**

**Instituição:** Universidade Federal do Tocantins (UFT)  
**Curso:** Bacharelado em Ciência da Computação
**Projeto:** Infraestrutura como Código em AWS com Terraform e Docker  
**Carga Horária:** 24 horas (12 encontros semanais de 2h)  
**Pré-requisitos:** Engenharia de Software, Sistemas Operacionais e Redes de computadores  
**Instrutor:** Wilque Muriel Do Nascimento Coelho  
**Período Letivo:**2026.1

---

**2\. Ementa**

Infraestrutura como Código (IaC) aplicada a ambientes em nuvem usando Terraform e AWS Academy. Provisionamento automatizado de recursos AWS mais utilizados: VPC, Security Groups, EC2, S3, RDS/DynamoDB, IAM e CloudWatch, respeitando limites e créditos gratuitos. Containers com Docker: criação de imagens, empacotamento de aplicações e publicação em instâncias EC2. Hospedagem de sites estáticos em S3. Construção de pipelines de Integração Contínua e Entrega Contínua (CI/CD) automatizando validação de Terraform, build de imagens Docker e deploy de aplicações na AWS. Observabilidade básica com CloudWatch (logs, métricas, alarmes). Boas práticas de segurança, gestão de custos e controle de estado Terraform. Três projetos práticos integradores: site estático em S3, aplicação web em Docker/EC2 e API com banco gerenciado (RDS/DynamoDB), todos provisionados com Terraform e automatizados via CI/CD.

---

**3\. Objetivos**

**3.1 Objetivo Geral**

Capacitar estudantes de Computação a projetar, versionar e automatizar infraestrutura em nuvem AWS utilizando Terraform como ferramenta de IaC, integrando containers Docker e pipelines de CI/CD, respeitando limites de custos e boas práticas de segurança e observabilidade.

**3.2 Objetivos Específicos**

Ao final do treinamento, o estudante deverá ser capaz de:

1. Explicar os conceitos de Infraestrutura como Código (IaC) e seus benefícios para gestão de ambientes em nuvem.

2. Identificar serviços AWS elegíveis ao Free Tier (EC2, S3, RDS, DynamoDB, Lambda, CloudWatch) e planejar arquiteturas simples respeitando limites de custo.

3. Escrever código Terraform para provisionar e gerenciar recursos AWS: VPC, sub-redes, Security Groups, EC2, S3 e bancos gerenciados.

4. Criar imagens Docker otimizadas para aplicações e executá-las em instâncias EC2 provisionadas com Terraform.

5. Configurar buckets S3 com Terraform para hospedagem de sites estáticos e armazenamento de artefatos.

6. Provisionar e integrar bancos de dados gerenciados (RDS ou DynamoDB) com aplicações usando Terraform.

7. Projetar e implementar pipelines de CI/CD que automatizam validação de Terraform (plan/apply), build de imagens Docker e deploy em EC2.

8. Configurar observabilidade básica com CloudWatch: logs, métricas, dashboards e alarmes de billing.

9. Reconhecer e aplicar boas práticas de segurança em IaC (gestão de secrets via IAM, princípio de menor privilégio)0.

10. Gerenciar custos com budgets, alarmes e destruir infraestrutura de forma segura (terraform destroy).

11. Desenvolver três projetos práticos integradores aplicando IaC, Docker e CI/CD em serviços AWS Academy.

---

**4\. Conteúdo Programático**

**Encontro 1 – Introdução: IaC, AWS Academy e projetos práticos**

**Conteúdos:**

* Conceitos de Infraestrutura como Código (IaC) e seus benefícios

* Apresentação do ecossistema: Terraform, Docker, CI/CD e serviços AWS

* AWS Academy

* Serviços foco da disciplina: VPC, EC2, S3, RDS/DynamoDB, Lambda, IAM, CloudWatch

* Apresentação dos três projetos práticos:

  * **Projeto 1:** Site estático em S3 via Terraform

  * **Projeto 2:** Aplicação web em Docker \+ EC2 via Terraform \+ CI/CD

  * **Projeto 3:** API com banco gerenciado (RDS/DynamoDB) via Terraform \+ pipeline

**Atividades:**

* Criação de conta AWS educacional/Free Tier pelos estudantes

* Configuração de alarmes básicos de billing e budgets

* Discussão: mapeamento de necessidades de infraestrutura para projetos acadêmicos

---

**Encontro 2 – Fundamentos de Terraform na AWS**

**Conteúdos:**

* Arquitetura do Terraform: provider, recursos, variáveis, outputs, estado

* Provider AWS: autenticação, região, credenciais (boas práticas)

* Comandos básicos: init, plan, apply, destroy

* Versionamento de código Terraform com Git

**Atividades:**

* Instalação do Terraform e configuração de credenciais AWS

* Criação de módulo Terraform mínimo: VPC simples \+ sub-redes públicas

* Prática de comandos: plan e apply de infraestrutura básica

---

**Encontro 3 – Rede e computação em AWS Academy**

**Conteúdos:**

* Conceitos de rede AWS: VPC, sub-redes, Internet Gateway, Security Groups

* Recursos de computação Free Tier: instâncias EC2 elegíveis (t2.micro, t3.micro)

* Provisionamento de EC2 com Terraform: tipo de instância, AMI, chaves SSH, security groups

**Atividades:**

* Estender código Terraform para criar:

  * 1 Security Group com regras básicas (SSH, HTTP)

  * 1 instância EC2 t2.micro/t3.micro

* Conectar via SSH à instância provisionada

* Prática de destroy para controle de custos

---

**Encontro 4 – Docker: empacotamento de aplicações**

**Conteúdos:**

* Revisão de conceitos de containers: imagens, containers, Dockerfile, registry

* Estrutura de Dockerfile: FROM, COPY, RUN, CMD, EXPOSE

* Boas práticas: multi-stage builds, otimização de camadas, variáveis de ambiente

* Docker na EC2: instalação e execução de containers em instância AWS

**Atividades:**

* Criar Dockerfile para aplicação exemplo (API web simples)

* Build e teste local da imagem Docker

* Deploy manual da aplicação containerizada na EC2 provisionada (via SSH/script)

---

**Encontro 5 – Armazenamento e serviços adicionais AWS Academy**

**Conteúdos:**

* Amazon S3: buckets, objetos, políticas de acesso básicas

* Outros serviços Free Tier aplicáveis: DynamoDB, RDS (limites reduzidos)

* Integração de aplicação com S3 (ex.: armazenamento de arquivos, logs)

**Atividades:**

* Adicionar ao código Terraform:

  * Criação de bucket S3 para artefatos/logs

  * Outputs com informações de acesso ao bucket

* Configurar aplicação para usar S3 (exemplo: upload de arquivo estático)

---

**Encontro 6 – Armazenamento e banco gerenciado: RDS e DynamoDB**

**Conteúdos:**

* Amazon RDS: MySQL/PostgreSQL no Free Tier (750h/mês, 20GB)

* Amazon DynamoDB: tabela NoSQL com nível "always free"

* Comparação: quando usar RDS vs. DynamoDB

* Provisionamento de banco com Terraform: recursos, configurações mínimas, outputs

**Atividades:**

* Criar, via Terraform, um banco gerenciado (RDS MySQL/Postgres micro *ou* DynamoDB)

* Configurar Security Groups para acesso seguro ao banco

* Testar conexão ao banco e realizar operações básicas (criar tabela, inserir dados)

* Documentar outputs: endpoint, porta, credenciais (via secrets)

---

**Encontro 7 – Projeto 3: API com banco gerenciado em AWS**

**Conteúdos:**

* Integração de aplicação com banco de dados AWS (RDS ou DynamoDB)

* Boas práticas: variáveis de ambiente, gestão de credenciais via IAM

* Execução de aplicação containerizada em EC2 conectada ao banco

**Atividades:**

* Ajustar aplicação exemplo (API) para conectar ao banco provisionado

* Atualizar código Terraform para incluir EC2 \+ banco \+ networking necessário

* Subir aplicação em Docker na EC2, validando comunicação com banco

* **Início do Projeto 3:** API funcional consumindo banco gerenciado na AWS

---

**Encontro 8 – CI/CD: conceitos e pipeline para Terraform \+ Docker**

**Conteúdos:**

* Integração Contínua e Entrega Contínua aplicados a IaC

* Pipeline multi-stage: validação Terraform, build Docker, testes

* Ferramentas: GitHub Actions, GitLab CI ou similar

* Boas práticas: validação de código (fmt, validate, plan), testes automatizados

**Atividades:**

* Criar pipeline de CI que, a cada pull request:

  * Execute terraform fmt \-check e terraform validate

  * Rode terraform plan (sem aplicar)

  * Faça build da imagem Docker e execute testes da aplicação

* Configurar secrets para credenciais AWS na plataforma de CI

---

**Encontro 9 – CI/CD: deploy automatizado em AWS**

**Conteúdos:**

* Pipeline de entrega (CD): aplicação automática de mudanças de infraestrutura

* Estratégias de deploy: manual approval, ambientes separados (dev/prod)

* Atualização de aplicação em EC2 via pipeline (deploy de container atualizado)

**Atividades:**

* Estender pipeline para:

  * Ao merge em branch main, executar terraform apply em ambiente de laboratório

  * Fazer push de imagem Docker para registry (Docker Hub ou ECR)

  * Atualizar container em EC2 ou cluster K8s local via script

---

**Encontro 10 – Observabilidade básica com AWS CloudWatch**

**Conteúdos:**

* Conceitos de observabilidade: métricas, logs, traces

* AWS CloudWatch: métricas de EC2, logs de aplicações, dashboards básicos

* Configuração de logs da aplicação Docker para CloudWatch Logs

* Alarmes simples: CPU, memória, billing

**Atividades:**

* Instrumentar aplicação para enviar logs ao CloudWatch Logs

* Criar dashboard básico no CloudWatch com métricas de EC2 e aplicação

* Configurar alarme de billing para controle de custos

---

**Encontro 11 – Boas práticas: segurança, custos e gestão de estado**

**Conteúdos:**

* Segurança em IaC: gestão de secrets, uso de IAM roles, princípio de menor privilégio

* Estado remoto do Terraform: conceito de backend S3 \+ DynamoDB para lock

* Tagging de recursos para organização e controle de custos

* Higiene de ambientes: terraform destroy, limpeza de recursos não utilizados

**Atividades:**

* Revisar código Terraform do projeto:

  * Adicionar tags a todos os recursos

  * Validar que não há secrets hardcoded

  * Configurar backend remoto para estado (S3 \+ DynamoDB)0

* Prática de destruição segura e completa da infraestrutura

---

**Encontro 12 – Apresentação dos projetos práticos e consolidação**

**Conteúdos:**

* Integração de todos os componentes: Terraform \+ Docker \+ CI/CD \+ Serviços AWS

* Revisão dos três projetos práticos desenvolvidos:

  * **Projeto 1:** Site estático em S3 via Terraform

  * **Projeto 2:** Aplicação web em Docker \+ EC2 via Terraform \+ CI/CD

  * **Projeto 3:** API com banco gerenciado (RDS/DynamoDB) via Terraform \+ pipeline

* Fluxo fim a fim demonstrado: código → CI/CD → infraestrutura AWS → aplicação rodando → monitoramento

* Discussão de próximos passos: Lambda/serverless, EKS, módulos Terraform avançados, certificações AWS

**Atividades:**

* Apresentação pelos grupos (10-15 minutos cada):

  * Demonstração dos três projetos funcionando

  * Repositório Git organizado: Terraform, Dockerfiles, pipelines CI/CD, documentação

  * Arquitetura AWS e decisões técnicas explicadas

  * Gestão de custos e uso do Free Tier

* Retrospectiva da disciplina: aprendizados principais, desafios superados, aplicações em TCC e carreira

* **Destruição final obrigatória** de todos os recursos AWS criados (terraform destroy)

---

**5\. Metodologia de Ensino**

O treinemanto adota abordagem prática e baseada em projetos, com metodologia expositiva-dialogada e atividades hands-on em laboratório. As estratégias incluem:

* **Aulas expositivas dialogadas:** apresentação de conceitos fundamentais de IaC, cloud computing, containers e CI/CD com apoio de slides e quadro, incentivando participação ativa dos estudantes.

* **Demonstrações práticas:** o docente conduz demonstrações ao vivo de criação de código Terraform, build de imagens Docker, configuração de pipelines e deploy em ambiente AWS real.

* **Laboratórios guiados:** atividades práticas estruturadas onde estudantes aplicam os conceitos vistos, com repositório Git compartilhado contendo aplicação exemplo e templates de código.

* **Aprendizagem baseada em projetos:** projeto integrador percorre toda a disciplina, com entregas incrementais a cada encontro (provisionamento de VPC, EC2, containerização, pipeline CI/CD)1.

* **Trabalho colaborativo:** atividades em duplas ou pequenos grupos para estimular troca de conhecimento e práticas de revisão de código (code review).

* **Enfoque em custos e sustentabilidade:** orientação contínua sobre uso responsável de recursos AWS, monitoramento de billing e práticas de destruição de infraestrutura ao final dos experimentos.

---

**7\. Recursos Didáticos**

**7.1 Infraestrutura Tecnológica**

* **Laboratório de informática** com estações Linux/Windows com acesso à internet

* **Contas AWS educacionais** para estudantes (AWS Academy, AWS Educate ou créditos Free Tier)

* **Ferramentas instaladas:** Terraform, Docker, kubectl, Git, VS Code ou editor de texto

* **Plataforma de versionamento:** GitHub/GitLab institucional ou público

* **Plataforma de CI/CD:** GitHub Actions, GitLab CI ou Jenkins (conforme disponibilidade)

**7.2 Materiais de Apoio**

* **Repositório oficial do projeto** contendo:

  * Aplicação exemplo (API web simples em Python/Node.js/Go)

  * Templates de código Terraform para VPC, EC2, S3

  * Exemplos de Dockerfiles e manifestos Kubernetes

  * Templates de pipeline CI/CD

* **Documentação oficial:**

  * Terraform AWS Provider Documentation

  * AWS Academy Documentation

  * Docker Documentation

  * Kubernetes Documentation

* **Slides dos encontros**

* **Vídeos demonstrativos** de procedimentos críticos (configuração de credenciais AWS, primeiro apply Terraform, etc.)

---

**8\. Bibliografia**

**8.1 Bibliografia Básica**

**Documentação Oficial:**

\[4 HashiCorp. (2026). *Terraform AWS Provider Documentation*. [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

\[5 Amazon Web Services. (2026). *AWS Academy*. [https://aws.amazon.com/free/](https://aws.amazon.com/free/)

---

**9\. Cronograma Resumido**

| Semana | Tópico Principal | Entrega |
| :---: | :---- | :---- |
| 1 (02/04/2026)\* | IaC, AWS Academy e projetos práticos | Conta AWS \+ alarmes |
| 2(09/04/2026)\* | Terraform básico: provider, recursos, estado | \- |
| 3(16/04/2026)\* | Rede e EC2 com Terraform | Exercício 1: VPC \+ EC2 |
| 4(23/04/2026)\* | Docker: empacotamento em EC2 | Exercício 2: Dockerfile \+ app |
| 5 (30/04/2026)\* | S3 e Projeto 1: site estático | Projeto 1: S3 static site |
| 6(07/05/2026)\* | RDS/DynamoDB com Terraform | \- |
| 7(14/05/2026)\* | Projeto 3: API \+ banco gerenciado | Projeto 3 (inicial) |
| 8(21/05/2026)\* | CI/CD: pipeline Terraform \+ Docker | Exercício 3: Pipeline CI |
| 9(28/05/2026)\* | CI/CD: deploy automatizado (Proj. 2 e 3\) | Projeto 2: App \+ CI/CD |
| 10 (04/06/2026)\* | Observabilidade com CloudWatch | \- |
| 11(11/06/2026)\* | Segurança, custos e estado remoto | \- |
| 12(18/06/2026)\* | Apresentação dos 3 projetos | Projetos 1, 2 e 3 finais |

Table 1: Cronograma de 12 semanas focado em serviços AWS e projetos práticos

Poderão ocorrer mudanças nas datas, bem como antecipação das mesmas.\*

---

**10\. Observações Importantes**

**10.2 Política de Integridade Acadêmica**

* Código deve ser original do grupo, com atribuição adequada de fontes externas

* Uso de módulos Terraform públicos é permitido, desde que compreendidos e documentados

**10.3 Acessibilidade e Inclusão**

* Materiais disponibilizados em formatos acessíveis (markdown, PDF com estrutura)

* Trabalho em dupla/trio incentivado para colaboração e inclusão

---

**Anexo B – Descrição dos Três Projetos Práticos**

**Projeto 1: Site Estático em S3 via Terraform**

**Objetivo:** Hospedar um site estático (HTML/CSS/JS) em bucket S3 usando Terraform.

**Recursos AWS:**

* Bucket S3 com website hosting habilitado

* Política de acesso público para leitura

* Outputs: URL do site estático

**Entregas:**

* Código Terraform funcional (bucket.tf, variables.tf, outputs.tf)

* Arquivos do site estático (HTML/CSS/JS simples)

* Documentação: README com instruções de deploy

---

**Projeto 2: Aplicação Web em Docker \+ EC2 \+ CI/CD**

**Objetivo:** Implantar aplicação containerizada em EC2 via Terraform com pipeline de CI/CD.

**Recursos AWS:**

* VPC, Security Groups, instância EC2 (t2.micro/t3.micro)

* Aplicação web simples (API REST ou frontend) em Docker

* Pipeline CI/CD (GitHub Actions/GitLab CI) automatizando:

  * Validação Terraform (fmt, validate, plan)

  * Build e push da imagem Docker

  * Deploy automatizado em EC2 (atualização do container)

**Entregas:**

* Código Terraform completo (rede \+ computação)

* Dockerfile otimizado da aplicação

* Arquivo de configuração do pipeline CI/CD (.github/workflows ou .gitlab-ci.yml)

* Documentação: arquitetura e fluxo de deploy

---

**Projeto 3: API com Banco Gerenciado (RDS/DynamoDB)**

**Objetivo:** Desenvolver API que consome banco gerenciado na AWS, provisionado com Terraform.

**Recursos AWS:**

* EC2 para hospedar a API em Docker

* RDS (MySQL/Postgres micro) *ou* DynamoDB (tabela NoSQL)

* Security Groups configurados para comunicação segura

* CloudWatch Logs para monitoramento da aplicação

* Pipeline CI/CD automatizando deploy da API

**Entregas:**

* Código Terraform para EC2 \+ banco \+ rede

* API funcional (Python/Node.js/Go) conectada ao banco

* Dockerfile da API

* Pipeline CI/CD configurado

* Documentação: modelo de dados, endpoints da API, variáveis de ambiente

---

**Aplicação Exemplo Base**

**Tipo:** API REST simples  
**Linguagem:** Python (FastAPI) ou Node.js (Express)  
**Funcionalidades:**

* Endpoint /health (health check)

* Endpoint /items (CRUD básico conectado a banco)

* Integração com S3 (upload/download opcional)

* Logs estruturados em JSON

* Configuração via variáveis de ambiente

**Requisitos técnicos:**

* Dockerfile fornecido

* Testes automatizados básicos

* README com instruções

O repositório base será adaptado pelos estudantes para cada projeto prático.
