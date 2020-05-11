#!/bin/sh

#Thomas Oecknick 2020

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
/usr/bin/borg check -v --verify-data $REPOSITORY_O 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_M 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_I 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_H 2>> /root/borgbackup/textdateien/backupintegry.txt

#Gruppe 2
/usr/bin/borg check -v --verify-data $REPOSITORY_G 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_K 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_DB 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_PDB 2>> /root/borgbackup/textdateien/backupintegry.txt

#Gruppe 3
/usr/bin/borg check -v --verify-data $REPOSITORY_PROX1 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_PROX2 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_PROX3 2>> /root/borgbackup/textdateien/backupintegry.txt &
/usr/bin/borg check -v --verify-data $REPOSITORY_PROX4 2>> /root/borgbackup/textdateien/backupintegry.txt


