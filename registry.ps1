Function Set-Registry
{
    Param(
        [switch]$add,
        [string]$hive
    )
    
    if ($add)
    {
        [System.Windows.Forms.MessageBox]::Show("Add used","Debug")
        $registryPath = "HKLM:\SOFTWARE\$($hive)\APT\Inject\"
        $value = "1"


        foreach($line in Get-Content key.txt) {

	        #$fullPath = join-path -path $registryPath -childpath $line
	        #$fullPath | Out-File -FilePath $logLocation -Append

	        if(!(Test-Path $registryPath)) {
		        New-Item -Path $registryPath -Force | Out-Null
		        New-ItemProperty -Path $registryPath -Name $line -Value $value -PropertyType DWORD -Force | Out-Null
	        } else {
	
		        New-ItemProperty -Path $registryPath -Name $line -Value $value -PropertyType DWORD -Force | Out-Null
	
	        }

        }
        
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("No Add","Debug")
        $registryPath = "HKLM:\SOFTWARE\McAfeee\APT\Inject\"

        foreach($line in Get-Content key.txt) 
        {
	
	        $fullPath = Join-Path -Path $registryPath -ChildPath $line
	
	        remove-item $fullPath
	
	        Remove-ItemProperty -Path $registryPath -Name *

        }
        
    }
}