/// Static legal texts shown from the Login / Sign-up footer.
enum LegalDocument {
  privacy(
    title: 'Política de Privacidade',
    updatedAt: '5 de novembro de 2026',
    sections: [
      (
        'Quem somos',
        'O OneTick é um app de foco diário criado por Thiago Dutra e Rennan '
            'como projeto da Lifeados Academy. Esta política explica quais '
            'dados o app usa e por quê, conforme a Lei Geral de Proteção de '
            'Dados (Lei 13.709/2018).',
      ),
      (
        'Dados que coletamos',
        '• Conta: nome, e-mail e, se você entrar com o Google, a foto do '
            'perfil.\n'
            '• Uso do app: o foco de cada dia, se foi concluído e o horário.\n'
            '• Preferências: lembrete diário (ligado e horário) e tema.\n'
            'Não coletamos localização, contatos, dados de pagamento nem '
            'dados de navegação para publicidade.',
      ),
      (
        'Para que usamos',
        'Somente para fazer o app funcionar: entrar na sua conta, guardar '
            'seu histórico e sequência de dias, sincronizar entre aparelhos e '
            'mostrar o lembrete no horário escolhido. O lembrete é uma '
            'notificação gerada no próprio aparelho.',
      ),
      (
        'Onde ficam os dados',
        'No Google Firebase (Authentication e Cloud Firestore), com o banco '
            'de dados em São Paulo. Regras de segurança garantem que cada '
            'pessoa acesse apenas os próprios dados. Uma cópia fica no '
            'aparelho para o app funcionar sem internet.',
      ),
      (
        'Compartilhamento',
        'Não vendemos nem compartilhamos seus dados com anunciantes. O app '
            'não tem anúncios. O Google atua apenas como provedor da '
            'infraestrutura (Firebase e login com Google).',
      ),
      (
        'Seus direitos',
        'Você pode acessar e corrigir seus dados, apagar todo o histórico em '
            'Configurações > Limpar histórico e hábitos e pedir a exclusão da '
            'conta pelo contato abaixo. Também pode revogar o login com Google '
            'nas configurações da sua Conta Google.',
      ),
      (
        'Contato',
        'Dúvidas ou pedidos sobre seus dados: abra uma solicitação em '
            'github.com/dutrathiagodev/onetick.',
      ),
    ],
  ),
  terms(
    title: 'Termos de Uso',
    updatedAt: '5 de novembro de 2026',
    sections: [
      (
        'Aceite',
        'Ao criar uma conta ou usar o OneTick, você concorda com estes '
            'termos e com a Política de Privacidade.',
      ),
      (
        'O serviço',
        'O OneTick ajuda você a escolher um único foco por dia, marcá-lo '
            'como concluído e acompanhar seu histórico. O app é gratuito, '
            'sem anúncios, e foi desenvolvido como projeto acadêmico.',
      ),
      (
        'Sua conta',
        'Você é responsável por manter sua senha em segredo e pelas '
            'informações que registra. Use um e-mail válido para poder '
            'recuperar o acesso.',
      ),
      (
        'Uso adequado',
        'Não use o app para armazenar conteúdo ilegal, ofensivo ou dados de '
            'terceiros sem autorização, nem tente acessar dados de outras '
            'pessoas ou prejudicar o funcionamento do serviço.',
      ),
      (
        'Disponibilidade',
        'Buscamos manter o app funcionando, mas ele é oferecido "como está", '
            'sem garantia de disponibilidade contínua. Recursos podem mudar '
            'ou ser encerrados.',
      ),
      (
        'Responsabilidade',
        'O OneTick é uma ferramenta de apoio à rotina. Não nos '
            'responsabilizamos por decisões tomadas com base no app nem por '
            'perdas causadas por indisponibilidade.',
      ),
      (
        'Alterações',
        'Estes termos podem ser atualizados. A data no topo indica a última '
            'versão. Continuar usando o app depois de uma mudança significa '
            'concordar com ela.',
      ),
      ('Lei aplicável', 'Estes termos seguem as leis brasileiras.'),
    ],
  );

  const LegalDocument({
    required this.title,
    required this.updatedAt,
    required this.sections,
  });

  final String title;
  final String updatedAt;

  /// `(heading, body)` pairs, rendered in order.
  final List<(String, String)> sections;
}
