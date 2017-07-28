#!/bin/bash
USERID="XXX" #Chat to @get_id_bot
KEY="XXX" #Telegram Secret Code
URL="https://api.telegram.org/bot$KEY/sendMessage"
TIMEOUT="10"
threshold="90" #Set Custom Threshold
i=2
result=`df -kh /dev/sda1 |grep -v "Filesystem" | awk '{ print $5 }' | sed 's/%//g'`

for percent in $result; do
	if ((percent > threshold))
then
	partition=`df -kh | head -$i | tail -1| awk '{print $1}'`
	TEXT="$partition at $(hostname -f) is ${percent}% full"
	curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
fi
	let i=$i+1

done
