Gmod Monitor
===========

Scripts to monitor and keep a gmod server running

Prerequisites:
--------------

  I currently run this on a Linux server to monitor a Gmod server running on windows. In the future, I will work to make this all run locally on the Gmod server regardless of OS.
  
  Currently, a Linux server is needed to monitor the Gmod server.

  * Linux Server to run monitoring with lynx and optionally a program of your choice to send email. I'm using ssmtp
  * Website with PHP. This can run on the monitoring server or on the server running gmod. This will be used to query the status of the server.
  * SSH installed on the Gmod server. If running Windows, you can download SSH for windows.
  

Repo Layout
--------------

  * Linux monitoring server scripts folder.
  * Windows Gmod server scripts folder.

