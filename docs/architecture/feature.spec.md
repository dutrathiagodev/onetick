# Feature Spec - Arquitetura Padrao

Documento normativo para novas features no mcpix_app.

## Escopo

Este spec define como qualquer nova feature deve ser estruturada em termos de camadas, fluxo de dados, injecao de dependencias e composicao de UI.

## Requisitos obrigatorios

1. Camadas obrigatorias

- domain, data, infra, presenter, modules e main/di/screens.

2. Separacao de responsabilidade

- domain: regras e contratos
- data: implementacao dos contratos
- infra: integracao com bibliotecas/fontes externas
- presenter: gestao de estado com cubit
- modules/page: orquestracao de estado para renderizar cenarios
- modules/page/view: widgets de apresentacao

3. Fluxo de dependencia (sempre nessa direcao)

- modules -> presenter -> domain
- data -> domain
- infra -> data
- main/di -> todas (somente para montagem)

4. Regra da page

- deve conter BlocProvider e BlocBuilder
- deve mapear estados para telas/cenarios:
  - loading view
  - success view
  - error view
  - empty view

5. Regra da view principal

- deve receber estado e callbacks por parametro
- nao deve instanciar cubit
- nao deve decidir cenarios globais (loading/error/empty)

6. Regra de injecao de dependencias

- cada feature deve ter arquivo proprio em main/di/screens/<feature>\_dependencies.dart
- setup global chama setup de cada feature em main/di/app_dependencies.dart
- o app inicia em lib/main/main.dart

7. Convencoes de arquivo

- <feature>\_entity.dart
- <feature>\_repository.dart
- <feature>\_repository_impl.dart
- <feature>\_cubit.dart
- <feature>\_state.dart
- <feature>\_page.dart
- <feature>\_view.dart

## Estrutura obrigatoria de arquivos

```text
lib/main/main.dart
lib/main/di/service_locator.dart
lib/main/di/app_dependencies.dart
lib/main/di/screens/<feature>_dependencies.dart
lib/domain/<feature>/...
lib/data/<feature>/...
lib/infra/adapters/<feature>/...
lib/presenter/<feature>/...
lib/modules/<feature>/page/<feature>_page.dart
lib/modules/<feature>/page/view/<feature>_view.dart
lib/modules/<feature>/page/view/<feature>_loading_view.dart
lib/modules/<feature>/page/view/<feature>_error_view.dart
lib/modules/<feature>/page/view/<feature>_empty_view.dart
lib/modules/<feature>/widgets/...
```

## Criterios de aceitacao

- Nova feature respeita a estrutura obrigatoria
- Dependencias registradas por tela
- Page controla cenarios por estado
- View principal focada em sucesso
- Nao existem imports ciclicos
- flutter analyze sem erros
- flutter test com sucesso

## Nao permitido

- Criar state view como classe privada dentro da page
- Instanciar dependencias manualmente dentro da view
- Manter logica de dominio dentro de widget
- Criar novo entrypoint fora de lib/main/main.dart

## Processo de evolucao

Ao criar uma nova feature:

1. Copiar a estrutura do modulo inventory
2. Adaptar nomes e regras de negocio
3. Registrar DI da nova tela
4. Adicionar testes minimos
5. Validar com analyze e test
