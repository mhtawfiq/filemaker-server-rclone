## Claris FileMaker Server rclone Off-Site Backups on Ubuntu
This bash script takes the latest daily FileMaker Server default Auto-Backup and creates an off-site backup using rclone on AWS S3 or other rclone supported storage backends.
It also maintains a backup retention policy on a Daily, Weekly and Monthly basis.

### Reference Article
https://mhtawfiq.github.io/filemaker-server-off-site-backup-and-retention-policy-with-rclone

### Logged in as root:
```
cd ~/
mkdir fms-rclone
cd fms-rclone/
```
### Download & make executable
```
wget https://raw.githubusercontent.com/mhtawfiq/filemaker-server-rclone/main/fms-rclone.sh
chmod +x fms-rclone.sh
``` 
### Edit content of scripts
```
nano fms-backup.sh
```
Set FileMaker Server backups folder, rclone remote, s3 bucket, retention policy, weekly backup day and monthly backup day:
```
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
dweekly=1

# Day of the Month for Monthly Backups
dmonthly=1
```


### Links
**rclone**: https://rclone.org/
