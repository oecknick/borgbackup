#!/bin/sh

SPACE=$(df -lh |awk  '{printf "Auf dem Backupverzeichnis "$6" sind "$3" von "$2" belegt.\n"}'|grep backups)

echo $SPACE

