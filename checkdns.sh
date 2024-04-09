#!/bin/bash
# estendertela.sh
#
# Retorna o primeiro IP configurado para resolução
# de DNS
#
#
# Versão 0.1: Verificar o nameserver configurado
#
# Timóteo, Novembro 2022


NAMESERVER1=$(nslookup duckduckgo.com | grep -oP '(?<=Server:[[:space:]]{2})[0-9.]+')
echo $NAMESERVER1

