function StartGmod
{
$app = Start-Process C:\srcds\orangebox\srcds.exe -ArgumentList "-console -condebug -game garrysmod  +map gm_construct.bsp -maxplayers 20 -autoupdate -port 27016 -secure -verify_all -passthru -WindowStyle Maximized
$result = Get-Process -id $app.id

# This sets what processor to run the process on
$result.ProcessorAffinity = 2

# This sets the class of the process
$result.PriorityClass = "High"

# This saves the pid of the gmod server to a text file and publishes it on the IIS server setup.
echo $app.id | out-file -encoding ASCII C:\inetpub\wwwroot\gmod_pid.txt

# This waits for the process to finish. In this case, waits for the Gmod server to crash.
Wait-Process $app.id

# Call the update script here. This is an optional section that can call an update script whenever the server crashes
# This allows you to keep non-workshop addons up to date easily.
clear
Invoke-Expression "./gmod_13_git_pull.ps1"
cd C:\srcds\orangebox\garrysmod

# Re-call the start function
StartGmod
}

# First Run call
StartGmod


