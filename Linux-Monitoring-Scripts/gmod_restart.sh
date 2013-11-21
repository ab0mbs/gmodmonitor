#!/bin/bash

# This script run on the monitoring server and checks to see if the server is "Alive"
# If the server is down, it attempts to kill the Gmod process on the server which forces the local Gmod restart script to restart the server
# This script will then email you to let you know your server crashed and what the outcome is.
# Either the server is "RUNNING" or "SERVER DOWN"

#Set variables 
DATE="`date +%c`"

#Change the "0.0.0.0" to your Gmod servers IP address. A DNS address should also work here.
ip_addr="0.0.0.0"
inc=1
srvtest=0
srv_connection="NULL"
count=3

#This is pulling the pid of the process from the Gmod server. This url will be dependent on how you set things up.
gmod_pid="`lynx -dump \"http://example.com/gmod_pid.txt\"`"

#Test server status. This checking a php page that will query the server to check if it's alive.
lynx -dump "http://example.com/gmod_query.php" | grep 'Alive' >/dev/null

#Check if server failed test
if [ $? = "1" ]; then

#Echo server failure to log
echo $DATE: Connection Failed - Restarting Gmod Server

#Attempt to restart server. This will ssh into your server and kill the Gmod process, letting the local restart script kick in.
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
