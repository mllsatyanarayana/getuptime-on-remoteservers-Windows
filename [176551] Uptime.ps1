################################################
#Example1                                      #
# get-uptime -computername localhost           #
#Example2                                      #     
#  get-uptime $server                          # 
#use foreach loop for querying multiple servers#                                        
################################################




function get-uptime {
 param(
 $computername
 )

 $os = Get-WmiObject win32_operatingsystem -ComputerName $computername -ea silentlycontinue
 if($os){
 $lastbootuptime =$os.ConvertTodateTime($os.LastBootUpTime)

 $LocalDateTime =$os.ConvertTodateTime($os.LocalDateTime)

 $up =$LocalDateTime - $lastbootuptime

 $uptime ="$($up.Days) days, $($up.Hours)h, $($up.Minutes)mins"

 $results =new-object psobject

 $results |Add-Member noteproperty LastBootUptime $LastBootuptime
 $results |Add-Member noteproperty ComputerName $computername
 $results |Add-Member noteproperty uptime $uptime


 #Display the results

 $results | Select-Object computername,LastBootuptime,Uptime

 }


 else

 {

 $results =New-Object psobject

 $results =new-object psobject
 $results |Add-Member noteproperty LastBootUptime "Na"
 $results |Add-Member noteproperty ComputerName $computername
 $results |Add-Member noteproperty uptime "Na"

 #display the results

 $results | Select-Object computername,LastBootUptime,Uptime




 }



 }

 $infouptime =@()
 

 # Save the servers in Text file and save it in any location
 $servers =Get-Content  -Path "C:\servers.txt"

 foreach($server in $servers){

 $infouptime += get-uptime $server
 }

 $infouptime  |ft -AutoSize




 