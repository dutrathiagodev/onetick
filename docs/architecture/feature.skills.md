# Feature Skills - Clean Arch + Cubit

Guia pratico para implementar novas features seguindo o padrao arquitetural do projeto.

## Objetivo

Garantir consistencia entre features com separacao clara de responsabilidades:

- domain: contratos e regras de negocio
- data: implementacoes concretas dos contratos do domain
- infra: adapters de bibliotecas e fontes externas
- presenter: cubit + state + orquestracao de estado
- modules: composicao da tela (page, view e widgets)
- main/di/screens: injecao de dependencia por tela

## Estrutura base por feature

Use o nome da feature em ingles, singular ou plural de forma consistente (ex.: inventory).

```text
lib/
  domain/<feature>/
    entities/
    repositories/
    usecases/

  data/<feature>/
    models/
    repositories/

  infra/adapters/<feature>/

  presenter/<feature>/
    <feature>_cubit.dart
    <feature>_state.dart

  modules/<feature>/
    page/
      <feature>_page.dart
      view/
        <feature>_view.dart
        <feature>_loading_view.dart
        <feature>_error_view.dart
        <feature>_empty_view.dart
    widgets/

  main/di/screens/
    <feature>_dependencies.dart
```

## Regras praticas (skills)

1. A page decide cenarios de UI por state

- loading, success, error, empty e outros cenarios da tela.

2. A view principal renderiza apenas o cenario de sucesso

- sem BlocBuilder na view
- sem decidir loading/error/empty dentro da view

3. O cubit nao conhece widgets

- cubit emite states
- widgets apenas reagem aos states

4. O domain nao depende de Flutter

- entities, repositories e usecases sem import de UI

5. Data implementa contratos do domain

- repository_impl recebe adapters do infra
- model faz parse/mapeamento para entity

6. Infra encapsula detalhes externos

- API clients, SDKs, storage, plugins e mocks

7. DI por tela

- criar arquivo em main/di/screens/<feature>\_dependencies.dart
- registrar adapter -> repository -> usecase -> cubit

8. Nomenclatura

- arquivos em snake_case
- classes em PascalCase
- evitar abreviacoes ambiguas

9. UI stateless quando possivel

- manter widgets puros e reutilizaveis em modules/<feature>/widgets

10. Testes minimos por feature

- widget test do fluxo principal
- teste de cubit para estados criticos quando houver regra relevante

## Template rapido de implementacao

1. Criar entity/repository/usecase no domain
2. Criar model/repository_impl no data
3. Criar adapter no infra
4. Criar state/cubit no presenter
5. Criar page + view + state views + widgets no modules
6. Criar DI da tela em main/di/screens
7. Registrar DI global em main/di/app_dependencies.dart
8. Garantir que a page chama setup<Feature>Dependencies()
9. Rodar flutter analyze e flutter test

## Definition of Done por feature

- Estrutura de pastas segue o padrao
- Page centraliza decisao de estado
- View principal sem logica de estado global
- Dependencias injetadas via get_it
- Sem erro no flutter analyze
- Testes passando

## Scaffold automatico

Para gerar uma base padrao de nova feature:

```bash
scripts/create_feature.sh <feature_name_em_snake_case>
```

Documentacao detalhada:

- [Template de scaffold](feature.template.md)
