#!/bin/sh

echo "Backupeinstellungen"
echo "behalte Backups von gestern"
echo "zusätzlich behalte die aktuellsten Backups der letzten 7 Tage"
echo "zusätzlich behalte die aktuellsten Backups der letzten 4 Wochen"
echo "zusätzlich behalte die aktuellsten Backups der letzten 6 Monate"



#Sage BORG wo sich das Repository befindet
REPOSITORY_O="/mnt/backups/repository/AMTAS005_Laufwerk_O"
REPOSITORY_M="/mnt/backups/repository/AMTAS005_Laufwerk_M"
REPOSITORY_N="/mnt/backups/repository/AMTAS005_Laufwerk_N"
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
PASSWORD=$(cat .wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Laufwerk O
echo "\n\033[1;33mInfos zu Backup Laufwerk O\\033[;0m\n"
echo "Ablageort: $REPOSITORY_O::\n"
/usr/bin/borg info $REPOSITORY_O
echo "\n\033[1;34mBackup-Archive von Laufwerk O\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_O
#/usr/bin/borg list $REPOSITORY_M
#/usr/bin/borg list $REPOSITORY_N
#/usr/bin/borg list $REPOSITORY_I
#/usr/bin/borg list $REPOSITORY_H
#/usr/bin/borg list $REPOSITORY_G

#Laufwerk K
echo "\n\033[1;33mInfos zu Backup Laufwerk K\\033[;0m\n"
echo "Ablageort: $REPOSITORY_K::\n"
/usr/bin/borg info $REPOSITORY_K
echo "\n\033[1;34mBackup-Archive von Laufwerk K\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_K

#Laufwerk G
echo "\n\033[1;33mInfos zu Backup Laufwerk G\\033[;0m\n"
echo "Ablageort: $REPOSITORY_G::\n"
/usr/bin/borg info $REPOSITORY_G
echo "\n\033[1;34mBackup-Archive von Laufwerk G\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_G

#Laufwerk M
echo "\n\033[1;33mInfos zu Backup Laufwerk M\\033[;0m\n"
echo "Ablageort: $REPOSITORY_M::\n"
/usr/bin/borg info $REPOSITORY_M
echo "\n\033[1;34mBackup-Archive von Laufwerk M\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_M

#Laufwerk H
echo "\n\033[1;33mInfos zu Backup Laufwerk H\\033[;0m\n"
echo "Ablageort: $REPOSITORY_H::\n"
/usr/bin/borg info $REPOSITORY_H
echo "\n\033[1;34mBackup-Archive von Laufwerk H\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_H

#Laufwerk I
echo "\n\033[1;33mInfos zu Backup Laufwerk I\\033[;0m\n"
echo "Ablageort: $REPOSITORY_I::\n"
/usr/bin/borg info $REPOSITORY_I
echo "\n\033[1;34mBackup-Archive von Laufwerk I\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_I

#Datenbanken SQL-Server
echo "\n\033[1;33mInfos zu SQL-DB-Backup\\033[;0m\n"
echo "Ablageort: $REPOSITORY_DB::\n"
/usr/bin/borg info $REPOSITORY_DB
echo "\n\033[1;34mBackup-Archive von SQL-DB-Backup\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_DB

#Datenbanken HKR
echo "\n\033[1;33mInfos zu HKR-Progress-Backup\\033[;0m\n"
echo "Ablageort: $REPOSITORY_PDB::\n"
/usr/bin/borg info $REPOSITORY_PDB
echo "\n\033[1;34mBackup-Archive von HKR-Progress-Backup\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_PDB

#VM's und Container Proxmox1
echo "\n\033[1;33mInfos zu Backups Proxmox1\\033[;0m\n"
echo "Ablageort: $REPOSITORY_PROX1::\n"
/usr/bin/borg info $REPOSITORY_PROX1
echo "\n\033[1;34mBackup-Archive von Proxmox1\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_PROX1


#VM's und Container Proxmox2
echo "\n\033[1;33mInfos zu Backups Proxmox2\\033[;0m\n"
echo "Ablageort: $REPOSITORY_PROX2::\n"
/usr/bin/borg info $REPOSITORY_PROX2
echo "\n\033[1;34mBackup-Archive von Proxmox2\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_PROX2


#VM's und Container Proxmox3
echo "\n\033[1;33mInfos zu Backups Proxmox3\\033[;0m\n"
echo "Ablageort: $REPOSITORY_PROX3::\n"
/usr/bin/borg info $REPOSITORY_PROX3
echo "\n\033[1;34mBackup-Archive von Proxmox3\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_PROX3


#VM's und Container Proxmox4
echo "\n\033[1;33mInfos zu Backups Proxmox4\\033[;0m\n"
echo "Ablageort: $REPOSITORY_PROX4::\n"
/usr/bin/borg info $REPOSITORY_PROX4
echo "\n\033[1;34mBackup-Archive von Proxmox4\\033[;0m\n"
/usr/bin/borg list $REPOSITORY_PROX4

