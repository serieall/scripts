#!/bin/bash
set -x
############################################################
# Description 	:		Script de backup des bases de données
# Auteur 	:		Youkoulayley
# Date		: 		13/01/2018
# Version	: 		1.1
############################################################
#--- Variables
date=$( date +%Y_%m_%d_%H_%M )
user_mysql="root"
script_directory=$(dirname $0)
password_mysql=$(cat ${script_directory}/credential_mysql.txt)

backup_path="/var/backup_serieall"
[ -d ${backup_path} ] || mkdir ${backup_path}


#--- Backup
echo "Début du backup"
mysqldump -u${user_mysql} -p${password_mysql} --all-databases --events > ${backup_path}/all_databases_$date.sql
# Si la commande s'est bien déroulée, on exécute la suite
if [[ $? -eq 0 ]]; then
	echo "Compression du fichier"
	cd ${backup_path}
	tar czvf all_databases_$date.tar.gz all_databases_$date.sql
	if [ $? -eq 0 ] ; then
		rm -f ${backup_path}/all_databases_$date.sql
		echo "Backup terminé."
	else
		error=1
	fi
else
	error=1
fi 

if [[ $error -eq 1 ]]; then
    echo "${date} failed backup" >> /var/log/backup_databases.log
fi

