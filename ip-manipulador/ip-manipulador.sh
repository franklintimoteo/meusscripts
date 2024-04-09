#!/usr/bin/env bash
# -----------------------------
# Projeto	: ip-manipulador
# Arquivo	: ip-manipulador.sh
# Descrição	:
# Versão	: 1.0.0
# Data		: 03/04/2024 - 14:19
# Autor 	: Franklin Timóteo <franklindev+scripts@disroot.org>
# Licença	: GNU/GPL v3.0
# -----------------------------
# Uso: Exibe e adicione novos ips para uma interface de forma temporária
# -----------------------------

COL_YELLOW="\033[0;33m"
COL_GREEN="\033[0;32m"
COL_NORMAL="\033[0m"

# obtém os nomes das interfaces e seus ips
interfaces=$(ip address show up | grep --color -oP "[\d]+: [\w]+(?=:)" | cut -d " " -f 2)
ifaces_list=
for iface in $interfaces; do
    ips=$(ip addres show $iface | grep -oP "[\d]+.[\d]+.[\d]+.[\d]+\/[\d]+")
    ifaces_list=$ifaces_list"$iface -> $ips\n"
done

# obtém os servidores dns
dns_servers=$(grep nameserver /etc/resolv.conf | sed "s/nameserver//")


uso(){
    printf "\\n ${COL_GREEN}ip-manipulador --add 10.0.0.2/26 --dev eno1"
    printf "\\n ip-manipulador --show\\n"

    printf "${COL_NORMAL}"
}

OPTS=$(getopt -o '' -l show,add:,dev: -- "$@")
if [ $? != 0 ]; then
    # saida com erro imprime o menu de ajuda
    uso
    exit 1
fi

set -- $OPTS
while true; do
    case "$1" in
	--show) SHOW=true; shift;;
	--add) ADD="$2"; shift 2;;
	--dev) DEV="$2"; shift 2;;
	--)shift; break;;
	*) printf "Argumento não reconhecido"; uso; exit 1;;
    esac
done
if [[ "$SHOW" = true ]]; then
    	printf "${COL_YELLOW}--Interfaces--"
	printf  "\\n$ifaces_list"
	
	printf "\\n${COL_GREEN}--DNS Servers--"
	printf "\\nDNS Servers $dns_servers${COL_NORMAL}\\n"
fi

if [[ -n "$ADD" ]]; then
    [[ -z "$DEV" ]] && printf "Opção --add requer --dev\\n" && exit 1

    printf "${COL_YELLOW}Adicionando $ADD a interface $DEV\\n${COL_NORMAL}"
    sudo ip address add $ADD dev $DEV
    ip address show $DEV
fi
	
