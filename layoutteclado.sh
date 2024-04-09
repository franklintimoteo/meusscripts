#!/bin/bash
# layoutteclado.sh
#
# Altera o modelo para thinkpad
# 
#
# Versão 0.1: Muda o teclado para padrão thinkpad 
# depois força atualização para evitar reiniciar
# Versão 0.2: Imprime colorido o arquivo antes e depois
# de modificar
# 
# Timóteo, Novembro 2022

# Modelos disponíveis no arquivo:
# /usr/share/X11/xkb/rules/xorg.lst 

# KEYBOARD CONFIGURATION FILE # ARQUIVO ESPELHO
# Consult the keyboard(5) manual page.
#XKBMODEL="thinkpad"
#XKBLAYOUT="br"
#XKBVARIANT=""
#XKBOPTIONS=""
#BACKSPACE="guess"

KEYBOARDFILE=/etc/default/keyboard
# imprime o arquivo antes
echo -e '\033[31m' && cat -n $KEYBOARDFILE && echo -e '\033[m'
# e imprimir em verde o novo arquivo
sed -iE 's/XKBMODEL=[a-zA-Z0-9]+/XKBMODEL=thinkpad/' $KEYBOARDFILE
# imprime como ficou o arquivo
echo -e '\033[32m' && cat -n $KEYBOARDFILE && echo -e '\033[m'

# Comando sugerido pelo man keyboard para evitar reiniciar
udevadm trigger --subsystem-match=input --action=change
