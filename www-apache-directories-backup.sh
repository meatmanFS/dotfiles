#!/bin/bash
#
# Script Name: www-apache-directories-backup.sh
#
# Author: Stanko Metodiev
# Author Email: stanko@metodiew.com
# Author URL: https://metodiew.com
# Date : 2017.10.22
# Description: Prepare an archive file for each html Apache directory.

# Get the today's date
NOW="`date +%Y%m%d`";

mkdir '/mnt/5DB56B841BB28CF1/Backup Files/WWW Backup/Apache/www-directory-backup/'$NOW;
cd /var/www/html;
for dir in `find . -maxdepth 1 -type d  | grep -v "^\.$" `;
	do
		# Create the archive
		echo 'Starting with' ${dir//.\/}'-'$NOW'.zip archive ...';
		sleep 5;			
		zip -r ${dir}-$NOW.zip ${dir};
		
		# Move the created archive to a specific directory
		# Most likely in your case this will be different
		echo 'Moving' ${dir//.\/}'-'$NOW'.zip archive ...';
		mv ${dir}-$NOW.zip '/mnt/5DB56B841BB28CF1/Backup Files/WWW Backup/Apache/www-directory-backup/'$NOW;

		echo 'Ready with' ${dir//.\/}'-'$NOW'.zip archive ...';
		sleep 5;
done
cd '/mnt/5DB56B841BB28CF1/Backup Files/';
