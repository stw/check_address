#!/bin/bash 

# 30 0 * * * steve /home/steve/address/check.sh

EMAIL=you@yourdomain.com
DIR=`pwd`

if [ -f $DIR/address.txt ]; then
	mv $DIR/.address.txt $DIR/.address.txt.old
else 
	touch $DIR/.address.txt.old
fi 

wget -O $DIR/.address.txt -q  http://internetaddress.me/address.txt

diff $DIR/.address.txt $DIR/.address.txt.old > /dev/null
if [ $? = "1" ]; then
	ip=`cat $DIR/.address.txt`
	echo "IP Address: $ip" | mail -s "Fios IP (Home) Changed" $EMAIL
fi
