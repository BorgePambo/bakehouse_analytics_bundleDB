# Bakehouse Data Platform

## 1. Contexto de Negócio

A **Bakehouse** é uma empresa do setor de alimentação e varejo, com operações envolvendo:

* Clientes
* Transações de vendas
* Franquias
* Fornecedores
* Avaliações de clientes

## 2. Objetivo do Projeto

Construir uma plataforma de dados capaz de transformar dados operacionais da Bakehouse em informações **confiáveis, organizadas e preparadas para Analytics/BI**.

A plataforma deve integrar e disponibilizar dados para análises relacionadas a:

* Vendas
* Produtos
* Clientes
* Franquias
* Fornecedores
* Distribuição geográfica
* Satisfação dos clientes
* Tendências e oportunidades de negócio

A arquitetura utilizada é:

**Bronze → Silver → Gold**

---

## 3. Arquitetura Medallion

### Bronze

Responsável pela **ingestão e preservação dos dados de origem**.

### Silver

Responsável pela **limpeza, padronização, qualidade e transformação dos dados**.

### Gold

Responsável pelos **modelos analíticos, métricas, agregações e dados destinados ao consumo de Analytics/BI**.

As regras detalhadas de cada camada estão em:

* `.claude/rules/bronze.md`
* `.claude/rules/silver.md`
* `.claude/rules/gold.md`

Sempre consultar essas regras antes de modificar a camada correspondente.

---

## 4. Ambientes

As configurações específicas de ambiente devem ser controladas por **variáveis, targets ou parâmetros do Databricks Asset Bundle**.

### Regras

* Não hardcodar `bakehouse_dev` ou `bakehouse_prod` no código.
* O mesmo código deve ser reutilizado em Dev e Prod.
* Evitar duplicação de recursos ou código entre ambientes.
* Não alterar configurações de ambiente sem necessidade.
* Preservar a compatibilidade entre Dev e Prod.

---

## 5. Databricks CLI

Utilizar o profile:

```text
claude
```

Exemplos:

```powershell
databricks bundle validate --profile claude
databricks bundle deploy --profile claude
```

Antes de modificar recursos do Bundle:

1. Verificar o `databricks.yml`.
2. Analisar a configuração atual dos recursos.
3. Identificar se o recurso já existe.
4. Evitar criar recursos duplicados.

---

## 6. Organização do Projeto

Manter a separação entre:

```text
resources/
```

Definição de infraestrutura e recursos do Bundle.

```text
src/
```

Código responsável pelo processamento e transformação dos dados.

Não misturar desnecessariamente infraestrutura com lógica de processamento.

---

## 7. Princípios de Desenvolvimento

* Manter a arquitetura **Bronze → Silver → Gold**.
* Priorizar código simples, reutilizável e parametrizado.
* Evitar valores específicos de ambiente no código.
* Utilizar o mesmo Pipeline para o fluxo Medallion.
* Utilizar o mesmo Job para orquestrar a execução.
* Não criar recursos duplicados sem necessidade.
* Preservar compatibilidade entre Dev e Prod.
* Seguir as regras específicas existentes em `.claude/rules/`.
* Antes de modificar infraestrutura, analisar a configuração atual do Bundle.
* Fazer alterações mínimas e necessárias.
* Não alterar recursos existentes sem entender seu propósito.

---

## 8. Regra de Execução

Antes de implementar qualquer alteração:

1. Entender a estrutura atual do projeto.
2. Consultar o `databricks.yml` quando a alteração envolver infraestrutura.
3. Consultar a regra da camada correspondente em `.claude/rules/`.
4. Reutilizar recursos e código existentes quando possível.
5. Validar a configuração após alterações relevantes.
6. Evitar mudanças fora do escopo solicitado.

**Prioridade:** preservar a arquitetura, reutilizar componentes existentes e manter o projeto simples, parametrizado e compatível entre ambientes.
