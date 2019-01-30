Function Create-Form
{

#[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# Form Setup
$form = New-Object System.Windows.Forms.Form
$tabControl = New-Object System.Windows.Forms.TabControl
$loggingSelect = New-Object System.Windows.Forms.TabPage
$logLabel = New-Object System.Windows.Forms.Label
$buttonBrowse = New-Object System.Windows.Forms.Button
$scriptSelect = New-Object System.Windows.Forms.TabPage
$textLabelBeacon = New-Object System.Windows.Forms.Label
$setupBeacon = New-Object System.Windows.Forms.Button
$buttonOkay = New-Object System.Windows.Forms.Button
$buttonCancel = New-Object System.Windows.Forms.Button


# Button size standardization
$buttonSize = New-Object System.Drawing.Size(120,25)

# Setting up fonts for specific pieces
$mainFont = New-Object System.Drawing.Font("Consolas",10,[System.Drawing.FontStyle]::Regular)
$buttonFont = New-Object System.Drawing.Font("Consolas",10,[System.Drawing.FontStyle]::Regular)
$textFont = New-Object System.Drawing.Font("Consolas",10,[System.Drawing.FontStyle]::Italic)
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

# Logging Selection
$loggingSelect.UseVisualStyleBackColor = $True
$loggingSelect.Name = "loggingSelect"
$loggingSelect.Text = "Log Selection"
$tabControl.Controls.Add($loggingSelect)


# Log Location Text
$logLabel.text = "Log Location"
$logLabel.Location = New-Object System.Drawing.Point(15,50)
$logLabel.AutoSize = $true
$logLabel.TabIndex = 0
$loggingSelect.Controls.Add($logLabel)

# Browse Button
$buttonBrowse.location = New-Object System.Drawing.Size(700,50)
$buttonBrowse.Size = $buttonSize
$buttonBrowse.Text = "Browse"
$buttonBrowse.Font = $buttonFont
$buttonBrowse.TabIndex = 0
$loggingSelect.Controls.Add($buttonBrowse)
$buttonBrowse.Add_Click(
    {
        $browser = New-Object System.Windows.Forms.FolderBrowserDialog
        $browser.ShowDialog()
        
        $textFileLocation = New-Object System.Windows.Forms.TextBox
        $textFileLocation.text = $browser.SelectedPath
        $textFileLocation.Location = New-Object System.Drawing.Point(200, 55)
        $textFileLocation.Size = New-Object System.Drawing.Size(300,40)
        $textFileLocation.ReadOnly = $true
        $textFileLocation.Font = $textFont
        $loggingSelect.Controls.Add($textFileLocation)
    }
)

# Script Selection
$scriptSelect.UseVisualStyleBackColor = $True
$scriptSelect.Name = "scriptSelect"
$scriptSelect.Text = "Script Selection"
$tabControl.Controls.Add($scriptSelect)

# Text for Beacon Script
$textLabelBeacon.text = "Beacon Script"
$textLabelBeacon.Location = New-Object System.Drawing.Point(100,53)
$textLabelBeacon.AutoSize = $true
$textLabelBeacon.Font = $textFont
$textLabelBeacon.TabIndex = 1
$scriptSelect.Controls.Add($textLabelBeacon)

# Setup Script 1 Button
$setupBeacon.Location = New-Object System.Drawing.Size(250,50)
$setupBeacon.Size = $buttonSize
$setupBeacon.text = "Setup"
$setupBeacon.Font = $buttonFont
$setupBeacon.TabIndex = 1
$scriptSelect.Controls.Add($setupBeacon)
$setupBeacon.Add_Click(
    {
        #Run setup of Becaon script
        Set-Beacon
    }
)

# Okay Button
$buttonOkay.location = New-Object System.Drawing.Size(300,690)
$buttonOkay.Size = $buttonSize
$buttonOkay.Text = "Okay"
$buttonOkay.Font = $buttonFont
$form.Controls.Add($buttonOkay)
$buttonOkay.Add_Click(
    {
        $form.Close()
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

Function Set-Beacon
{
$beaconOptions = New-Object System.Windows.Forms.Form
$beaconOptions.StartPosition = "CenterScreen"
$beaconOptions.Name = "beaconOptions"
$beaconOptions.Text = "Beacon Options"





$beaconOptions.ShowDialog() | Out-Null
}
Create-Form