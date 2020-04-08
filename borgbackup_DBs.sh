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

#Zeitstempel Start in Logdatei eintragen
echo "Beginn BackupDBs - "$(date) >> borglog.txt


day="1d"
daily="7"
weekly="4"
monthly="6"
testlauf="--dry-run"

#Sage BORG wo sich das Repository befindet
REPOSITORY_DB="/mnt/backups/repository/AMTDB048_DatenBankBackups"
REPOSITORY_PDB="/mnt/backups/repository/AMTDB048_ProgressBackups"

#Wer soll die Mails bekommen
recipient=$(cat .mail 2>&1)

#Eventuelles Lock des Repos entfernen
/usr/bin/borg break-lock $REPOSITORY_DB
/usr/bin/borg break-lock $REPOSITORY_PDB

#COMPRESSION="zstd,10" #original war zlib,6
COMPRESSION="zlib,0"

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat .wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Führe die Backups durch
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_DB::AMTDB048_E_DBBackup-{now:%Y-%m-%d-%T} /mnt/DatenBankBackups 2>> /var/log/borgbackup/borbackup.log
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_PDB::AMTDB048_E_HH-{now:%Y-%m-%d-%T} /mnt/ProgressBackups 2>> /var/log/borgbackup/borbackup.log


#Aufräumen der Backup-Archive (behalte nur notwendiges)
#behalte immer das Archiv von gestern
#behalte zusätzlich ein Archiv der letzten 7 Tage
#behalte zusätzlich ein Archiv der letzten 4 Wochen
#behalte zusätzlich ein Archiv der letzten 6 Monate
#/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_DB
#/usr/bin/borg prune -v --list --keep-within="$day" --keep-daily="$daily" --keep-weekly="$weekly" --keep-monthly="$monthly" $REPOSITORY_PDB


#Versende Mail ob die Datenbanken erfolgreich gesichert wurden
if [ $? = 0 ]
	then
	#echo Hatta gut gemacht
	/usr/bin/mail -s "BorgBackup DB-Sicherungs-Script" $recipient < textdateien/erfolg_DB.txt
	else
	#echo Hatta nich so gut gemacht
	/usr/bin/mail -s "BorgBackup DB-Sicherungs-Script" $recipient < textdateien/misserfolg_DB.txt
fi



#Zeitstempel Ende in Logdatei eintragen
echo "Ende BackupDBs - "$(date) >> borglog.txt
