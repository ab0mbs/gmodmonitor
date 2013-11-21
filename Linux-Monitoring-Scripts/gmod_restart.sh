#!/bin/bash

#Set variables 
DATE="`date +%c`"
ip_addr="0.0.0.0"
inc=1
srvtest=0
srv_connection="NULL"
count=3
gmod_pid="`lynx -dump \"http://example.com/gmod_pid.txt\"`"

#Test server port
lynx -dump "http://example.com/gmod_query.php" | grep 'Alive' >/dev/null

#Check if server failed test
if [ $? = "1" ]; then

#Echo server failure to log
echo $DATE: Connection Failed - Restarting Gmod Server

#Attempt to restart server
ssh User@$ip_addr "taskkill /f /pid $gmod_pid" < /dev/null > /dev/null 2>&1 &

#Perform up to 10 tests to check if server is not active
while [[ $inc -le 10 && $srvtest == 0 ]]
do
lynx -dump "http://example.com/gmod_query.php" | grep 'Alive' >/dev/null
if [ $? = "0" ]
then
srvtest=1
srv_connection="RUNNING"
else
srv_connection="SERVER DOWN"
fi
sleep 15
(( inc++ ))
done

#E-mail the results if the server failed and if it was able to be restarted
echo -e "To: FirstName LastName\nFrom: email@company.com\nSubject: Server Connection Failure\n" > /home/user/mail.txt
echo -e "$DATE\n\nGmod Server connection has failed\n\nServer Status: $srv_connection" >> /home/user/mail.txt
/usr/sbin/ssmtp email@company.com < /home/user/mail.txt
echo $DATE Server status: $srv_connection
else

#Echo server up to log. No e-mail needed
echo $DATE: Connection Successful
fi
