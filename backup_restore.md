# IFRASTRUCTURE RESTORATION ISTRUCTION AND DATA RECOVERY

## Infrastracture services restoration

Make sure to posses the most recent version of the infrastructure code available from this repository:

- https://github.com/Lumix888/Ansible_Infrastructure

To restore all the services at the wanted state please run once:

ansible-playbook infra.yaml

For MYSQL and Infludb data recovery please read the sections: "MYSQL data recovery" and "Influxdb data recovery"

## Grafana dashoboards 

If the infrastructure is running properly and ONLY the grafana dashbords need to be restored please run asible and using the command:

ansible-playbook --tag grafana infra.yaml

should this not be enough to restore the dashboards please run one time this command:

ansible-playbook infra.yaml

## MYSQL data recovery

For data restoration from the local full backup or from remote serve please input the following commands on terminal Lumix888-1 command line. Working results can be checked on AGAMA webpage.

- ### from local full backup (probably not present due to VM refresh):

sudo -i

mysql agama < /home/backup/mysql/agama.sql

exit

- ### from remote backup server: 

sudo su - backup

rm -rf /home/backup/restore/mysql

duplicity --no-encryption restore rsync://Lumix888@backup.baluca.io//home/Lumix888/mysql/ /home/backup/restore/mysql

cat /home/backup/restore/mysql/agama.sql

exit

sudo -i

mysql agama < /home/backup/restore/mysql/agama.sql

exit

## Influxdb data recovery

For data restoration from the local full backup or from remote serve please input the following commands on terminal Lumix888-3 command line. Working results can be checked on grafana.

- ### from local full backup (probably not present due to VM refresh):

sudo -i

service telegraf stop

influx -execute 'DROP DATABASE telegraf'

influxd restore -portable -database telegraf /home/backup/influxdb/

service telegraf start

exit

and from ansible terminal:

ansible-playbook infra.yaml

- ### from remote backup server: 

sudo su - backup

rm -rf /home/backup/restore/influxdb/*

duplicity --no-encryption restore rsync://Lumix888@backup//home/Lumix888/influxdb /home/backup/restore/influxdb/

exit

sudo -i

service telegraf stop

influx -execute 'DROP DATABASE telegraf'

influxd restore -portable -database telegraf /home/backup/restore/influxdb/

service telegraf start

exit

and from ansible terminal:

ansible-playbook --tag infl infra.yaml
