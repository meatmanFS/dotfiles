#!/bin/bash
#
# Script Name: mysql-databases-backup.sh
#
# Author: Stanko Metodiev
# Author Email: stanko@metodiew.com
# Author URL: https://metodiew.com
# Date : 2017.10.22
#
# Description: This is a script for a backup of all important files of my computer. A note, the script is designed to work with my Linux machine. However, most of the important files. Feel free to re-use and adjust the script for your own use :)

# Get the today's date
NOW="`date +%Y%m%d`";

# MySQL detailes here
USER="root"
PASSWORD="root" # Enter your MySQL password here

###########################################
#### Let's start with the MySQL backup ####
###########################################

# Create a new folder
mkdir $NOW;

databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
	# Backup each database to the new created folder
        mysqldump -u $USER -p$PASSWORD $db > $NOW/$NOW.$db.sql
    fi
done

# Archive the new created folder with all dumped databases. Then create an archive and delete the folder.
zip -r $NOW.zip $NOW;
mv $NOW.zip '/mnt/5DB56B841BB28CF1/Backup Files/WWW Backup/Apache/SQLs';
rm -r $NOW;
