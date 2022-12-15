<#load input file#>
$csv = Import-Csv -path "C:\PATHTOYOUR\INPUTFILENAME.csv" -Delimiter ";" -header freq, level 

<#modify data#>
foreach ($Item in $csv)
{
$Item.freq = [math]::Round($Item.freq/1000000,3) 
$Item.level = [math]::Round($Item.level,0)
}

<#export file#>
$Csv | Export-Csv -Path "C:\PATHTOYOUR\OUTPUTFILENAME.csv" -Delimiter ‘,’ -NoType 
<#remove quotation marks#>
(Get-Content "C:\PATHTOYOUR\OUTPUTFILENAME.csv") -replace '"' | select -Skip 1 | Set-Content "C:\PATHTOYOUR\OUTPUTFILENAME.csv"
Get-ChildItem "C:\PATHTOYOUR\OUTPUTFILENAME.csv" | ForEach-Object {          
Rename-Item $_.FullName "$BackupFolder$($_.BaseName -replace " ", "_" -replace '\..*?$')-$(Get-Date -Format "HHmmMMddyyyy").csv"}