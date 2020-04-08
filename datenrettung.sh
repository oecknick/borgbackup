#!/bin/sh

#Wenn Verzeichnis gemountet, reisse es raus
if [ -d /mnt/rescuedir/mnt ]; then
   umount /mnt/rescuedir
fi

#Hole das Passwort (benutze NICHT das Admin/Root-Passwort !!)
PASSWORD=$(cat .wuqdwqoudwiquhxiugnfiu43t734t87 2>&1) 

#Übergebe das Passwort
export BORG_PASSPHRASE="$PASSWORD"

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

echo "\nLos komm' wir retten jetzt Daten ;-)\n"
echo "Auf diesem Storage liegen bis max. 6 Monate alte Backups von:"
echo "Von welcher Sicherung soll ein Backup ausgepackt werden?\n"
echo "Auswahl:"
echo "( d ) Sicherung der MS-SQL-Datenbanken von AMTDB048 (SQL-Datenbanken von Avviso, SFirm, Loga, Archikart4, Meso und Winyard)"
echo "( p ) Sicherung der Progressdatenbanken (HKR) von AMTDB048 (HKR-Datenbanken)"
echo "( o ) Alle Sicherungen von Laufwerk O (Daten für Installationen)"
echo "( k ) Alle Sicherungen von Laufwerk K (Daten aus der Datenablage)"
echo "( g ) Alle Sicherungen von Laufwerk G (Daten aus dem Gruppenlaufwerk)"
echo "( h ) Alle Sicherungen von Laufwerk H (Daten der User)"
echo "( m ) Alle Sicherungen von Laufwerk M (Profile der User)"
echo "( i ) Alle Sicherungen von Laufwerk I (Daten aller Fachanwendungen)"
echo "( 1 ) Alle gesicherten VMs von Proxmox-1)"
echo "( 2 ) Alle gesicherten VMs von Proxmox-2)"
echo "( 3 ) Alle gesicherten VMs von Proxmox-3)"
echo "( 4 ) Alle gesicherten VMs von Proxmox-4)\n"



read -p "Von welcher Sicherung soll ein Backup ausgepackt werden?: " sicherung

case $sicherung in
	d|D)
		holebackupsvon=$REPOSITORY_DB
		datenhalde="DatenBankBackups"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTDB048 Verzeichnis \"E:\DBBackup\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/avviso /mnt/$datenhalde/"
		;;
	p|P)
		holebackupsvon=$REPOSITORY_PDB
		datenhalde="ProgressBackups"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTDB048 Verzeichnis \"E:\HH\Backup\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	o|O)
		holebackupsvon=$REPOSITORY_O
		datenhalde="Laufwerk_O"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Admin\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde<irgendwas> /mnt/$datenhalde/"
		;;
	k|K)
		holebackupsvon=$REPOSITORY_K
		datenhalde="Laufwerk_K"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Daten_3\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	g|G)
		holebackupsvon=$REPOSITORY_G
		datenhalde="Laufwerk_G"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Gruppen\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	h|H)
		holebackupsvon=$REPOSITORY_H
		datenhalde="Laufwerk_H"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Nutzer\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	m|M)
		holebackupsvon=$REPOSITORY_M
		datenhalde="Laufwerk_M"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Profile\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	i|I)
		holebackupsvon=$REPOSITORY_I
		datenhalde="Laufwerk_I"
		help="Mit \"cp -rf <Verzeichnisname>\" kannst Du die entsprechende/n Dateie/n ins Laufwerk /mnt/$datenhalde kopieren.\nDas ist ein direkt gemountetes Verzeichnis von AMTAS005 Verzeichnis Infodat\".\nBeispiel: cp -rf /mnt/rescuedir/mnt/$datenhalde/<irgendwas> /mnt/$datenhalde/"
		;;
	1)
		holebackupsvon=$REPOSITORY_PROX1
		datenhalde="backups/dump"
		help="Mit \"scp -rv /mnt/rescuedir/mnt/$datenhalde/<irgendwas> root@192.168.100.35:/mnt/$datenhalde/\" kannst Du die entsprechende/n Dateie/n direkt zum Proxmox-Server1 kopieren."
		;;
	2)
		holebackupsvon=$REPOSITORY_PROX2
		datenhalde="backups/dump"
		help="Mit \"scp -rv /mnt/rescuedir/mnt/$datenhalde/<irgendwas> root@192.168.100.36:/mnt/$datenhalde/\" kannst Du die entsprechende/n Dateie/n direkt zum Proxmox-Server2 kopieren."
		;;
	3)
		holebackupsvon=$REPOSITORY_PROX3
		datenhalde="backups/dump"
		help="Mit \"scp -rv /mnt/rescuedir/mnt/$datenhalde/<irgendwas> root@192.168.100.37:/mnt/$datenhalde/\" kannst Du die entsprechende/n Dateie/n direkt zum Proxmox-Server3 kopieren."
		;;

	4)
		holebackupsvon=$REPOSITORY_PROX4
		datenhalde="backups/dump"
		help="Mit \"scp -rv /mnt/rescuedir/mnt/$datenhalde/<irgendwas> root@172.26.20.20:/mnt/$datenhalde/\" kannst Du die entsprechende/n Dateie/n direkt zum Proxmox-Server4 kopieren."
		;;

	*)
		echo "Fühle mich ignoriert und beende mich...Pfff..."
		exit 0
		;;
esac

echo "\nZeige alle Infos und die verfügbaren Backups in $holebackupsvon\n"

/usr/bin/borg info $holebackupsvon
/usr/bin/borg list $holebackupsvon

echo "\n"

read -p "Welches Backup soll entschlüsselt und ausgepackt werden? (Copy/Paste): " backup

echo "\nIch entpacke jetzt das Backup: $holebackupsvon::$backup nach /mnt/rescuedir und zeige Dir den Inhalt an."

/usr/bin/borg mount $holebackupsvon::$backup /mnt/rescuedir/

ls -lh /mnt/rescuedir/mnt/$datenhalde

echo "\n$help"

exit 0
