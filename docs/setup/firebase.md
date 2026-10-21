# Firebase (único backend do OneTick)

O app usa **Firebase Auth** (e-mail/senha + Google) e **Cloud Firestore**.
Sem Firebase configurado, o app roda em **modo local** (dados em memória) apenas em debug/profile;
em release ele mostra uma tela de erro de configuração.

## 1. Criar e ligar o projeto

```bash
npm i -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
flutterfire configure --out=lib/main/firebase_options.dart --platforms=android,ios
```

Isso sobrescreve o placeholder `lib/main/firebase_options.dart` e baixa
`android/app/google-services.json` / `ios/Runner/GoogleService-Info.plist`.

## 2. Habilitar no console

- Authentication → Sign-in method: **E-mail/senha** e **Google**.
  - Android: cadastrar o SHA-1/SHA-256 do keystore.
  - iOS: adicionar o `REVERSED_CLIENT_ID` em `Info.plist` (URL scheme).
- Firestore Database → criar em modo produção.

## 3. Publicar as regras

```bash
firebase deploy --only firestore:rules
```

## Modelo de dados

| Caminho | Campos |
| --- | --- |
| `users/{uid}/focus/{yyyy-MM-dd}` | `dateKey`, `title`, `completed`, `completedAt` |
| `users/{uid}/settings/prefs` | `reminderEnabled`, `reminderHour`, `reminderMinute`, `theme` |

Consultas de histórico usam apenas um campo (`dateKey`), então **não** exigem índice composto.
