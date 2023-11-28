#!/bin/bash
# FileMaker Server Off-site Backup using rclone
# By Mohamed H. Tawfiq - mhtawfiq@gmail.com
# 20231128 - Initial Release

# FileMaker Server Backups Folder
fmsbackupsf="/opt/FileMaker/FileMaker Server/Data/Backups"

# rclone Remote
rcr="fms-backup"

# Retention Policy
rdaily=90
rweekly=24
rmonthly=36

# Day of the Week for Weekly Backups
# Monday (1) to Sunday (7)
dweekly=7

# Day of the Month for Monthly Backups
dmonthly=1


###
### No Need to Edit Anything After This Line ###
###


# FileMaker Server Default Backups Day Timestamp
fmday=$(date +%Y-%m-%d)

# rclone Copy Backups to Remote

# Daily 
rclone copy --create-empty-src-dirs ${fmsbackupsf}/*_${fmday}_* ${rcr}:fms-backup/daily

# Weekly
if [ $(date +%u) -eq $dweekly ]
then
	rclone copy --create-empty-src-dirs ${fmsbackupsf}/*_${fmday}_* ${rcr}:fms-backup/weekly
fi

# Monthly
if [ $(date +%d) -eq $dmonthly ]
then
	rclone copy --create-empty-src-dirs ${fmsbackupsf}/*_${fmday}_*/ ${rcr}:fms-backup/monthly
fi

# Clean Remote
rclone delete --min-age ${rdaily}d ${rcr}:fms-backup/daily
rclone delete --min-age ${rweekly}w ${rcr}:fms-backup/daily
rclone delete --min-age ${rmonthly}M ${rcr}:fms-backup/weekly
