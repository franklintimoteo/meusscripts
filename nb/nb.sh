#!/usr/bin/env bash
LC_ALL=C

msg_erro[1]='Número incorreto de parâmetros!'
msg_erro[2]='Nome inválido!'
msg_erro[3]='Já existe uma pasta chamda $1!'

# função de erro para apresentar uma mensagem e sair do script
erro(){
    echo ${msg_erro[$1]}
    echo 'Uso: nb novo-projeto'
    exit $1
}


[[ $# -ne 1 ]] && erro 1
# if [[ $# -ne 1 ]]; then
#     echo 'Número incorreto de parâmetros!'
#     exit 1
# fi


[[ $1 =~ ^[-_0-9a-z]+$ ]] || erro 2
# if [[ ! $1 =~ ^[-_0-9a-z]+$ ]]; then
#     echo  'Nome inválido!'
#     exit 2
# fi

[[ -a $1  ]] && erro 3
# if [[ -a $1 ]]; then
#     echo "Já existe uma pasta chamda $1"
#     exit 3
# fi


modelo="#!/usr/bin/env bash
# -----------------------------
# Projeto	: $1
# Arquivo	: $1.sh
# Descrição	:
# Versão	: 0.0.0
# Data		: $(date '+%d/%m/%Y - %R')
# Autor 	: Franklin Timóteo <franklindev+scripts@disroot.org>
# Licença	: GNU/GPL v3.0
# -----------------------------
# Uso: 
# -----------------------------
"
caminho_destino=$HOME/meusscripts
caminho_projeto=$caminho_destino/$1
arquivo_destino=$caminho_projeto/$1.sh
arquivo_symlink=$HOME/bin/$1

mkdir -p $caminho_projeto
echo "$modelo" >> $arquivo_destino
chmod -x $arquivo_destino
ln -s $arquivo_destino $arquivo_symlink
vim $arquivo_destino
