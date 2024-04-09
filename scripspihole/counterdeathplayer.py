# counterdeathplayer.py
#
# Usa um arquivo tipo dosini para salvar nomes de jogadores
# com um número do total de mortes
#
# Versão 0.1: Recebe nomes e incrementa +1 salvando os nomes
# em um arquivo dosini
#
# Franklin Timóteo, Dezembro 2022
# 
import configparser

FILE_CONFIG='players.ini'
SECTION_DEFAULT='JOGADORES'
config = configparser.ConfigParser()
config.read(FILE_CONFIG)



def increment_deathplayer(names):
    """
    :name type list
    Incrementa por padrão +1 ao nome do personagem
    Caso não exista, cria um
    Caso já exista, apenas incrementa

    Passe a lista com nomes repetidos para adicionar mais de uma vez
    """
    for name in names:
        name = name.lower()
        if name not in config[SECTION_DEFAULT]:
            config[SECTION_DEFAULT][name] = '0'

        player_amount_death = config[SECTION_DEFAULT][name]
        player_amount_death = int(player_amount_death)+1
        player_amount_death = str(player_amount_death)
        config[SECTION_DEFAULT][name] = player_amount_death

    with open(FILE_CONFIG, 'w') as cfile:
        config.write(cfile)
