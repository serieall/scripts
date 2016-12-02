#!/bin/bash
set -x
############################################################
# Description 	:		Script de backup des bases de données
# Auteur 	:		Youkoulayley
# Date		: 		07/10/2016
# Version	: 		1.0
############################################################
#--- Variables
date=$( date +%Y_%m_%d_%H_%M )
userMysql="mysqldump_backup"
passwordMysql=""
cheminBackup="/home/serieall/backup/mysql"

#--- Backup
echo "Début du backup"
mysqldump -u$userMysql -p$passwordMysql --all-databases --events > $cheminBackup/all_databases_$date.sql
# Si la commande s'est bien déroulée, on exécute la suite
if [[ $? -eq 0 ]]; then
	echo "Compression du fichier"
	cd $cheminBackup
	tar czvf all_databases_$date.tar.gz all_databases_$date.sql
	if [ $? -eq 0 ] ; then
		rm -f $cheminBackup/all_databases_$date.sql
		echo "Backup terminé."
	else
		error=1
	fi
else
	error=1
fi

if [[ $error -eq 1 ]]; then
	ssmtp journeytotheit@gmail.com << EOF
From: Scripts Backup
To: journeytotheit@gmail.com
Charset: utf-8
Content-Type: text/html
MIME-Version: 1.0
Subject: Backup Failed
	
<p>Bonjour,<br /></p>
	
<p>Le script de Backup s'est <strong>complétement</strong> viandé. <br />
Merci de faire un tour sur le serveur pour vérifier ce qu'il se passe.<br />
<br />
<i>Date du backup</i> = $date</p><br />

Merci <strong><3</strong><br />
Votre petit serveur chéri.
EOF

fi

