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

#Wo bin ich
PFAD="/root/borgbackup"

#Wer soll die Mails bekommen
recipient=$(cat $PFAD/.mail 2>&1)

#Sage BORG wo sich das Repository befindet
REPOSITORY_M="/mnt/backups/repository/AMTAS005_Laufwerk_M"

#Eventuelles Lock des Repos entfernen
/usr/bin/borg break-lock $REPOSITORY_M

#Kompression der Daten
COMPRESSION="lz4"

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat $PFAD/.wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

#Führe die Backups durch
/usr/bin/borg create -vspC $COMPRESSION $REPOSITORY_M::Daten_in_M-{now:%Y-%m-%d-%T} /mnt/Laufwerk_M 2>> /var/log/borgbackup/borbackup.log


#Versende Mail ob die Daten erfolgreich gesichert wurden
if [ $? = 0 ]
	then
	#echo Hatta gut gemacht
	/usr/bin/mail -s "BorgBackup LW-M-Sicherungs-Script" $recipient < $PFAD/textdateien/erfolg_M.txt
	else
	#echo Hatta nich so gut gemacht
	/usr/bin/mail -s "BorgBackup LW-M-Sicherungs-Script" $recipient < $PFAD/textdateien/misserfolg_M.txt
fi

