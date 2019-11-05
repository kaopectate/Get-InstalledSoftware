
.SYNOPSIS
Gets a computers Name, Operating System,OS Architecture and all installed Software Name,Version and IdentifyingNumber.
Returns it all in a powershell object.
.EXAMPLE
Get-InstalledSoftware -computername localhost
.EXAMPLE
Get-InstalledSoftware -computername comp1,comp2,comp3
.EXAMPLE
Get-Content computers.txt | Get-InstalledSoftware | Export-Csv C:\SoftwareReport.csv
.PARAMETER computername
One or more computer names seperated by comma.


              Install
Import-Module .\Get-InstalledSoftware.psm1
