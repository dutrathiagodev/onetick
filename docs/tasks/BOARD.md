# Quadro de demandas — OneTick

Legenda: ✅ feito · 🟡 depende de ação externa · ⬜ pendente

## Configuração

| ID | Demanda | Status |
| --- | --- | --- |
| [ OT-0001 ] | Criar projeto Flutter `onetick` dentro de `whatsfake_app/` | ✅ |
| [ OT-0002 ] | Copiar `feature.skills/spec/template.md` para `docs/architecture/` | ✅ |
| [ OT-0003 ] | Estrutura Clean Arch + Cubit (domain/data/infra/presenter/modules/main/di) | ✅ |
| [ OT-0004 ] | Design tokens (cores, tipografia Inter embutida, tema claro/escuro) | ✅ |
| [ OT-0005 ] | Exportar assets do Figma (SVGs/PNGs) para `assets/` | ✅ |
| [ OT-0006 ] | DI com get_it por tela + injeção de adapters (Firebase ou em memória) | ✅ |
| [ OT-0007 ] | Componentes compartilhados (botão pill, cards, pills, top bar, bottom nav, estados) | ✅ |
| [ OT-0008 ] | Firebase: Auth (e-mail + Google) e Firestore (adapters + regras `firestore.rules`) | ✅ código |
| [ OT-0009 ] | Firebase: `flutterfire configure`, habilitar provedores, publicar regras (`docs/setup/firebase.md`) | ✅ |
| [ OT-0010 ] | Sessão/rotas: gate de autenticação, fluxo onboarding → cadastro/login → shell | ✅ |
| [ OT-0011 ] | Testes: helpers, domínio, dados, widgets, fluxo completo, goldens | ✅ |
| [ OT-0012 ] | Repositório GitHub `dutrathiagodev/onetick` | ✅ |
| [ OT-0035 ] | Logo OneTick, ícone do app (Android, iOS, web) e favicon.ico | ✅ |

## Telas (uma por frame do Figma)

| ID | Tela | Frame | Status |
| --- | --- | --- | --- |
| [ OT-0020 ] | Onboarding 1 — "Menos ruído, mais foco" | 4:1057 | ✅ |
| [ OT-0021 ] | Onboarding 2 — "Apenas uma prioridade" | 4:987 | ✅ |
| [ OT-0022 ] | Onboarding 3 — "Celebre o dia concluído" | 4:910 | ✅ |
| [ OT-0023 ] | Cadastro | 4:807 | ✅ |
| [ OT-0024 ] | Login (+ recuperar senha) | 4:717 | ✅ |
| [ OT-0025 ] | Definir Foco | 4:629 | ✅ |
| [ OT-0026 ] | Hoje (foco pendente) | 4:421 | ✅ |
| [ OT-0027 ] | Hoje — Foco Concluído (fiel ao Stitch: tarefa riscada, Ver no Histórico, Desfazer conclusão) | 4:524 | ✅ |
| [ OT-0028 ] | Histórico | 4:2 | ✅ |
| [ OT-0029 ] | Configurações | 4:281 | ✅ |

## Pendências / melhorias

| ID | Demanda | Status |
| --- | --- | --- |
| [ OT-0030 ] | Notificação local do lembrete diário com o ícone do OneTick (agenda, reagenda no login e cancela no logout) | ✅ |
| [ OT-0036 ] | Foto de perfil do Google no avatar do cabeçalho (ícone padrão sem foto/offline) | ✅ |
| [ OT-0032 ] | Páginas de Privacidade e Termos, abertas pelo rodapé do Login e do Cadastro | ✅ |
| [ OT-0037 ] | Conferir as 10 telas com o Stitch e corrigir diferenças (`docs/design-review.md`) | ✅ |
| [ OT-0038 ] | Tela Hoje recarrega na virada do dia (meia-noite com o app aberto ou ao voltar do segundo plano) | ✅ |
| [ OT-0039 ] | Termos visíveis antes de criar a conta (Cadastro e Google no Login) e Privacidade/Termos em Configurações | ✅ |
| [ OT-0040 ] | Excluir conta no app (Configurações > Excluir conta), apagando histórico, preferências e a conta | ✅ |
| [ OT-0041 ] | Componentizar código repetido: cabeçalho (`HeaderBar`, `BackTitleBar`, `AppBackButton`), `AuthHeader`, `AuthCard`, `showNotice` e `showDangerConfirm` em `lib/core/widgets` | ✅ |
| [ OT-0033 ] | Testar em aparelho/emulador Android e iOS com Firebase real | 🟡 |
| [ OT-0034 ] | Validar a paleta do tema escuro com o designer (paleta derivada, não existe no Figma/Stitch; contraste medido e texto de exemplo dos campos ajustado para 4,5:1) | 🟡 |

Achados do design: [`../design-review.md`](../design-review.md).
