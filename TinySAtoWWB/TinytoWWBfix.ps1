<#load inpot file#>
$csv = Import-Csv -path "C:\YOURINPUTFILELOCATION.csv" -Delimiter ";" -header freq, level 

<#modify data#>
foreach ($Item in $csv)
{
$Item.freq = [math]::Round($Item.freq/1000000,3) 
$Item.level = [math]::Round($Item.level,0)
}
<#export file#>
$Csv | Export-Csv -Path "C:\YOUROUTPUTFILELOCATION.csv" -Delimiter ‘,’ -NoType -UseQuotes 'AsNeeded'