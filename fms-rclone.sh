#!/bin/bash
# Claris FileMaker Server Off-site Backup using rclone
# By Mohamed H. Tawfiq - mhtawfiq@gmail.com
# 20231128 - Initial Release

# FileMaker Server Backups Folder
fmsbackupsf="/opt/FileMaker/FileMaker Server/Data/Backups"

# rclone Remote
rcr="fms-backup"

# S3 Bucket Name
s3="fms-backup1"

# Retention Policy
rdaily=90
rweekly=24
rmonthly=36

# Day of the Week for Weekly Backups
# Monday (1) to Sunday (7)
dweekly=2

# Day of the Month for Monthly Backups
dmonthly=28


###
### No Need to Edit Anything After This Line ###
###


# Latest Folder
cd "${fmsbackupsf}"
latestf=$(ls -td -- */ | head -n 1 | cut -d'/' -f1)

# FileMaker Server Default Backups Day Timestamp
fmday=$(date +%Y-%m-%d)

# rclone Copy Backups to Remote

echo "${fmsbackupsf}/${latestf}" ${rcr}:${s3}/daily/${latestf}

# Daily
rclone copy "${fmsbackupsf}/${latestf}" ${rcr}:${s3}/daily/${latestf}

# Weekly
if [ $(date +%u) -eq $dweekly ]
then
        rclone copy "${fmsbackupsf}/${latestf}" ${rcr}:${s3}/weekly/${latestf}
fi

# Monthly
if [ $(date +%d) -eq $dmonthly ]
then
        rclone copy "${fmsbackupsf}/${latestf}" ${rcr}:${s3}/monthly/${latestf}
fi

# Clean Remote
rclone delete --rmdirs --min-age ${rdaily}d ${rcr}:${s3}/daily
rclone delete --rmdirs --min-age ${rweekly}w ${rcr}:${s3}/weekly
rclone delete --rmdirs --min-age ${rmonthly}M ${rcr}:${s3}/monthly
