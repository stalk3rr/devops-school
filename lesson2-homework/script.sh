#!/bin/bash
echo 'Devops School Homework. Task 2'
echo 'Script should generate X non-empty files'
echo 'Script should copy files to VM1'
echo 'Script should control and remove files older than 7 days'
echo

filesnum=5
namevar=homework

echo
echo 'Will be created' $filesnum 'files'
filevar=1
mkdir -p /home/stalk3rr-4096/homework/2
cd /home/stalk3rr-4096/homework/2

echo 'Removing old files'
echo
rm -rf /home/stalk3rr-4096/homework/2/*

until [ $filevar -gt $filesnum ]
do
echo 'Creating File #'$filevar
echo
base64 /dev/urandom | head -c 10000000 > $namevar-$filevar.task2
((filevar=filevar+1))
done

echo 'Files have been created'
echo
echo 'Starting copy files to VM1'
ssh root@10.166.0.2 "mkdir -p /home/stalk3rr-4096/homework/"
rsync -avz /home/stalk3rr-4096/homework/2/ root@10.166.0.2:/home/stalk3rr-4096/homework/2/

echo
sleep 1
echo 'Removing files older than 7 days'
ssh root@10.166.0.2 "find /home/stalk3rr-4096/homework/ -type f -mtime +7 -name '*.task2' -execdir rm -- '{}' \;"