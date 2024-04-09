

# set para marcar um breakpoint no debug
# set +x mostra os comandos conforme são executados set -x para desabilitar
# set +v mostra a linha executada sem prefixo seguida do resultado
# no incio de cada comando mostra +  (significa o número de subshell)
# para mudar o sinal + basta mudar a variável $PS4
PS4=">"

echo "Abc"
echo $((0+1))
echo $((0+10))

# execução passo a passo
# set +x 
# trap read DEBUG / liga
# código
# trap "" DEBUG / desliga
# set -x
