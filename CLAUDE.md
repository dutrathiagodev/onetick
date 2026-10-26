# CLAUDE.md — contexto do projeto OneTick

Leia este arquivo primeiro. Ele resume o que o projeto é, como está organizado, o que já foi feito, o que falta e como o dono gosta de trabalhar. Fale com o dono em **português (pt-BR)**, de forma direta e curta.

## O que é

**OneTick**: app Flutter de foco diário ("um foco essencial por dia"). O usuário define uma única meta, toca para concluir e acompanha histórico e sequência. Foco em **Android e iOS** (web só no futuro).

É o **desafio final do módulo da Lifeados Academy**, avaliado em dupla (100 pontos): layout/fidelidade ao Stitch 20, Flutter e funcionalidades 20, arquitetura 15, login + dados/back-end 15, bugs 15 (começa em 15; crítico −5, médio −2, leve −1; mínimo 0), apresentação oral 15. A complexidade não é avaliada isoladamente, vale a qualidade da execução.

## Pessoas e links

- Dono: **Thiago Dutra**, GitHub `dutrathiagodev` (e-mail do git: thiagodutrasap@gmail.com).
- Dupla: **Rennan**, GitHub `rarydex` (convite de colaborador pendente). Fez o design no **Google Stitch** e levou para o Figma.
- Repositório (público): https://github.com/dutrathiagodev/onetick
- Stitch: https://stitch.withgoogle.com/projects/3290547221674662054 (referência de avaliação)
- Figma: https://www.figma.com/design/VkOOGKJqZLH9TUwbwAQUUE/onetick
- Trello (tarefas): https://trello.com/b/ZYYc6UoN/onetick (workspace pessoal do dono; listas A fazer, Em andamento, Bloqueado, Concluído)
- Local na máquina do dono: `~/Documentos/Mentoria/onetick` (não colocar dentro de `whatsfake_app`).

## Stack

Flutter 3.47 / Dart 3.13 · flutter_bloc (Cubit) · get_it · Firebase Auth + Cloud Firestore + Google Sign-In · flutter_svg · fonte Inter embutida em `assets/fonts` · testes com flutter_test, bloc_test, mocktail.

## Arquitetura (obrigatória)

Clean Architecture + Cubit, conforme `docs/architecture/feature.spec.md`, `feature.skills.md` e `feature.template.md`. **Releia esses 3 arquivos antes de criar feature nova.**

```
lib/
  main/                 entrypoint (lib/main/main.dart), app, session_gate, auth_flow, di/
  core/                 theme (AppColors/AppTextStyles), widgets compartilhados, utils, routes
  domain/<feature>/     entities, repositories (contratos), usecases
  data/<feature>/       models e repository_impl
  infra/adapters/       Firebase (Auth/Firestore) e versões em memória
  presenter/<feature>/  cubit + state
  modules/<feature>/    page (BlocProvider + decide loading/erro/vazio/sucesso), page/view, widgets
```

Regras: fluxo `modules → presenter → domain`; `data`/`infra` implementam contratos; a **page** decide o estado e a **view** só renderiza o sucesso; DI por tela em `lib/main/di/screens/<feature>_dependencies.dart` (setups idempotentes; testes pré-registram fakes); nunca criar entrypoint fora de `lib/main/main.dart`. Rode sempre com `-t lib/main/main.dart`.

Features: onboarding, login, register, today (Hoje + Foco Concluído), define_focus, history, settings, shell (abas).

## Comandos

```bash
flutter pub get
flutter run -t lib/main/main.dart        # emulador "bigz_pixel" (Android) já existe na máquina
flutter analyze                          # deve ficar sem avisos
flutter test                             # 102 testes
flutter test --update-goldens test/goldens   # regenera os prints das telas (440x890)
python3 tool/generate_brand_assets.py    # regenera ícones/marca
```

## Estado atual

Feito (ver `docs/tasks/BOARD.md`): as 10 telas, DI, Firebase (código), tema claro/escuro, logo e ícone do app (Android/iOS/web), README, testes (domínio, dados, widgets, fluxo completo, telas pequenas sem overflow, goldens). A tela "Foco Concluído" foi conferida com o Stitch e inclui **Desfazer conclusão** e **Ver no Histórico**.

Sem Firebase configurado o app roda em **modo local** (dados em memória; faixa vermelha em debug). Em **release** sem Firebase mostra tela de erro de propósito.

## Pendências (por impacto na nota)

1. **Configurar o Firebase real** (OT-0009): `flutterfire configure --out=lib/main/firebase_options.dart`, habilitar Auth (e-mail/senha e Google, SHA-1 no Android), `firebase deploy --only firestore:rules`. Passo a passo em `docs/setup/firebase.md`. Exige o login do dono. O arquivo `lib/main/firebase_options.dart` hoje é um placeholder.
2. **Riscos de bug a corrigir**: escrita no Firestore sem internet pode travar (usar timeout/escrita local); Tela Hoje não atualiza na virada do dia; esconder/configurar o botão do Google.
3. **Lembrete diário só salva a preferência**, não notifica (OT-0030).
4. Telas de Privacidade e Termos (OT-0032).
5. Testar em aparelho/emulador com Firebase real (OT-0033); validar paleta do tema escuro com o designer (OT-0034).
6. Comparar as outras 9 telas com o Stitch (só "Foco Concluído" foi conferida).
7. Ensaiar a apresentação (os dois integrantes, Stitch aberto, explicar arquitetura e dificuldades).

## Convenções do dono (siga)

- **Commits por tarefa**, no formato `tipo(OT-0000): Descrição`, ex.: `feat(OT-0001): Criar projeto Flutter onetick`. IDs com 4 dígitos, iguais ao Trello/`BOARD.md`. Tipos: feat, fix, chore, docs, test.
- Autoria dos commits é do dono (`dutrathiagodev`); **não adicionar** linha `Co-Authored-By` nem marca de IA.
- Não commitar segredos (`google-services.json`, `GoogleService-Info.plist`, `.env`, chaves).
- Reescrever histórico/force-push só com pedido explícito.
- Tarefas novas: criar a linha no `docs/tasks/BOARD.md` e o card no Trello com descrição (O QUE, ENTREGA/COMO, CRITÉRIO DE ACEITE, REF).
- README segue o formato do repositório de exemplo do dono (`landing-page-face-a-face`): cabeçalho centralizado com selos, Sobre, Links, O que tem, Tecnologias, Como rodar, Estrutura, Time.

## Decisões de design (não desfazer sem avisar)

- O Figma/Stitch tem inconsistências; o app corrige: percentual da tela Hoje é 0% pendente / 100% concluído; números do Histórico vêm dos dados; texto "anúncios" corrigido; "Mínimo 8 caracteres" padronizado. Detalhes em `docs/design-review.md`.
- "Salvar Foco" fica desabilitado com campo vazio.
- O tema escuro é derivado (não existe no Figma/Stitch).
- Formulários e abas usam `BottomAnchoredScroll`/`SingleChildScrollView` para nunca estourar (overflow) em tela pequena, teclado aberto ou fonte grande; há testes de regressão em `test/modules/small_screen_test.dart`.
- Cores da marca: navy `#042449`, azul `#0468D7`, menta `#0DFFC3`. A logo (anel + tick) é gerada em `tool/generate_brand_assets.py`.

## Armadilhas já encontradas

- Em testes, `flutter_test` usa a fonte Ahem: use `loadTestFonts()` (`test/helpers/pump_helpers.dart`) antes de goldens, senão há overflows falsos.
- Em ferramentas de terminal, `pkill -f` com padrão presente no próprio comando mata o shell; use `kill $(pgrep -f "[p]adrão")`.
- No Trello, digitar sem confirmar que o editor/campo está focado dispara atalhos de teclado do Trello e altera cards por engano.
