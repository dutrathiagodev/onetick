# Feature Template (Scaffold)

Use este scaffold para gerar uma nova feature no padrao Clean Arch + Cubit.

## Comando

No root do projeto:

```bash
scripts/create_feature.sh <feature_name_em_snake_case>
```

Exemplo:

```bash
scripts/create_feature.sh customers
```

## O que o script cria

- domain/<feature> (entity, repository, usecase)
- data/<feature> (model, repository_impl)
- infra/adapters/<feature> (mock adapter)
- presenter/<feature> (cubit + state)
- modules/<feature>/page + modules/<feature>/page/view
- modules/<feature>/widgets
- main/di/screens/<feature>\_dependencies.dart

## Passos obrigatorios apos gerar

1. Registrar o setup da feature em lib/main/di/app_dependencies.dart
2. Conectar a page na navegacao/rota desejada
3. Adaptar entidades e regras para o dominio real
4. Criar/ajustar testes da feature
5. Rodar flutter analyze e flutter test

## Observacoes

- O scaffold gera uma base funcional, mas propositalmente simples.
- Ajuste naming e contratos conforme o contexto da feature.
- Mantenha page como orquestradora de estados e view como renderizacao de sucesso.
