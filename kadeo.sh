#!/bin/bash

echo -n "$1 está logado desde "
who | grep $1 | tr -s ' ' '\t' |
    cut -f3,4 --output-delimiter " às "
