Function Set-Registry
{
    Param(
        [switch]$add,
        [string]$hive,
        [string]$targetIP,
        [string]$logLocation
    )
    
    $registryPath = "HKLM:\SOFTWARE\$($hive)\APT\Inject\"
    #$AccessRule = New-Object System.Security.AccessControl.RegistryAccessRule("Administrator","FullControl","Deny")

    if ($add)
    {

        foreach($line in Get-Content key.txt) {

	
    	    $fullPath | Out-File -FilePath $logLocation -Append

	        if(!(Test-Path $registryPath)) {
		        New-Item -Path $registryPath -Force | Out-Null
	        }
    
            $fullPath = join-path -path $registryPath -childpath $line

            New-Item -Path $fullPath -Force | Out-Null

            #$acl = Get-Acl $fullPath
            #$acl.SetAccessRule($AccessRule)
            #Set-Acl $fullPath $acl
            

        }
        
    }
    else
    {

        foreach($line in Get-Content key.txt) 
        {
	
	        $fullPath = Join-Path -Path $registryPath -ChildPath $line
	
	        remove-item $fullPath
            
            Start-Sleep -Seconds 3

        }
        
        Remove-Item $registryPath
        Remove-Item "HKLM:\SOFTWARE\$($hive)\APT\"
        Remove-Item "HKLM:\SOFTWARE\$($hive)\"
        
    }
}