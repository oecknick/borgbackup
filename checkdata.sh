#!/bin/bash

#Thomas Oecknick 05/2020
#Kontrolle der Datenintegrität am letzten Sonntag im Monat

#Wo bin ich
PFAD="/root/borgbackup"

#Wer soll die Mails bekommen
recipient=$(cat $PFAD/.mail 2>&1)

#Kontrolle ob es der letzte Sonntag im Monat ist
if [[ $(date -d "$date + 1week" +%d%a) =~ 0[1-7]Sun ]]
then

#Alten Inhalt aus /root/borgbackup/textdateien/backupintegry.txt löschen
echo > /root/borgbackup/textdateien/backupintegry.txt

#Sage BORG wo sich das Repository befindet
REPOSITORY_O="/mnt/backups/repository/AMTAS005_Laufwerk_O"
REPOSITORY_M="/mnt/backups/repository/AMTAS005_Laufwerk_M"
REPOSITORY_I="/mnt/backups/repository/AMTAS005_Laufwerk_I"
REPOSITORY_H="/mnt/backups/repository/AMTAS005_Laufwerk_H"
REPOSITORY_G="/mnt/backups/repository/AMTAS005_Laufwerk_G"
REPOSITORY_K="/mnt/backups/repository/AMTAS005_Laufwerk_K"
REPOSITORY_DB="/mnt/backups/repository/AMTDB048_DatenBankBackups"
REPOSITORY_PDB="/mnt/backups/repository/AMTDB048_ProgressBackups"
REPOSITORY_PROX1="root@192.168.100.240:/mnt/backups/repository/Proxmox1"
REPOSITORY_PROX2="root@192.168.100.240:/mnt/backups/repository/Proxmox2"
REPOSITORY_PROX3="root@192.168.100.240:/mnt/backups/repository/Proxmox3"
REPOSITORY_PROX4="root@172.26.20.14:/mnt/backups/repository/Proxmox4"

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat /root/borgbackup/.wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Per Multithreading immer 4 Repos mit einem Rutsch auf Datenintegrität kontrollieren

#Gruppe 1
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_O 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_M 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_I 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_H 2>> /root/borgbackup/textdateien/backupintegry.txt

#Gruppe 2
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_G 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_K 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_DB 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_PDB 2>> /root/borgbackup/textdateien/backupintegry.txt

#Gruppe 3
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_PROX1 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_PROX2 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_PROX3 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --repository-only --progress $REPOSITORY_PROX4 2>> /root/borgbackup/textdateien/backupintegry.txt


  #Versende Mail ob die Daten erfolgreich gesichert wurden
  if [ $? = 0 ]
	then
	#echo Hatta gut gemacht
	/usr/bin/mail -s "BorgBackup Integritaetscheck" $recipient < $PFAD/textdateien/erfolg_check.txt
	else
	#echo Hatta nich so gut gemacht
	/usr/bin/mail -s "BorgBackup Integritaetscheck" $recipient < $PFAD/textdateien/misserfolg_check.txt
  fi
fi
#wenn nicht letzter Sonntag im Monat, tue nix
