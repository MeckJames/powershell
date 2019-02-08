<#
Function Set-Registry
{

    $registryPath = 'HKLM:\SOFTWARE\McAfeee\APT\Inject\'
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

function Remove-Registry 
{

    $registryPath = "HKLM:\SOFTWARE\McAfeee\APT\Inject\"

    foreach($line in Get-Content key.txt) 
    {
	
	    $fullPath = Join-Path -Path $registryPath -ChildPath $line
	
	    remove-item $fullPath
	
	    Remove-ItemProperty -Path $registryPath -Name *
	    Remove-ItemProperty -Path $reg1 -Name *
	    Remove-ItemProperty -Path $reg2 -Name *
	    Remove-ItemProperty -Path $reg3 -Name *
        Remove-ItemProperty -Path $reg4 -Name *
    }

}

#>


[System.Windows.Forms.MessageBox]::Show("The if statement worked","Debug")