# Encontro 5 — Docker: Containers para Aplicações

---

**Duração:** 2h  
**Bloco:** Containers  
**Projeto associado:** Projeto Flask App

---

## Objetivos do Encontro
- Compreender o conceito de containers e diferença em relação a VMs
- Construir imagens Docker com Dockerfile
- Executar containers com variáveis de ambiente
- Publicar imagens no Docker Hub

---

## Roteiro (2h)

| Tempo       | Atividade                                         |
| ----------- | ------------------------------------------------- |
| 0:00 – 0:10 | Revisão + correção da atividade de casa           |
| 0:10 – 0:45 | Exposição: containers vs VMs + arquitetura Docker |
| 0:45 – 1:05 | Exposição: Dockerfile — instruções essenciais     |
| 1:05 – 1:50 | Laboratório: build + run + push da app Flask      |
| 1:50 – 2:00 | Síntese e dúvidas                                 |

---

## Conteúdo Expositivo

---
### 5.1 Containers vs. VMs

---

|               | VM                | Container                         |
| ------------- | ----------------- | --------------------------------- |
| Isolamento    | SO completo       | Processo isolado no SO do host    |
| Tamanho       | GB                | MB                                |
| Boot          | Minutos           | Segundos                          |
| Overhead      | Alto (hypervisor) | Baixo (kernel compartilhado)      |
| Portabilidade | Média             | Alta ("build once, run anywhere") |

---

### 5.2 Arquitetura Docker
---


```
Docker CLI  →  Docker Daemon  →  Registry (Docker Hub / ECR)
                    ↓
              Containers (instâncias de imagens)
              Imagens (templates imutáveis)
              Volumes (dados persistentes)
              Redes (comunicação entre containers)
```

---

### 5.3 Dockerfile — Instruções Essenciais

---

| Instrução      | Função                                          |
| -------------- | ----------------------------------------------- |
| `FROM`         | Imagem base                                     |
| `WORKDIR`      | Diretório de trabalho dentro do container       |
| `COPY` / `ADD` | Copia arquivos do host para a imagem            |
| `RUN`          | Executa comando durante o build (cria layer)    |
| `ENV`          | Define variável de ambiente                     |
| `EXPOSE`       | Documenta a porta (não publica automaticamente) |
| `CMD`          | Comando padrão ao iniciar o container           |
| `ENTRYPOINT`   | Executável principal (mais rígido que CMD)      |

---
### 5.4 Boas práticas de Dockerfile

---

```dockerfile
# ✅ Use imagem base leve
FROM python:3.11-alpine

# ✅ Instale dependências primeiro (melhor cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ✅ Copie o código depois
COPY . .

# ✅ Use usuário não-root
RUN adduser -D appuser
USER appuser

# ❌ Evite: COPY . . antes de instalar dependências
# ❌ Evite: senhas ou chaves no Dockerfile
```

---

## Laboratório — Build, Run e Push da App Flask

---

Use a aplicação do Projeto Flask App (`projeto-ec2-flask/app/`).

---
### 1. Build da imagem
---

```bash

docker build -t flask-iac-app .

# Listar imagens
docker images
```
---

### 2. Executar o container
---

```bash
# Modo básico
docker run -p 5000:5000 flask-iac-app

# Com variável de ambiente (cor do background)
docker run -p 5000:5000 -e APP_COLOR=#e74c3c flask-iac-app

# Em background (detached)
docker run -d --name minha-app -p 5000:5000 -e APP_COLOR=#2ecc71 flask-iac-app

# Acessar: http://localhost:5000
```

---

### 3. Inspecionar o container
---

```bash
docker ps                     # containers em execução
docker logs minha-app         # logs da aplicação
docker exec -it minha-app sh  # shell dentro do container
docker stop minha-app         # parar
docker rm minha-app           # remover
```
---
### 4. Publicar no Docker Hub
---
```bash
# Criar conta em hub.docker.com

docker login

docker tag flask-iac-app SEU_USUARIO/flask-iac-app:v1.0
docker push SEU_USUARIO/flask-iac-app:v1.0

# Pull em qualquer máquina
docker pull SEU_USUARIO/flask-iac-app:v1.0
```

---
### 5. Experimento: variáveis de ambiente
```bash
# Cores diferentes → containers diferentes
docker run -d -p 5001:5000 -e APP_COLOR=red   --name app-red   flask-iac-app
docker run -d -p 5002:5000 -e APP_COLOR=blue  --name app-blue  flask-iac-app
docker run -d -p 5003:5000 -e APP_COLOR=green --name app-green flask-iac-app

# Acesse localhost:5001, 5002 e 5003 — mesmo código, comportamentos diferentes
docker stop app-red app-blue app-green && docker rm app-red app-blue app-green
```

---

## Atividade para Casa
1. Modifique o `index.html` adicionando o hostname do container na página (use `socket.gethostname()` no `app.py`)
2. Faça rebuild e push no Docker Hub com a tag `v1.1`
3. Pesquisa: o que é **multi-stage build** no Docker e qual a vantagem?

---

## Referências
- Docker. *Dockerfile Reference.* https://docs.docker.com/reference/dockerfile/
- Docker. *Best Practices for Writing Dockerfiles.* https://docs.docker.com/build/building/best-practices/
- Docker Hub. https://hub.docker.com/
