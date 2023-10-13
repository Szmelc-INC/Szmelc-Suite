# OCR - Optical character recognition
> V2

## Howto
1. Add `export PATH="/usr/bin:$PATH"` to `~/.bashrc`
2. Reload bashrc with `source ~/.bashrc`
3. Install libs with pip:
~ `pip install pytesseract image pandas pyperclip`
- For Py3.11 and above, add `--break-system-packages`
- or use `pipx` instead
4. Create `$HOME/.core/bin/ocr/` directory tree
5. Transfer contents of main to `ocr`
6. Create folder called `img` in `ocr`
