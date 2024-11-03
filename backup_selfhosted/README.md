Requesitos:
 - rclone
 - gpg
 - tar

Use em conjunto com o rquivo systemd unit. Dessa forma poderá ser feita automação de horário e data.

Copie o script para o bin, facilitando a busca pelo path
`cp backup_selfhosted.sh /usr/local/bin`

Conceda permissão de execução
`chmod +x /usr/local/bin/backup_selfhosted.sh`

Copie o systemd unit para o diretório padrão
`sudo cp backup_selfhosted.service /etc/systemd/system/`

Copie o systemd timer, para programar o horário de backup
`cp backup_selfhosted.timer /etc/systemd/system/`


Ative o systemd unit e timer
`sudo systemctl enable --now backup_selfhosted.service
`sudo systemctl enable --now backup_selfhosted.timer`