#!/bin/bash

 

var=$(date +"%FORMAT_STRING")

now=$(date +"%m_%d_%Y")

today=$(date +"%Y-%m-%d")

 

mkdir /Scans/${today}

while read i ; do curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress="$i -d maxAgeInDays=90 -d verbose -H "Key: PutYourKeyHereNerd" -H "Accept: application/json"  >>/Scans/${today}/reports.txt; done < /Scans/1.txt

 

cat /Scans/${today}/reports.txt | grep -oP "totalReports.{0,3}" >/Scans/${today}/reportsPruned.txt

 

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 1 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 2 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 3 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 4 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 5 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 6 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 7 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 8 >>/Scans/${today}/violations.txt

cat /Scans/${today}/reportsPruned.txt | grep -oP "totalReports.{0,3}" | grep 9 >>/Scans/${today}/violations.txt