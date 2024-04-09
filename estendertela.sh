#!/bin/bash
# estendertela.sh
#
# Estende a tela do meu notebook para um monitor secundário
# o monitor secundário ficará a direita
#
# Versão 0.1: Estende a tela para outro monitor
#
# Timóteo, Novembro 2022
# 

xrandr --output eDP-1 --primary --output DP-2 --noprimary --right-of eDP-1 --auto
