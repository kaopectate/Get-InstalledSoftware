Function Get-InstalledSoftware{
    <#
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
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string[]]$ComputerName
    )
    BEGIN{
    }
    PROCESS 
    {
        foreach($computer in $ComputerName){
    
            try {
        
            $software = Get-WmiObject -Class Win32_Product -ComputerName $ComputerName -ErrorAction Stop
        
            } catch {
            
                Write-Host "$computer Offline"
            }
        
            $os = Get-WMIObject -Class win32_operatingsystem -ComputerName $ComputerName
            $osname = ($os.Name).Split("|") | Select-Object -First 1     
            
                foreach($installed in $software){
    
                    $props = [ordered] @{
                        'ComputerName' = $os.PSComputerName;
                        'OperatingSystem' = $osname;
                        'Archtecture' = $os.OSArchitecture;
                        'Name' = $installed.Name;
		                'Version' = $installed.Version;
		                'Vendor' = $installed.Vendor;
		                'IdentifyingNumber' = $installed.IdentifyingNumber}          
                
                    $obj = New-Object -TypeName psobject -Property $props
                    Write-Output $obj
                            
                }

            }
        }
    END{
    }
}