#!/bin/sh

##############################################################################################
#                                                                                            #
# Installation:                                                                              #
#                                                                                            #
# Zuerst Paketquelle für pbis-open hinzufügen                                                #
#                                                                                            #
# wget -O - http://repo.pbis.beyondtrust.com/apt/RPM-GPG-KEY-pbis|sudo apt-key add -         #
# wget -O /etc/apt/sources.list.d/pbiso.list http://repo.pbis.beyondtrust.com/apt/pbiso.list #
# apt-get update                                                                             #
#                                                                                            #
# Dann notwendige Pakete installieren                                                        #
#                                                                                            #
# apt install borgbackup cifs-utils pbis-open                                                #
#                                                                                            #  
# Danach rebooten und der Domäne beitreten                                                   #
# domainjoin-cli join amtintern.muela.de Administrator                                       #
# Nochmals rebooten und testen mit                                                           #
# getent passwd                                                                              #
#                                                                                            #
# Wenn hier alle User aus der Domäne angezeigt werden war der Betritt erfolgreich            #
# und das System mit pbis ist bootfest.                                                      #
#                                                                                            #
#                                                                                            #
# cifs-Mount von Hand durchführen und auf mitgenommene Metadaten testen                      #
# getfacl /mnt/<Laufwerk>                                                                    #
# Tipp: Auf amtas014 ist ein funktionierender cifs-mount in der fstab                        #
#                                                                          ###################  
#                                                                          #
# Erstes Repository anlegen per SSH:                                       #
# borg init --encryption=keyfile thoe@localhost:~/backups/repository       #
#                                                                          #
# Repositories lokal anlegen:                                              #
# borg init --encryption=keyfile /mnt/backups/repository                   #
#                                                                          #
# PW: gsadqw/#76qwehjwgqe78                                                #
#                                                                          #
############################################################################


day="1d"
daily="7"
weekly="4"
monthly="6"
testlauf="--dry-run"

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

COMPRESSION="zstd,15" #original war zlib,6

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat ~/.wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Führe die Backups durch
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_O::Daten_in_O-{now:%Y-%m-%d-%T} /mnt/Laufwerk_O
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_M::Daten_in_M-{now:%Y-%m-%d-%T} /mnt/Laufwerk_M
##/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_N::Daten_in_N-{now:%Y-%m-%d-%T} /mnt/Laufwerk_N
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_I::Daten_in_I-{now:%Y-%m-%d-%T} /mnt/Laufwerk_I
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_H::Daten_in_H-{now:%Y-%m-%d-%T} /mnt/Laufwerk_H
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_G::Daten_in_G-{now:%Y-%m-%d-%T} /mnt/Laufwerk_G
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_K::Daten_in_K-{now:%Y-%m-%d-%T} /mnt/Laufwerk_K
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_DB::AMTDB048_E_DBBackup-{now:%Y-%m-%d-%T} /mnt/DatenBankBackups
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_PDB::AMTDB048_E_HH-{now:%Y-%m-%d-%T} /mnt/ProgressBackups


#Aufräumen der Backup-Archive (behalte nur notwendiges)
#behalte immer das Archiv von gestern
#behalte zusätzlich ein Archiv der letzten 7 Tage
#behalte zusätzlich ein Archiv der letzten 4 Wochen
#behalte zusätzlich ein Archiv der letzten 6 Monate
/usr/bin/borg prune  -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_O
/usr/bin/borg prune  -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_M
#/usr/bin/borg prune -v --list --keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=6 $REPOSITORY_N
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_I
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_H
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_G
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_K
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_DB
/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PDB

