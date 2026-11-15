// Atalho para `flutter run` sem `-t`. O entrypoint real continua sendo
// lib/main/main.dart (veja docs/architecture/feature.spec.md); aqui só se
// reexporta o `main()` de lá, sem lógica nenhuma.
export 'main/main.dart' show main;
