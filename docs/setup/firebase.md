# Firebase (único backend do OneTick)

O app usa **Firebase Auth** (e-mail/senha + Google) e **Cloud Firestore**.
Sem Firebase configurado, o app roda em **modo local** (dados em memória) apenas em debug/profile;
em release ele mostra uma tela de erro de configuração.

## Projeto configurado

- Projeto: **`onetick-1d336`** (conta do dono), ligado em `.firebaserc`.
- Apps: Android e iOS com o ID `dev.dutrathiago.onetick`.
- Authentication: **E-mail/senha** e **Google** ativados.
- Firestore: banco `(default)` em `southamerica-east1` (São Paulo), modo produção, regras de `firestore.rules` publicadas.
- `lib/main/firebase_options.dart` já tem as opções reais e o `googleServerClientId` usado pelo Google Sign-In.
- iOS: `REVERSED_CLIENT_ID` registrado como URL scheme em `ios/Runner/Info.plist`.
- Android: SHA-1/SHA-256 do keystore de **debug** desta máquina cadastrados. Para outra máquina ou para o keystore de release, cadastre o novo SHA (comando abaixo).

A CLI roda via `npx`, sem instalar nada global:

```bash
npx firebase-tools@15.35.0 login
npx firebase-tools@15.35.0 deploy --only firestore:rules
npx firebase-tools@15.35.0 apps:android:sha:create 1:820418629636:android:06357393d51a35efd1e551 <SHA>
```

`android/app/google-services.json` e `ios/Runner/GoogleService-Info.plist` ficam fora do git.
Para baixá-los de novo: `npx firebase-tools@15.35.0 apps:sdkconfig ANDROID|IOS <appId> -o <arquivo>`.

## Modelo de dados

| Caminho | Campos |
| --- | --- |
| `users/{uid}/focus/{yyyy-MM-dd}` | `dateKey`, `title`, `completed`, `completedAt` |
| `users/{uid}/settings/prefs` | `reminderEnabled`, `reminderHour`, `reminderMinute`, `theme` |

Consultas de histórico usam apenas um campo (`dateKey`), então **não** exigem índice composto.
