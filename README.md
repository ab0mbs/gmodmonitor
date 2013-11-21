Gmod Monitor
===========

Scripts to monitor and keep a gmod server running

The Windows Gmod server scripts can be used basically out of the box to keep a gmod server running.
The Linux monitoring is for special situations where gmod has crashed but the process itself has not really crashed. An example of this is if the Gmod server crashes and displays a pop up message about something. The server has crashed at this point but the restart script still sees the process as running. The Linux monitoring solution solves this. It sees that the server is not alive anymore and will kill the Gmod process, forcing the restart script to kick in and finish it's job.

I will note that this is a custom tailored solution I came up with to work with what I had available and my needs. This may or may not help you with your needs.

Prerequisites:
--------------

  I currently run this on a Linux server to monitor a Gmod server running on windows. In the future, I will work to make this all run locally on the Gmod server regardless of OS.
  
  Currently, a Linux server is needed to monitor the Gmod server running on windows.

  * Linux Server to run monitoring with lynx and optionally a program of your choice to send email. I'm using ssmtp
  * Website with PHP. This can run on the monitoring server or on the server running gmod. This will be used to query the status of the server.
  * SSH installed on the Gmod server running windows. This can be downloaded.
  * Windows Gmod server needs to have Powershell installed.
  

Repo Layout
--------------

  * Linux monitoring server scripts folder.
  * Windows Gmod server scripts folder.

