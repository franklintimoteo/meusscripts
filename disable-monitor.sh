#!/usr/bin/env bash

# Descrição: script para desativar o monitor primário do notebook
# assim que outro monitor seja conectado. 
#
# Requesitos: hyprland
#
# Versão: 1.0.0
# Author: Franklin Timóteo <franklindev+scripts.disroot.org>
# Licença: GNU/GPL v3.0

monitors=$(hyprctl monitors all | grep -Po "(?<=Monitor )[a-zA-Z0-9-]+")
monitors=(${monitors[@]})

# desabilita o monitor primário caso exista um segundo monitor
if ! [[ -z ${monitors[1]} ]] ; then
    if ! (hyprctl monitors all | grep -q "disabled: true") ; then
	hyprctl keyword monitor ${monitors[0]},disable
    fi
else
    hyprctl keyword monitor ${monitors[0]},preferred,auto,1
fi

