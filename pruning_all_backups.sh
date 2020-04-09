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
#                                                                          #
############################################################################

#Wer soll die Mails bekommen
recipient=$(cat .mail 2>&1)

PFAD="/root/borgbackup"

day="1d"
daily="7"
weekly="4"
monthly="6"
#testlauf="--dry-run" #Testlauf
testlauf="" #Produktiv

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

COMPRESSION="zstd,15" #original war zlib,6

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat /root/borgbackup/.wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

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

#Ermittle den aktuell genutzten Platz auf dem Raid6 /mnt/backups...
echo "Hallo Admin,\n" > /tmp/space.txt
echo "ich, das stolze Pruning-Script, habe in den Backups aufgeräumt" >> /tmp/space.txt
SPACE=$(df -lh |awk  '{printf "Info: Auf dem Backupverzeichnis "$6" sind "$3" von "$2" belegt.\n"}'|grep backups)

echo $SPACE >> /tmp/space.txt

echo "\n\nMelde mich morgen wieder.\nDein liebes BorgBackup-Pruning-Script" >> /tmp/space.txt

#Versende Mail ob oder ob nicht aufgeräumt wurde
if [ $? = 0 ]
	then
	#echo Hatta gut gemacht
	/usr/bin/mail -s "BorgBackupStore Pruning-Script" $recipient < /tmp/space.txt
	else
	#echo Hatta nich so gut gemacht
	/usr/bin/mail -s "BorgBackupStore Pruning-Script" $recipient < $PFAD/textdateien/schmutzfink.txt
fi

exit 0

