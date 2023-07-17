# === GHOST IN THE SHELL.SH ===
### Spawn temporary directories with timeout timer after which auto archive will run
### Encrypt & Decrypt archived workspace using openssl with string based key

## === SC-UI Entry point: ===
> `exec.sh` entry point script inside Addon repository directory
> `main.sh` [SC-Addons central UI] -> [Addon_name] exec.sh 

## === Modules ===
> `1-tmp-rm` - Create temporary workspace and force remove on timeout
> `2-tmp-tar` - Create temporary directory and archive it into tar.gz after timeout (timeout in s)
> `3-encrypt` - Encrypt tar.gz file using `bash encrypt.sh CLASSIFIED.tar.gz password`
> `4-decrypt` - Decrypt tar.gz.enc encrypted file using `bash decrypt.sh CLASSIFIED.tar.gz.enc password`

## === To do ===
> `OpenPGP` encryption & keyrings
> `SSL Certificates`
> `TMP file for upload API
> `SFTP` protocol for upload API
