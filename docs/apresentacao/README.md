# Apresentação do OneTick

- `OneTick-Guia-do-Projeto.pdf`: o projeto, a arquitetura com o código de cada camada, as dificuldades e o roteiro de fala.
- `OneTick-Pitch.pdf`: slides 16:9 para o pitch.

Os PDFs são gerados a partir dos HTML em `src/` (fonte Inter de `assets/fonts` e prints de `test/goldens`). Depois de editar o HTML, gere de novo:

```bash
cd docs/apresentacao
google-chrome --headless=new --no-pdf-header-footer --allow-file-access-from-files --print-to-pdf="$PWD/OneTick-Guia-do-Projeto.pdf" "file://$PWD/src/guia.html"
google-chrome --headless=new --no-pdf-header-footer --allow-file-access-from-files --print-to-pdf="$PWD/OneTick-Pitch.pdf" "file://$PWD/src/pitch.html"
```
