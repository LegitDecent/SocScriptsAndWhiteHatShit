#!/bin/bash
echo "This tool will search for offending domain name on either Threatcrowd and AbuseIPDB or all 8 threat sources. Note, you must leave off http(s):// and www. from ANY site you wish to search, and you can search by IP's. Files that are searched from must contain either domains (website.com format) or IP's each on a new line with no delimiters"
while true
do
  # (1) prompt user, and read command line argument
  read -p "Limited sources(l) or all(a) " choice

  # (2) handle the input we were given
  case $choice in
   [lL]* )
            while true
            do
              # (1) prompt user, and read command line argument
              read -p "Would you like to 'Input from File'(f) or 'Command Line'(c)? " answer

              # (2) handle the input we were given
              case $answer in
               [fF]* ) echo "Enter the file path"
                       read filepath
                       while read i ; do ping -4 -c 1 $i | head -1 >>/tmp/iplist.txt ; done < $filepath
                       cat /tmp/iplist.txt | cut  -d '(' -f2 > /tmp/iplist1.txt
                       cat /tmp/iplist1.txt | cut -d ')' -f1 > /tmp/iplist2.txt
                       cp /tmp/iplist2.txt /tmp/iplist3.txt
                       paste -d"\n" $filepath /tmp/iplist3.txt > /tmp/final.txt
                       cat /tmp/final.txt
                       while read i ; do xdg-open https://www.abuseipdb.com/check/$i ; done < /tmp/iplist3.txt
                       while read i ; do xdg-open https://www.threatcrowd.org/ip.php?ip=$i ; done < /tmp/iplist3.txt
                       rm /tmp/iplist.txt
                       rm /tmp/iplist1.txt
                       rm /tmp/iplist2.txt
                       rm /tmp/iplist3.txt
                       rm /tmp/final.txt
                       break;;

               [cC]* ) echo "Enter the FQDN's or IP's seperated by carriage returns, when you are done press q to quit"
                       while read LINE
                       do
                       echo $LINE >> /tmp/op
                       if [ "$LINE" = "q" ];then
                       break
                       fi
                       done
                       sed '$d' /tmp/op > /tmp/op1 ; mv /tmp/op{1,}
                      while read i ; do ping -4 -c 1 $i | head -1 >>/tmp/iplist.txt ; done < /tmp/op
                       cat /tmp/iplist.txt | cut  -d '(' -f2 > /tmp/iplist1.txt
                       cat /tmp/iplist1.txt | cut -d ')' -f1 > /tmp/iplist2.txt
                       cp /tmp/iplist2.txt /tmp/iplist3.txt
                       paste -d"\n" /tmp/op /tmp/iplist3.txt > /tmp/final.txt
                      while read i ; do xdg-open https://www.abuseipdb.com/check/$i ; done < /tmp/iplist3.txt
                      while read i ; do xdg-open https://www.threatcrowd.org/ip.php?ip=$i ; done < /tmp/iplist3.txt
                       rm /tmp/iplist.txt
                       rm /tmp/iplist1.txt
                       rm /tmp/iplist2.txt
                       rm /tmp/iplist3.txt
                       cat /tmp/final.txt
                       rm /tmp/final.txt
                       rm /tmp/op
                      break;;

               * )     echo "Enter f to read from a file or c to read from command line.";;
              esac
            done

           break;;

   [aA]* )
           while true
do
  # (1) prompt user, and read command line argument
  read -p "Would you like to 'Input from File'(f) or 'Command Line'(c)? " answer

  # (2) handle the input we were given
  case $answer in
                 [fF]* ) echo "Enter the file path"
                         read FilePath
                        while read i ; do ping -4 -c 1 $i | head -1 >>/tmp/iplist.txt ; done < $FilePath
                         cat /tmp/iplist.txt | cut  -d '(' -f2 > /tmp/iplist1.txt
                         cat /tmp/iplist1.txt | cut -d ')' -f1 > /tmp/iplist2.txt
                         cp /tmp/iplist2.txt /tmp/iplist3.txt
                         paste -d"\n" $FilePath /tmp/iplist3.txt > /tmp/final.txt
                         cat /tmp/final.txt
                         while read i ; do xdg-open https://www.abuseipdb.com/check/$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://www.threatcrowd.org/ip.php?ip=$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://www.virustotal.com/gui/search/$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://sitecheck.sucuri.net/results/$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://search.arin.net/rdap/?query=$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://www.threatminer.org/host.php?q=$i ; done < /tmp/iplist3.txt
                         while read i ; do xdg-open https://www.shodan.io/host/$i ; done < /tmp/iplist3.txt
                         echo list|tr -d "\r"|while read url; do
                            curl -X POST "https://urlscan.io/api/v1/scan/" \
                               -H "Content-Type: application/json" \
                               -H "API-Key:{PutYourKeyHereNerd}" \
                               -d "{\"url\": \"$url\", \"public\": \"on\"}"
                            sleep 2;
                          done < /tmp/iplist3.txt | grep '"result":' | cut -d ' ' -f4 > /tmp/asdf
                          sed 's/"//' /tmp/asdf > /tmp/asdf1
                          sed 's/"//' /tmp/asdf1 > /tmp/asdf2
                          sed 's/,//' /tmp/asdf2 > /tmp/asdf3
                          echo "Sleeping for 90 seconds so URLSCAN can process results: "
                          sleep 90;
                         while read u ; do xdg-open $u ; done < /tmp/asdf3
                         rm /tmp/iplist.txt
                         rm /tmp/iplist1.txt
                         rm /tmp/iplist2.txt
                         rm /tmp/iplist3.txt
                         rm /tmp/final.txt
			 rm /tmp/asd**
                         break;;

                 [cC]* )
                       echo "Enter the FQDN's or IP's seperated by carriage returns, when you are done press q to quit"
                       while read LINE
                       do
                       echo $LINE >> /tmp/op
                       if [ "$LINE" = "q" ];then
                       break
                       fi
                       done
                       sed '$d' /tmp/op > /tmp/op1 ; mv /tmp/op{1,}
                       while read i ; do ping -4 -c 1 $i | head -1 >>/tmp/iplist.txt ; done < /tmp/op
                        cat /tmp/iplist.txt | cut  -d '(' -f2 > /tmp/iplist1.txt
                        cat /tmp/iplist1.txt | cut -d ')' -f1 > /tmp/iplist2.txt
                        cp /tmp/iplist2.txt /tmp/iplist3.txt
                        paste -d"\n" /tmp/op /tmp/iplist3.txt > /tmp/final.txt
                         while read i ; do xdg-open https://www.abuseipdb.com/check/$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://www.threatcrowd.org/ip.php?ip=$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://www.virustotal.com/gui/search/$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://sitecheck.sucuri.net/results/$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://search.arin.net/rdap/?query=$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://www.threatminer.org/host.php?q=$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         while read i ; do xdg-open https://www.shodan.io/host/$i ; done < /tmp/iplist3.txt
                         sleep .5;
                         echo list|tr -d "\r"|while read url; do
                            curl -X POST "https://urlscan.io/api/v1/scan/" \
                               -H "Content-Type: application/json" \
                               -H "API-Key:PutYourKeyHereNerd" \
                               -d "{\"url\": \"$url\", \"public\": \"on\"}"
                            sleep 2;
                          done < /tmp/iplist3.txt | grep '"result":' | cut -d ' ' -f4 > /tmp/asdf
                          sed 's/"//' /tmp/asdf > /tmp/asdf1
                          sed 's/"//' /tmp/asdf1 > /tmp/asdf2
                          sed 's/,//' /tmp/asdf2 > /tmp/asdf3
                          echo "Sleeping for 90 seconds so URLSCAN can process results: "
                          sleep 90;
                         while read u ; do xdg-open $u ; done < /tmp/asdf3
                       rm /tmp/iplist.txt
                       rm /tmp/iplist1.txt
                       rm /tmp/iplist2.txt
                       rm /tmp/iplist3.txt
                       cat /tmp/final.txt
                       rm /tmp/final.txt
                       rm /tmp/op
                       rm /tmp/asd**
                        break;;

                 * )     echo "Enter f to read from a file or c to read from command line.";;
                esac
              done

          break;;

   * )     echo "Enter f to read from a file or c to read from command line.";;
  esac
done
