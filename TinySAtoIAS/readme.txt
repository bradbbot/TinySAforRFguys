TinySAtoIAS Convertor
By Brad Baisley with contribution from Jason Glass

--

This is a Windows Powershell script which converts CSV generated by TinySA-App into a CSV format that can import into both Shure Wireless Workbench and Professional Wireless Systems IAS frequency coordination software.


Instructions:
-Open TinytoIASfix.ps1 in a text editor like Notepad, Notepad++ or Powershell ISE
-Edit the input file path to the CSV generated by TinySA-APP one spot at the top of the script C:\PATHTOYOUR\INPUTFILENAME.csv
-Edit the output file path to wherever you would like the new file be deposited.  4 places at the bottom of the script C:\PATHTOYOUR\OUTPUTFILENAME.csv 
-Save TinytoIASfix.ps1 

-Open tinytowwb.bat in a text editor
-change the path to whereyour TinytoIASfix.ps1 is located C:\PATHTOYOUR\TinytoIASfix.ps1
-Save

-Double click tinytoIAS.bat and the file you have pointed it to should be processed and outputted to the file location and name you specified.

-Alternatively you can just right click on your updated TinytoIASfix.ps1 and select Run with PowerShell.