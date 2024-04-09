#!/home/dietpi/ferumbrinhasbot/env/bin/python
import re
import logging
import time
import requests
from bs4 import BeautifulSoup
from counterdeathplayer import increment_deathplayer


url_lastkills = "https://www.ferumbrinhaot.com.br/?lastkills"
page_deaths = requests.get(url_lastkills)
soup = BeautifulSoup(page_deaths.content, "html5lib")

MIN_LEVEL = 600  # ao menos level MIN_LEVEL para ser enviado

logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
logger = logging.getLogger(__name__)

table_deaths = soup.find(class_="TableContent")

REGX_LEVEL = re.compile("[0-9]+")
REGX_DIEDFOR = re.compile(r"(?<=by\s)(a |an )?[\w ]+")
REGX_NAME = re.compile(r"^[-\s'\w]+(?=\sdied)")
# mortes a 10 minutos atrás
last_deaths_list = []
only_playersname = [] # somente os nomes dos players mortos

# primeira TR é o header não valido para nosso scraping

for deaths in table_deaths.find_all("tr"):
    tags_td = deaths.findAll('td')
    _, timedeath, desc, _ = tags_td
    timedeath = timedeath.text.strip()
    desc = desc.text.strip()
    name = REGX_NAME.search(desc).group()
    # '\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t27.10.2022, 19:24:44\n\t\t\t\t\t\t\t\t\t\t\t\t\t'
    # "\n\t\t\t\t\t\t\t\t\t\t\t\t\t\tFon'tes died at level 489 by a demon.\n\t\t\t\t\t\t\t\t\t\t\t\t\t"
    #name, desc, timedeath = deaths.children
    #name = name.text
    #desc = desc.text
    # limpa as as variaveis para se tornarem reutilizaveis
    # filtra apenas o nome, monstro, e data
    level = REGX_LEVEL.search(
        desc).group()  # obtem o grupo encontrado, nesse caso o level numérico
    died_for_monster = REGX_DIEDFOR.search(desc).group()
    timedeath = time.strptime(timedeath, "%d.%m.%Y, %H:%M:%S")
    timedeath = time.mktime(timedeath)

    #logger.debug("P> %s Lv> %s Monster> %s Hour> %s" %
    #            (name, level, died_for_monster, timedeath))

    if (time.time() - timedeath) <= 600.0 and int(level) >= MIN_LEVEL:
        only_playersname.append(name) # salva o nome do jogador para usarmos no counter

    #checa se houve morte nos últimos 10 minutos e o level minimo
    if (time.time() - timedeath) <= 600.0 and int(level) >= MIN_LEVEL:
        last_deaths_list.append(
            "[%s] %s morreu para %s a menos de 10 minutos.\n\n" %
            (level, name, died_for_monster))
    

logger.debug('Incrementando mortes dos jogadores')
increment_deathplayer(only_playersname)

