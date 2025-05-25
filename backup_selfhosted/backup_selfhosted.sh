#!/usr/bin/env bash
# backup_selfhosted.sh
#
# Copia arquivos relevantes do servidor, comprime, criptografa
# e salva na nuvem com seu checksum
#
# Versão 1.0: crie um arquivo de backup para enviar ao GDriver
# Data: 03/11/2024
# Autor: Franklin Timóteo dos Santos <franklindev+scripts@disroot.org>
# Licença: GNU/PL v3.0

WORKDIR=/root
FILENAME_BASE=backup

# Limpa os arquivos de backup anteriores
rm -rf ${WORKDIR}/DATA-BACKUP

# tenta mover arquivos antigos para o tmp
rm -rf ${WORKDIR}/${FILENAME_BASE}.tar.{gz,gz.gpg}

# Copia configurações usando rsync
rsync -av /DATA/ ${WORKDIR}/DATA-BACKUP

# Comprime todos diretórios
tar -zcf ${WORKDIR}/${FILENAME_BASE}.tar.gz ${WORKDIR}/DATA-BACKUP

# Criptografa com a chave pública do GPG
# lembrar de confiar na chave pública
# caso contrário o gpg pedirá confirmação
gpg --batch -r franklindev@disroot.org --encrypt ${WORKDIR}/${FILENAME_BASE}.tar.gz

# envia o arquivo comprimido e criptografado para o google driver
rclone copy ${WORKDIR}/${FILENAME_BASE}.tar.gz.gpg remote:backups-selfhosted

# faz o mesmo com o checksum
sha512sum ${WORKDIR}/${FILENAME_BASE}.tar.gz.gpg > ${WORKDIR}/checksum.sha512
rclone copy ${WORKDIR}/checksum.sha512 remote:backups-selfhosted
