## Claris FileMaker Server rclone Off-Site Backups on Ubuntu
This Bash script takes the latest daily FileMaker Server default Auto-Backup and creates an off-site backup using rclone on AWS S3 or other rclone supported storage backends.
It also maintains a retention policy for backups on a Daily, Weekly and Monthly basis.

### Reference Article
Link Here

### Logged in as root:
```
cd ~/
mkdir fms-ssl
cd fms-ssl/
```
### Download & make executable
```
wget https://raw.githubusercontent.com/mhtawfiq/filemaker-server-rclone/main/fms-backup.sh
chmod +x fms-backup.sh
``` 
### Edit content of scripts
```
nano fms-backup.sh
```
Set bacups folder, rclone remote, retention policy, weekly backup day and monthly backup day:
```
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
```


### Links
**rclone**: https://rclone.org/
