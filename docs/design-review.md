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
9. **Botões "mortos" no design** (sem estado/ação definidos): "Esqueceu a senha?", "Backup local & Nuvem", avatar do topo, Privacidade/Termos. No app: reset de senha por e-mail, aviso de sincronização automática, menu de conta com "Sair"; Privacidade/Termos abrem as páginas de Política de Privacidade e Termos de Uso (OT-0032).
10. **Estados ausentes no design** (adicionados): erro de formulário, loading, vazio (Hoje sem foco, Histórico novo), erro de rede, tema escuro (paleta derivada), "Pendente" na lista de 7 dias.
11. **"Salvar Foco"** aparece habilitado com campo vazio; no app fica desabilitado até haver texto.
12. **Lembrete diário**: o design não define como notificar. O app agenda uma **notificação local** diária no horário escolhido, com o ícone do OneTick (OT-0030).

## Conferência com o Stitch (OT-0037)

As 10 telas foram comparadas com o projeto do Stitch (referência da avaliação), lado a lado com os goldens do app (440x890).

- **Iguais ao Stitch**: Onboarding 1, 2 e 3, Cadastro, Login, Hoje (pendente), Hoje (concluído), Histórico e Configurações (textos, ordem, componentes e hierarquia).
- **Corrigido**: em **Definir Foco** o card de dica ficava preso no rodapé, longe das ideias; agora fica logo abaixo das "Ideias intencionais", como no Stitch.
- **Diferenças intencionais**: o Stitch usa um check genérico no topo de Login/Cadastro e no card Sobre; o app usa a logo OneTick (OT-0035). "Backup local & Nuvem" mostra "Sincronização automática ativa" em vez de um horário fixo de exemplo. Os números e datas vêm dos dados reais (itens 4 a 6).

## Revisão profissional (OT-0039 e OT-0040)

Referências: política de exclusão de conta da Google Play, diretriz 5.1.1(v) da App Store e boas práticas de aceite de termos no cadastro.

- **Termos antes da conta existir**: Cadastro mostra "Ao criar sua conta ou continuar com o Google, você concorda com os Termos de Uso e a Política de Privacidade", com links. O Login mostra o mesmo aviso para o Google, que também cria conta.
- **Privacidade e Termos com a conta aberta**: Configurações > Sobre tem os dois links (antes só existiam no rodapé de quem não estava logado).
- **Excluir conta**: Configurações > Conta > Excluir conta, com confirmação. Apaga histórico, preferências e a conta. Se o login for antigo, o Firebase recusa a exclusão; o app avisa antes de apagar qualquer dado e pede para entrar de novo.
