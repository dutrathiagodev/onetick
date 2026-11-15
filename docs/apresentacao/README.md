# Apresentação do OneTick

- `OneTick-Guia-do-Projeto.pdf`: o projeto, onde ficam os dados, a arquitetura, as dificuldades e o roteiro de fala (5 páginas).
- `OneTick-Pitch.pdf`: 5 slides 16:9 para o pitch.

Os PDFs são gerados a partir dos HTML em `src/` (fonte Inter de `assets/fonts` e prints do app no emulador (`.github/images/emulador`)). Depois de editar o HTML, gere de novo:

```bash
cd docs/apresentacao
google-chrome --headless=new --no-pdf-header-footer --allow-file-access-from-files --print-to-pdf="$PWD/OneTick-Guia-do-Projeto.pdf" "file://$PWD/src/guia.html"
google-chrome --headless=new --no-pdf-header-footer --allow-file-access-from-files --print-to-pdf="$PWD/OneTick-Pitch.pdf" "file://$PWD/src/pitch.html"
```
