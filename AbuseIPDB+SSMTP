#!/bin/bash

var=$(date +"%FORMAT_STRING")
now=$(date +"%m_%d_%Y")
today=$(date +"%Y-%m-%d")

mkdir /Scans/${today}
while read i ; do curl -G https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress="$i -d maxAgeInDays=90 -d verbose -H "Key: $KEY-GOES-HERE" -H "Accept: application/json"  >>/Scans/${today}/reports.txt; done < /Scans/1.txt

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

FILE=/Scans/${today}/violations.txt
if [[ -s $FILE ]] ; then
    echo "From: ABUSEIPDB@WEBDOMAIN.COM" >>/Scans/${today}/build_violations_email.txt
    echo "Subject: WARNING: ABUSEIPDB Violations have been found." >>/Scans/${today}/build_violations_email.txt
    echo "" >>/Scans/${today}/build_violations_email.txt
    echo "Check /Scans/${today}/violations.txt on host HOST_IP_HERE for more info." >>/Scans/${today}/build_violations_email.txt
    echo "" >>/Scans/${today}/build_violations_email.txt
    cat /Scans/${today}/violations.txt >>/Scans/${today}/build_violations_email.txt
    ssmtp -v DOMAINtoSEND@to.com < /Scans/${today}/build_violations_email.txt
else
    echo "From: ABUSEIPDB@WEBDOMAIN.COM" >>/Scans/${today}/build_safe_email.txt
    echo "Subject: No violations found" >>/Scans/${today}/build_safe_email.txt
    echo "" >>/Scans/${today}/build_safe_email.txt
    echo "Please pull all logs from host to Sharepoint on the last Friday of every month." >>/Scans/${today}/build_safe_email.txt
    ssmtp -v DOMAINtoSEND@to.com < /Scans/${today}/build_safe_email.txt
fi ;
