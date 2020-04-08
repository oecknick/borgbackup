#!/bin/bash

du -s /mnt/backups/repository/* | sort -rn | head -n 10 | awk '{printf (($1/1024)/1024)" GByte - " $2"\n", $1,$2}'
