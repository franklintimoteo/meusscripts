#!/home/dietpi/ferumbrinhasbot/env/bin/python
# senddiscordranking.py
#
# Envia uma lista de nomes no discord, organizando
# por números totais de mortes
#
# Versão 0.1: busca o arquivo do tipo dosini e envia
# no discord a lista organizada
#
#
# Franklin Timóteo, Dezembro 2022
#
import sys
from os import getenv
import configparser
from dotenv import load_dotenv
import discord

load_dotenv()


FILE_CONFIG='players.ini'
SECTION_DEFAULT='JOGADORES'
config = configparser.ConfigParser()
config.read(FILE_CONFIG)

# Carrega e organiza os nomes
payload = config[SECTION_DEFAULT]
payload = list(payload.items())
payload = payload.sort(key=lambda x: x[1], reverse=True)
payload = "\n".join("%s\t| %s"%(y,x) for x,y in payload)
payload = "Ranking de mortes da semana:\n" + payload + "\n\n@everyone"
if last_deaths_list:

    # application id
    # 1035223349854482493

    # token
    # bc80b644874a47f7ace033e10c982001b7d5bfa74be0dfd79836326bb23671d8
    # id guilda
    guilda_id = 1035197354053210223
    # id sala acompanhe death list
    channel = 1035231271737106512

    token = getenv('DISCORDTOKEN')
    intents = discord.Intents.default()
    intents.message_content = True

    client = discord.Client(intents=intents)

    #activity = discord.Activity(name='Jogando Ferumbrinhas',                            type=discord.ActivityType.watching)
    #client = discord.Client(activity=activity, intents=intents)

    @client.event
    async def on_ready():
        almention = AllowedMentions(everyone=True, users=True, roles=True, replied_user=True)
        channel = client.get_channel(1035231271737106512)
        await channel.send(payload, allowed_mentions=almention)
        sys.exit(0)

    client.run(token)
