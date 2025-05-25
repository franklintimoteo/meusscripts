#!/usr/bin/env bash

# Descrição: script para desativar o monitor primário do notebook
# assim que outro monitor seja conectado. 
#
# Requesitos: hyprland
#
# Versão: 1.0.0
# Author: Franklin Timóteo <franklindev+scripts.disroot.org>
# Licença: GNU/GPL v3.0




#!/bin/bash

# Nome do monitor interno (substitua pelo correto se necessário)
INTERNAL_DISPLAY="eDP-1"

# Obtém a lista de monitores conectados
CONNECTED_MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Verifica se há monitores externos conectados
EXTERNAL_CONNECTED=false

for MONITOR in $CONNECTED_MONITORS; do
    if [[ "$MONITOR" != "$INTERNAL_DISPLAY" ]]; then
        EXTERNAL_CONNECTED=true
        break
    fi
done

# Se um monitor externo estiver conectado, desativa o monitor interno
if $EXTERNAL_CONNECTED; then
    hyprctl keyword monitor "$INTERNAL_DISPLAY, disable"
else
    hyprctl keyword monitor "$INTERNAL_DISPLAY, preferred, auto, 1"
fi
