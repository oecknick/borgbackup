#!/bin/sh

day="1d"
daily="7"
weekly="4"
monthly="6"
testlauf="--dry-run"

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
PASSWORD=$(cat .wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Aufräumen der Backup-Archive (behalte nur notwendiges)
#behalte immer das Archiv von gestern
#behalte zusätzlich ein Archiv der letzten 7 Tage
#behalte zusätzlich ein Archiv der letzten 4 Wochen
#behalte zusätzlich ein Archiv der letzten 6 Monate
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_O
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_M
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_I
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_H
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_G
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_K
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_DB
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PDB
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PROX1
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PROX2
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PROX3
/usr/bin/borg prune $testlauf --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PROX4


