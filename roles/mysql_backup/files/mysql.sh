#!/bin/bash

mysqldump agama > agama.sql
scp agama.sql Lumix888@backup:
duplicity --no-encryption full /home/backup/mysql/ rsync://Lumix888@backup.baluca.io//home/Lumix888/
