function StartGmod
{
$app = Start-Process C:\srcds\orangebox\srcds.exe -ArgumentList "-console -condebug -game garrysmod  +map gm_construct.bsp -maxplayers 20 -autoupdate -port 27016 -secure -verify_all -passthru -WindowStyle Maximized
$result = Get-Process -id $app.id
$result.ProcessorAffinity = 2
$result.PriorityClass = "High"
# This saves the pid of the gmod server to a text file and publishes it on the IIS server setup.
echo $app.id | out-file -encoding ASCII C:\inetpub\wwwroot\gmod_pid.txt
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


