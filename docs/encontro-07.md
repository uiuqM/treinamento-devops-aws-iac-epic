## O que é?

GitHub Actions é uma plataforma de integração e entrega contínua (CI/CD) que permite automatizar a sua compilação, testar e integrar sua pipeline de implantação. É possível criar fluxos de trabalho que criam e testam cada pull request no seu repositório, ou implantar pull requests mesclados em produção.

---
## CI/CD

![](../img/image13.png)

---
## Visualizando

![](../img/image14.png)
De maneira geral podemos seguir essa seguinte estrutura.

---
## O que compõe github actions

![](../img/image15.png)

---
## Como é configurada?

![](../img/Pasted image 20241218153135.png)

Exemplo da action utilizada para servir esse material:
https://github.com/uiuqM/treinamento-devops-epic/blob/main/.github/workflows/main.yaml

---
## Visualizando
![](../img/image16.png)

---
## Pratica

- https://github.com/treinamento-devops-playground

---
## Events (Workflow triggers)

| Relacionado ao repositório                  | Outros                                          |
| ------------------------------------------- | ----------------------------------------------- |
| push (commit)                               | workflow_dispatch<br>(trigger manual)           |
| pull_request (opened, closed...)            | repository_dispatch<br>(REST API)               |
| create (branch ou tag)                      | scheduled<br>(Workflow agendado)                |
| fork (repo teve fork)                       | workflow_call<br>(Chamado por outros workflows) |
| issues (issue aberta, deletada....)         |                                                 |
| issues_comment (issue ou PR comment)        |                                                 |
| watch (repo favoritado)                     |                                                 |
| discussion (dicussion criada, deletada ...) |                                                 |
| ....                                        |                                                 |

---

## Job runners

![](../img/image17.png)

---
## Actions

Uma aplicação que performa uma tarefa (complexa) repetitiva.

Exemplos:
https://github.com/actions/checkout
https://github.com/marketplace?type=actions
---

# Ficamos por aqui!

**Dúvidas ou sugetões?**

---