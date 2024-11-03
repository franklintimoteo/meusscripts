#!/usr/bin/env bash
# backup_selfhosted.sh
#
# Copia arquivos relevantes do servidor, comprime, criptografa
# e salva na nuvem com seu checksum
#
# Versão 1.0: crie um arquivo de backup para enviar ao GDriver
# Data: 03/11/2024
# Autor: Franklin Timóteo dos Santos <franklindev_scripts@disroot.org>
# Licença: GNU/PL v3.0

WORKDIR=/root

# Copia configurações 
cp -r /DATA ${WORKDIR}/DATA-BACKUP

# Comprime todos diretórios
tar -zcf ${WORKDIR}/bkp.tar.gz ${WORKDIR}/DATA-BACKUP

# Criptografa com a chave pública do GPG
# lembrar de confiar na chave pública
# caso contrário o gpg pedirá confirmação
gpg --batch -r franklindev@disroot.org --encrypt ${WORKDIR}/bkp.tar.gz

# envia o arquivo comprimido e criptografado para o google driver
rclone copy ${WORKDIR}/bkp.tar.gz.gpg remote:backups-selfhosted

# faz o mesmo com o checksum
sha512sum ${WORKDIR}/bkp.tar.gz.gpg > ${WORKDIR}/checksum.sha512
