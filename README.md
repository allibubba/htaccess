## htaccess generator
for use when generating a htaccess file, with random user and password. Script outputs .htaccess file and a text file named GENERATED-PASSWORD.txt

This script is best called from incron, when monitoring a location for directory creation.


combine with cron task to remove GENERATED-PASSWORD.txt
    
    find /dir/ -name GENERATED-PASSWORD.txt  -exec rm -rf {} \;

