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
| [ OT-0009 ] | Firebase: `flutterfire configure`, habilitar provedores, publicar regras (`docs/setup/firebase.md`) | 🟡 |
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
| [ OT-0027 ] | Hoje — Foco Concluído | 4:524 | 🟡 inferida; conferir no Figma |
| [ OT-0028 ] | Histórico | 4:2 | ✅ |
| [ OT-0029 ] | Configurações | 4:281 | ✅ |

## Pendências / melhorias

| ID | Demanda | Status |
| --- | --- | --- |
| [ OT-0030 ] | Agendar notificação local do lembrete diário (hoje só salva a preferência) | ⬜ |
| [ OT-0031 ] | Conferir "Foco Concluído" contra o Figma quando o limite do MCP resetar | 🟡 |
| [ OT-0032 ] | Páginas de Privacidade e Termos (links só texto no design) | ⬜ |
| [ OT-0033 ] | Testar em aparelho/emulador Android e iOS com Firebase real | 🟡 |
| [ OT-0034 ] | Validar a paleta do tema escuro com o designer (tema já implementado; paleta derivada, não existe no Figma) | 🟡 |

Achados do design: [`../design-review.md`](../design-review.md).
