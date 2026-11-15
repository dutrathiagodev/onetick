# Feature Template (Checklist)

Use esta lista para criar uma nova feature no padrao Clean Arch + Cubit. A feature `today` e a referencia: copie a estrutura dela e adapte os nomes.

## O que criar

- domain/<feature> (entities, repositories, usecases)
- data/<feature> (models, repositories com `_repository_impl`)
- infra/adapters/<feature> (adapter remoto + versao em memoria)
- presenter/<feature> (cubit + state)
- modules/<feature>/page + modules/<feature>/page/view
- modules/<feature>/widgets
- main/di/screens/<feature>\_dependencies.dart

## Passos obrigatorios

1. Registrar o setup da feature em lib/main/di/app_dependencies.dart
2. Fazer a page chamar `setup<Feature>Dependencies()`
3. Conectar a page na navegacao/rota desejada
4. Criar/ajustar testes da feature
5. Rodar flutter analyze e flutter test

## Observacoes

- Mantenha page como orquestradora de estados e view como renderizacao de sucesso.
- Telas de formulario (login, cadastro) nao precisam de view de vazio.
