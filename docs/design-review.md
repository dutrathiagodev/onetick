# Revisão do Figma — pontos encontrados

Frames lidos via Figma MCP (9 de 10; ver item 1).

1. **"Hoje - Foco Concluído" (4:524)**: o Figma MCP atingiu o limite do plano Starter, então a primeira versão foi inferida. Depois conferida diretamente no projeto do Google Stitch e reimplementada fiel (OT-0027): selo, check duplo, "Foco de hoje concluído!", tarefa riscada com horário, "Ver no Histórico", "Desfazer conclusão" e card "Ritmo Impecável".
2. **Login**: typo no rodapé — "Sem anùncios" (acento errado). Corrigido no app: "anúncios".
3. **Cadastro**: dica da senha diz "Mínimo 8 **dígitos**" e o placeholder "Mínimo 8 **caracteres**". Padronizado em "caracteres".
4. **Hoje (pendente)** mostra "100% · 1 de 1 foco" mesmo sem concluir. No app: 0% / "0 de 1 foco" até concluir.
5. **Datas inconsistentes**: Hoje diz "24 OUT", Histórico diz "Hoje, 30 de Out"; sequência "5 dias" (Hoje) vs "6 dias" (Histórico). No app tudo é calculado a partir da data real.
6. **Histórico**: "24 dias / 86% (24 de 28)" não bate com o calendário (26 dias marcados em 30). No app os números derivam dos dados.
7. **Histórico, lista**: títulos longos ficam cortados sem reticências no Figma; no app usam `ellipsis`.
8. **Onboarding 1/2/3**: contador, indicadores (24/28 px, gaps 6/8, cores diferentes), tamanho do CTA (18 px vs 13 px) e cor do "1 DE 3" variam entre os frames. Padronizado no mais frequente (28 px, 13 px).
9. **Botões "mortos" no design** (sem estado/ação definidos): "Esqueceu a senha?", "Backup local & Nuvem", avatar do topo, Privacidade/Termos. No app: reset de senha por e-mail, aviso de sincronização automática, menu de conta com "Sair"; Privacidade/Termos são só texto (sem páginas definidas).
10. **Estados ausentes no design** (adicionados): erro de formulário, loading, vazio (Hoje sem foco, Histórico novo), erro de rede, tema escuro (paleta derivada), "Pendente" na lista de 7 dias.
11. **"Salvar Foco"** aparece habilitado com campo vazio; no app fica desabilitado até haver texto.
12. **Lembrete diário**: o design não define como notificar. O app **salva a preferência** (liga/desliga + horário) mas **ainda não agenda notificação local** (exigiria plugin fora do Firebase) — OT-0030.
