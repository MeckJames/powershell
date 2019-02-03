. C:\Users\Mac\Documents\GitHub\powershell\beacon.ps1
. C:\Users\Mac\Documents\GitHub\powershell\registry.ps1

Function Create-Form
{

#[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# Form Setup
$form = New-Object System.Windows.Forms.Form
$tabControl = New-Object System.Windows.Forms.TabControl
$welcomePage = New-Object System.Windows.Forms.TabPage
$scriptRegistry = New-Object System.Windows.Forms.TabPage
$scriptBeacon = New-Object System.Windows.Forms.TabPage
$textIP = New-Object System.Windows.Forms.TextBox
$buttonIPUpdate = New-Object System.Windows.Forms.Button
$labelPings = New-Object System.Windows.Forms.Label
$textPings = New-Object System.Windows.Forms.TextBox
$buttonPingsUpdate = New-Object System.Windows.Forms.Button
$buttonOkay = New-Object System.Windows.Forms.Button
$buttonCancel = New-Object System.Windows.Forms.Button

# Button size standardization
$buttonSize = New-Object System.Drawing.Size(120,25)

# Setting up fonts for specific pieces
$mainFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
$buttonFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
$textFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Italic)
$resultFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Bold)
$dotFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
# Font styles are Regular, Bold, Italic, Underling, Strikeout

# Main Form
$form.Text = "Exercise Script"
$form.Name = "form"
$system_drawing_size = New-Object System.Drawing.Size
$system_drawing_size.Width = 900
$system_drawing_size.Height = 720
$form.ClientSize = $system_drawing_size
$form.WindowState = "Normal"
    # Maximized, Minimized, Normal
$form.StartPosition = "CenterScreen"
    # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
#$form.BackColor = "LightGray"
    # color names are static properties of System.Drawing.Color
    # you can also use ARGB values, such as "#FFFFEBCD"
$form.ForeColor = "Black"
$form.Font = $mainFont

# Tab Control
$tabControl.Location = New-Object System.Drawing.Point(0,0)
$tabControl.Name = "tabControl"
$tabControl.Size = New-Object System.Drawing.Size(900,650)
$tabControl.ForeColor = "Black"
$form.Controls.Add($tabControl)

# Blank "Welome Tab"
$welcomePage.UseVisualStyleBackColor = $True
$welcomePage.Name = "welcomePage"
$welcomePage.Text = "Welcome"
$tabControl.Controls.Add($welcomePage)

# Beacon Script
$scriptBeacon.UseVisualStyleBackColor = $True
$scriptBeacon.Name = "scriptBeacon"
$scriptBeacon.Text = "Beacon Script"
$tabControl.Controls.Add($scriptBeacon)

Log-DataBeacon


# IP Address for Beacon Script
$textIP.text = "000.000.000.000"
$textIP.Location = New-Object System.Drawing.Point(130,100)
$textIP.Size = New-Object System.Drawing.Size(150,40)
$textIP.Font = $textFont
$scriptBeacon.Controls.Add($textIP)

# IP Address update Button
$buttonIPUpdate.location = New-Object System.Drawing.Size(300,100)
$buttonIPUpdate.Size = $buttonSize
$buttonIPUpdate.Text = "Set"
$buttonIPUpdate.Font = $buttonFont
$scriptBeacon.Controls.Add($buttonIPUpdate)
$buttonIPUpdate.Add_Click(
    {
        $ipaddress = $textIP.Text
        $messageboxConfirm = [System.Windows.Forms.MessageBox]::Show("IP is now $($ipaddress). Is this right?","IP Address","YesNo")
        switch ($messageboxConfirm)
        {
            'Yes'
            {
                # Keep IP Address
                $ipaddress = $textIP.Text
                out-file -FilePath $logLocation -Append 
            }

            'No'
            {
                # Close message box and allow re-enter of IP Address
                [System.Windows.Forms.MessageBox]::Show("Double check your IP Address")
            }
        }
    }
)

# How many times it attempts to "reach out"
$labelPings.Text = "How many pings?"
$labelPings.Location = New-Object System.Drawing.Size(130,200)
$labelPings.AutoSize = $True
$labelPings.Font = $textFont
$scriptBeacon.Controls.Add($labelPings)



# Registry Script
$scriptRegistry.UseVisualStyleBackColor = $True
$scriptRegistry.Name = "scriptRegistry"
$scriptRegistry.Text = "Registry Script"
$tabControl.Controls.Add($scriptRegistry)

Log-DataRegistry




# Okay Button
$buttonOkay.location = New-Object System.Drawing.Size(300,690)
$buttonOkay.Size = $buttonSize
$buttonOkay.Text = "Okay"
$buttonOkay.Font = $buttonFont
$form.Controls.Add($buttonOkay)
$buttonOkay.Add_Click(
    {
        $scriptRegistry.Update()
    }
)

# Cancel Button
$buttonCancel.location = New-Object System.Drawing.Size(500,690)
$buttonCancel.Size = $buttonSize
$buttonCancel.Text = "Cancel"
$buttonCancel.Font = $buttonFont
$form.Controls.Add($buttonCancel)
$buttonCancel.Add_Click(
    {
        $form.Close()
    }
)

$form.ShowDialog() | Out-Null
}

Function Log-DataRegistry
{
    # Log Location Text
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(15,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $textFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($logLabel)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Size(700,50)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = New-Object System.Windows.Forms.FolderBrowserDialog
            $browser.ShowDialog()
                    
            $textFileLocation = New-Object System.Windows.Forms.TextBox
            $textFileLocation.text = "$($browser.SelectedPath)\registrylog.txt"
            $textFileLocation.Location = New-Object System.Drawing.Point(130, 50)
            $textFileLocation.Size = New-Object System.Drawing.Size(550,40)
            $textFileLocation.ReadOnly = $true
            $textFileLocation.Font = $resultFont
            $scriptRegistry.Controls.Add($textFileLocation)
        }
    )
}

Function Log-DataBeacon
{
    # Log Location Text
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(15,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $textFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($logLabel)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Size(700,50)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = New-Object System.Windows.Forms.FolderBrowserDialog
            $browser.ShowDialog()
                    
            $textFileLocation = New-Object System.Windows.Forms.TextBox
            $textFileLocation.text = "$($browser.SelectedPath)\beaconlog.txt"
            $textFileLocation.Location = New-Object System.Drawing.Point(130, 50)
            $textFileLocation.Size = New-Object System.Drawing.Size(550,40)
            $textFileLocation.ReadOnly = $true
            $textFileLocation.Font = $resultFont
            $scriptBeacon.Controls.Add($textFileLocation)
            $logLocation = $textFileLocation.Text
            
            [System.Windows.Forms.MessageBox]::Show("$($logLocation)")
        }
    )
}

Create-Form