# Debugging reference!
#[System.Windows.Forms.MessageBox]::Show("Exists")

. .\beacon.ps1
. .\registry.ps1

Function New-Form
{

    #[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
    #[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    ##########################################################################################
    #
    #   Section for declaring sections of the form
    #
    ##########################################################################################


        # Form Setup
        $form = New-Object System.Windows.Forms.Form
        $tabControl = New-Object System.Windows.Forms.TabControl
        $welcomePage = New-Object System.Windows.Forms.TabPage
        $labelInformation0 = New-Object System.Windows.Forms.Label
        $labelInformation1 = New-Object System.Windows.Forms.Label
        $labelInformation2 = New-Object System.Windows.Forms.Label
        $scriptRegistry = New-Object System.Windows.Forms.TabPage
        $scriptBeacon = New-Object System.Windows.Forms.TabPage
        $scriptCleanup = New-Object System.Windows.Forms.TabPage
        $labelSourceIP = New-Object System.Windows.Forms.Label
        $textSourceIP = New-Object System.Windows.Forms.TextBox
        $buttonSourceIPUpdate = New-Object System.Windows.Forms.Button
        $labelDestinationIP = New-Object System.Windows.Forms.Label
        $textDestinationIP = New-Object System.Windows.Forms.TextBox
        $buttonIPDestinationUpdate = New-Object System.Windows.Forms.Button
        $labelPings = New-Object System.Windows.Forms.Label
        $textPings = New-Object System.Windows.Forms.TextBox
        $buttonPingUpdate = New-Object System.Windows.Forms.Button
        $labelBeaconBreak = New-Object System.Windows.Forms.Label
        $buttonRunBeacon = New-Object System.Windows.Forms.Button
        $labelIPRegistry = New-Object System.Windows.Forms.Label
        $textIPRegistry = New-Object System.Windows.Forms.TextBox
        $buttonIPUpdateRegistry = New-Object System.Windows.Forms.Button
        $labelSetupBreak = New-Object System.Windows.Forms.Label
        $labelExecBreak = New-Object System.Windows.Forms.Label
        $labelRegSetup = New-Object System.Windows.Forms.Label
        $labelRegReboot = New-Object System.Windows.Forms.Label
        $labelRebootBreak = New-Object System.Windows.Forms.Label
        $labelRegExec = New-Object System.Windows.Forms.Label
        $labelUserTarget = New-Object System.Windows.Forms.Label
        $textUserTarget = New-Object System.Windows.Forms.TextBox
        $buttonUserTarget = New-Object System.Windows.Forms.Button
        $labelRootHive = New-Object System.Windows.Forms.Label
        $textRootHive = New-Object System.Windows.Forms.TextBox
        $buttonRootHive = New-Object System.Windows.Forms.Button
        $buttonRunReg = New-Object System.Windows.Forms.Button
        $buttonSetupReg = New-Object System.Windows.Forms.Button
        $labelReboot = New-Object System.Windows.Forms.Label
        $buttonRebootReg = New-Object System.Windows.Forms.Button
        $buttonOkay = New-Object System.Windows.Forms.Button
        $buttonCancel = New-Object System.Windows.Forms.Button

        # Button size standardization
        $buttonSize = New-Object System.Drawing.Size(120,25)

        # Setting up fonts for specific pieces
        $mainFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $buttonFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $labelFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Italic -bor [System.Drawing.FontStyle]::Bold))
        $textFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Italic)
        $sectionFont = New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Regular)
        # Font styles are Regular, Bold, Italic, Underling, Strikeout

        # Main Form
        $form.Text = "Exercise Script"
        $form.Name = "form"
        $system_drawing_size = New-Object System.Drawing.Size
        $system_drawing_size.Width = 1280
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


    ##########################################################################################
    #
    #   Begin section for Setting up the Tabs
    #
    ##########################################################################################
        
    # Tab Control
    $tabControl.Location = New-Object System.Drawing.Point(0,0)
    $tabControl.Name = "tabControl"
    $tabControl.Size = New-Object System.Drawing.Size(1280,680)
    $tabControl.ForeColor = "Black"
    $tabControl.Add_SelectedIndexChanged({

        $script:selectedTab = $tabControl.SelectedTab

    })

    $form.Controls.Add($tabControl)


    ##########################################################################################
    #
    #   Begin section for Welcome Tab
    #
    ##########################################################################################


    # Blank "Welome Tab"
    $welcomePage.UseVisualStyleBackColor = $True
    $welcomePage.Name = "welcomePage"
    $welcomePage.Text = "Welcome"
    $tabControl.Controls.Add($welcomePage)

    <#
    $labelInformation0.Location = New-Object System.Drawing.Size(50,50)
    $labelInformation0.Name = "labelInformation"
    $labelInformation0.Text = "Labor of love. This was built in order to have a central place to setup, configure, and run scripts as necessary for exercises."
    $labelInformation0.Height = 150
    $labelInformation0.Width = 700
    $welcomePage.Controls.Add($labelInformation0)

    $labelInformation1.Location = New-Object System.Drawing.Size(50,210)
    $labelInformation1.Name = "labelInformation"
    $labelInformation1.Text = "Select the tab above to set up the script you'd like to run. Ensure that all of your settings are correct and run the script."
    $labelInformation1.Height = 150
    $labelInformation1.Width = 700
    $welcomePage.Controls.Add($labelInformation1)

    $labelInformation2.Location = New-Object System.Drawing.Size(50,370)
    $labelInformation2.Name = "labelInformation"
    $labelInformation2.Text = "Created by: SSgt Machaby -- Last updated: 03 Feb 2019"
    $labelInformation2.Height = 120
    $labelInformation2.Width = 700
    $welcomePage.Controls.Add($labelInformation2)
    #>

    ##########################################################################################
    #
    #   Begin section for Beacon Script Tab
    #
    ##########################################################################################

    # Beacon Script
    $scriptBeacon.UseVisualStyleBackColor = $True
    $scriptBeacon.Name = "scriptBeacon"
    $scriptBeacon.Text = "Beacon Script"
    $tabControl.Controls.Add($scriptBeacon)

    # Log Location label
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(200,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $labelFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($logLabel)

    $textLogBeacon = New-Object System.Windows.Forms.TextBox
    $textLogBeacon.Location = New-Object System.Drawing.Point(320,45)
    $textLogBeacon.Size = New-Object System.Drawing.Size(550,40)
    $textLogBeacon.ReadOnly = $true
    $textLogBeacon.Font = $textFont
    $scriptBeacon.Controls.Add($textLogBeacon)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Point(890,47)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptBeacon.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = new-object -com SHell.Application
            $selectedFolder = $browser.BrowseForFolder(0, "Select Folder", 0, "$ENV:USERPROFILE")
            
            $textLogBeacon.text = "$($selectedFolder.Self.Path)\beaconlog.txt"
            $script:logLocation = $textLogBeacon.Text

            if (!(Test-Path $logLocation))
            {
                New-Item -Path $selectedFolder.Self.Path -ItemType File -Name beaconlog.txt
            }
        }
    )

    # Source IP Address Label
    $labelSourceIP.Text = "What is the Source IP?"
    $labelSourceIP.Location = New-Object System.Drawing.Size(340,103)
    $labelSourceIP.AutoSize = $True
    $labelSourceIP.Font = $labelFont
    $scriptBeacon.Controls.Add($labelSourceIP)

    # Source IP Address for Beacon Script
    $textSourceIP.text = "000.000.000.000"
    $textSourceIP.Location = New-Object System.Drawing.Point(560,100)
    $textSourceIP.Size = New-Object System.Drawing.Size(150,40)
    $textSourceIP.Font = $textFont
    $textSourceIP.Add_KeyDown({

        if($_.KeyCode -eq "Enter")
        {

            $buttonIPUpdate

        }

    })
    $scriptBeacon.Controls.Add($textSourceIP)

    # Source IP Address update Button
    $buttonSourceIPUpdate.location = New-Object System.Drawing.Size(730,103)
    $buttonSourceIPUpdate.Size = $buttonSize
    $buttonSourceIPUpdate.Text = "Set"
    $buttonSourceIPUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonSourceIPUpdate)
    $buttonSourceIPUpdate.Add_Click(
        {
            $script:sourceIPaddress = $textSourceIP.Text
            $messageboxConfirm0 = [System.Windows.Forms.MessageBox]::Show("IP is now $($sourceIPaddress). Is this right?","IP Address","YesNo")
            switch ($messageboxConfirm0)
            {
                'Yes'
                {
                    # Keep IP Address
                    
                }

                'No'
                {
                    # Close message box and allow re-enter of IP Address
                    [System.Windows.Forms.MessageBox]::Show("Double check your IP Address")
                }
            }
        }
    )

    # Destination IP Address Label
    $labelDestinationIP.Text = "What is the Desitnation IP?"
    $labelDestinationIP.Location = New-Object System.Drawing.Size(340,153)
    $labelDestinationIP.AutoSize = $True
    $labelDestinationIP.Font = $labelFont
    $scriptBeacon.Controls.Add($labelDestinationIP)

    # IP Address for Beacon Script
    $textDestinationIP.text = "000.000.000.000"
    $textDestinationIP.Location = New-Object System.Drawing.Point(560,150)
    $textDestinationIP.Size = New-Object System.Drawing.Size(150,40)
    $textDestinationIP.Font = $textFont
    $textDestinationIP.Add_KeyDown({

        if($_.KeyCode -eq "Enter")
        {

            $buttonIPUpdate

        }

    })
    $scriptBeacon.Controls.Add($textDestinationIP)

    # Destination IP Address update Button
    $buttonIPDestinationUpdate.location = New-Object System.Drawing.Size(730,153)
    $buttonIPDestinationUpdate.Size = $buttonSize
    $buttonIPDestinationUpdate.Text = "Set"
    $buttonIPDestinationUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonIPDestinationUpdate)
    $buttonIPDestinationUpdate.Add_Click(
        {
            $script:destinationIPaddress = $textDestinationIP.Text
            $messageboxConfirm0 = [System.Windows.Forms.MessageBox]::Show("IP is now $($destinationIPaddress). Is this right?","IP Address","YesNo")
            switch ($messageboxConfirm0)
            {
                'Yes'
                {
                    # Keep IP Address
                    
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
    $labelPings.Location = New-Object System.Drawing.Size(405,200)
    $labelPings.AutoSize = $True
    $labelPings.Font = $labelFont
    $scriptBeacon.Controls.Add($labelPings)

    # Get input from User
    $textPings.Text = "100"
    $textPings.Location = New-Object System.Drawing.Point(560,200)
    $textPings.Size = New-Object System.Drawing.Size(75,40)
    $textPings.Font = $textFont
    $scriptBeacon.Controls.Add($textPings)

    # Ping Number update Button
    $buttonPingUpdate.location = New-Object System.Drawing.Size(730,203)
    $buttonPingUpdate.Size = $buttonSize
    $buttonPingUpdate.Text = "Set"
    $buttonPingUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPingUpdate)
    $buttonPingUpdate.Add_Click(
        {
            $script:pings = $textPings.Text
            [System.Windows.Forms.MessageBox]::Show("Max tries is set!","Confirmed","OK")
        }
    )

    # page break
    $labelBeaconBreak.Location = New-Object System.Drawing.Point(0,250)
    $labelBeaconBreak.Width = 1280
    $labelBeaconBreak.AutoSize = $false
    $labelBeaconBreak.Height = 2
    $labelBeaconBreak.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $scriptBeacon.Controls.Add($labelBeaconBreak)

    # Check for commented out rule or not.
    $textCheckRule = New-Object System.Windows.Forms.TextBox
    $textCheckRule.Text = " "
    $textCheckRule.TextAlign = "center"
    $textCheckRule.ReadOnly = $true
    $textCheckRule.Location = New-Object System.Drawing.Point(580,300)
    $textCheckRule.Size = New-Object System.Drawing.Size(180,40)
    $textCheckRule.Font = $textFont
    $scriptBeacon.Controls.Add($textCheckRule)


    # Button for SNORT Rule Check
    $buttonPOSHCheck = New-Object System.Windows.Forms.Button
    $buttonPOSHCheck.Location = New-Object System.Drawing.Point(420,302)
    $buttonPOSHCheck.Size = New-Object System.Drawing.Size(150,25)
    $buttonPOSHCheck.Text = "Check SNORT Rules"
    $buttonPOSHCheck.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPOSHCheck)
    $buttonPOSHCheck.Add_Click(
        {
            $rule = Run-PoshSSH check

            if($rule.StartsWith("#") -eq $true)
            {

                $textCheckRule.text = "Exercise rule is commented out."

            }
            else
            {

                $textCheckRule.text = "Exercise rule is active."

            }


        }
    )

    # Check for commented out rule or not.
    $textUpdatedRule = New-Object System.Windows.Forms.TextBox
    $textUpdatedRule.Text = " "
    $textUpdatedRule.TextAlign = "center"
    $textUpdatedRule.ReadOnly = $true
    $textUpdatedRule.Location = New-Object System.Drawing.Point(580,400)
    $textUpdatedRule.Size = New-Object System.Drawing.Size(180,40)
    $textUpdatedRule.Font = $textFont
    $scriptBeacon.Controls.Add($textUpdatedRule)

    # Button for SNORT Rule disable
    $buttonPOSHEnable = New-Object System.Windows.Forms.Button
    $buttonPOSHEnable.Location = New-Object System.Drawing.Point(470,350)
    $buttonPOSHEnable.Size = New-Object System.Drawing.Size(170,25)
    $buttonPOSHEnable.Text = "Enable SNORT Rules"
    $buttonPOSHEnable.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPOSHEnable)
    $buttonPOSHEnable.Add_Click(
        {
            #$rule = Run-PoshSSH uncomment

            $textUpdatedRule.text = "Rule has been enabled."

        }
    )

    # Button for SNORT Rule disable
    $buttonPOSHDisable = New-Object System.Windows.Forms.Button
    $buttonPOSHDisable.Location = New-Object System.Drawing.Point(655,350)
    $buttonPOSHDisable.Size = New-Object System.Drawing.Size(170,25)
    $buttonPOSHDisable.Text = "Disable SNORT Rules"
    $buttonPOSHDisable.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPOSHDisable)
    $buttonPOSHDisable.Add_Click(
        {
            #$rule = Run-PoshSSH comment

            $textUpdatedRule.text = "Rule has been disabled."

        }
    )


    # Run script
    $buttonRunBeacon.Location = New-Object System.Drawing.Point(580,600)
    $buttonRunBeacon.Size = $buttonSize
    $buttonRunBeacon.Text = "Run"
    $buttonRunBeacon.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonRunBeacon)
    $buttonRunBeacon.Add_Click(
        {

            Get-Date -Format F | Out-File -FilePath $logLocation -Append
            "###########################################################################################" | Out-File -FilePath $logLocation -Append
            ;"#";"#"| Out-File -FilePath $logLocation -Append
            "#                                        INFORMATION" | Out-File -FilePath $logLocation -Append
            "#" | Out-File -FilePath $logLocation -Append
            "#    Source IP is: $($sourceIPaddress)" | Out-File -FilePath $logLocation -Append
            ;"#"| Out-File -FilePath $logLocation -Append
            "#    'Bad' IP is: $($destinationIPaddress)" | Out-File -FilePath $logLocation -Append
            ;"#"| Out-File -FilePath $logLocation -Append
            "#    Script will attempt to ping $($pings) times." | Out-File -FilePath $logLocation -Append
            ;"#";"#"| Out-File -FilePath $logLocation -Append
            "###########################################################################################" | Out-File -FilePath $logLocation -Append

            Run-Beacon -source $sourceIPaddress -destination $destinationIPaddress -ping $pings -loglocation $logLocation

        }
    )
    ##########################################################################################
    #
    #   Begin section for Registry Script Tab
    #
    ##########################################################################################

    # Registry Script
    $scriptRegistry.UseVisualStyleBackColor = $True
    $scriptRegistry.Name = "scriptRegistry"
    $scriptRegistry.Text = "Registry Script"
    $tabControl.Controls.Add($scriptRegistry)

    # Log Location label
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.text = "Log Location"
    $logLabel.Location = New-Object System.Drawing.Point(200,50)
    $logLabel.AutoSize = $true
    $logLabel.Font = $labelFont
    #$logLabel.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($logLabel)

    $textLogReg = New-Object System.Windows.Forms.TextBox
    $textLogReg.Location = New-Object System.Drawing.Point(320,45)
    $textLogReg.Size = New-Object System.Drawing.Size(550,40)
    $textLogReg.ReadOnly = $true
    $textLogReg.Font = $textFont
    $scriptRegistry.Controls.Add($textLogReg)

    # Browse Button
    $buttonBrowse = New-Object System.Windows.Forms.Button
    $buttonBrowse.location = New-Object System.Drawing.Point(890,47)
    $buttonBrowse.Size = $buttonSize
    $buttonBrowse.Text = "Browse"
    $buttonBrowse.Font = $buttonFont
    #$buttonBrowse.TabIndex = $selectedTab.TabIndex
    $scriptRegistry.Controls.Add($buttonBrowse)
    $buttonBrowse.Add_Click(
        {
            $browser = new-object -com SHell.Application
            $selectedFolder = $browser.BrowseForFolder(0, "Select Folder", 0, "$env:USERPROFILE")
           
            
            $textLogReg.text = "$($selectedFolder.Self.Path)\registrylog.txt"
            $script:logLocation = $textLogReg.Text

            if (!(Test-Path $logLocation))
            {
                New-Item -Path $selectedFolder.Self.Path -ItemType File  -Name registrylog.txt
            }
        }
    )

    # Target IP Label
    $labelIPRegistry.Text = "What is the IP of the target device?"
    $labelIPRegistry.Location = New-Object System.Drawing.Size(280,103)
    $labelIPRegistry.AutoSize = $True
    $labelIPRegistry.Font = $labelFont
    $scriptRegistry.Controls.Add($labelIPRegistry)

    # Target IP for Registry Script
    $textIPRegistry.text = "000.000.000.000"
    $textIPRegistry.Location = New-Object System.Drawing.Point(560,100)
    $textIPRegistry.Size = New-Object System.Drawing.Size(150,40)
    $textIPRegistry.Font = $textFont
    $scriptRegistry.Controls.Add($textIPRegistry)

    # Target IP update Button
    $buttonIPUpdateRegistry.location = New-Object System.Drawing.Size(730,103)
    $buttonIPUpdateRegistry.Size = $buttonSize
    $buttonIPUpdateRegistry.Text = "Set"
    $buttonIPUpdateRegistry.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonIPUpdateRegistry)
    $buttonIPUpdateRegistry.Add_Click(
        {
            $script:ipaddress = $textIPRegistry.Text
            $messageboxConfirm0 = [System.Windows.Forms.MessageBox]::Show("IP is now $($ipaddress). Is this right?","IP Address","YesNo")
            switch ($messageboxConfirm0)
            {
                'Yes'
                {
                    # Keep IP Address
                    
                }

                'No'
                {
                    # Close message box and allow re-enter of IP Address
                    [System.Windows.Forms.MessageBox]::Show("Double check your IP Address")
                }
            }
        }
    )

    # page break
    $labelSetupBreak.Location = New-Object System.Drawing.Point(0,150)
    $labelSetupBreak.Width = 1280
    $labelSetupBreak.AutoSize = $false
    $labelSetupBreak.Height = 2
    $labelSetupBreak.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $scriptRegistry.Controls.Add($labelSetupBreak)

    # Label for defining section for setup
    $labelRegSetup.Text = "Step 1: Setup"
    $labelRegSetup.Location = New-Object System.Drawing.Point(560,155)
    $labelRegSetup.AutoSize = $true
    $labelRegSetup.Font = $sectionFont
    $scriptRegistry.Controls.Add($labelRegSetup)

    # Edit Root Registry Hive Label
    $labelRootHive.Text = "Change the root registry hive?"
    $labelRootHive.Location = New-Object System.Drawing.Point(220,203)
    $labelRootHive.AutoSize = $True
    $labelRootHive.Font = $labelFont
    $scriptRegistry.Controls.Add($labelRootHive)

    # Edit Root Registry Hive textbox
    $textRootHive.Text = "example: McAfeee"
    $textRootHive.Location = New-Object System.Drawing.Point(460,200)
    $textRootHive.Size = New-Object System.Drawing.Size(250,40)
    $textRootHive.Font = $textFont
    $scriptRegistry.Controls.Add($textRootHive)

    # Edit Root Registry Hive button
    $buttonRootHive.Text = "Set"
    $buttonRootHive.Location = New-Object System.Drawing.Point(730,203)
    $buttonRootHive.Size = $buttonSize
    $buttonRootHive.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonRootHive)
    $buttonRootHive.Add_Click(
        {

            $script:rootHive = $textRootHive.Text
            [System.Windows.Forms.MessageBox]::Show("The Root Registry Hive is $($rootHive).","Confirmed","OK")
        }
    )

    # Setup Button
    $buttonSetupReg.Location = New-Object System.Drawing.Point(580,240)
    $buttonSetupReg.Size = $buttonSize
    $buttonSetupReg.Text = "Setup"
    $buttonSetupReg.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonSetupReg)
    $buttonSetupReg.Add_Click(
        {

                Get-Date -Format F | Out-File -FilePath $logLocation -Append
                "###########################################################################################" | Out-File -FilePath $logLocation -Append
                ;"#";"#"| Out-File -FilePath $logLocation -Append
                "#                                        INFORMATION" | Out-File -FilePath $logLocation -Append
                ;"#" | Out-File -FilePath $logLocation -Append
                ;"#" | Out-File -FilePath $logLocation -Append
                ;"#";"#"| Out-File -FilePath $logLocation -Append
                "###########################################################################################" | Out-File -FilePath $logLocation -Append
    
                Set-Registry -add -hive $rootHive

        }
    )
    
    # page break
    $labelRebootBreak.Location = New-Object System.Drawing.Point(0,275)
    $labelRebootBreak.Width = 1280
    $labelRebootBreak.AutoSize = $false
    $labelRebootBreak.Height = 2
    $labelRebootBreak.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $scriptRegistry.Controls.Add($labelRebootBreak)

    # Label for defining section for setup
    $labelRegReboot.Text = "Step 2: Reboot"
    $labelRegReboot.Location = New-Object System.Drawing.Point(550,280)
    $labelRegReboot.AutoSize = $true
    $labelRegReboot.Font = $sectionFont
    $scriptRegistry.Controls.Add($labelRegReboot)
    
    # Reboot information label
    $labelReboot.Location = New-Object System.Drawing.Point(225,335)
    $labelReboot.AutoSize = $True
    $labelReboot.Text = "After you have setup the script, you will need to reboot the machine. Use the button below to reboot the device."
    $labelReboot.Font = $labelFont
    $scriptRegistry.Controls.Add($labelReboot)
    
    # Reboot Button
    $buttonRebootReg.Location = New-Object System.Drawing.Point(580,370)
    $buttonRebootReg.Size = $buttonSize
    $buttonRebootReg.Text = "Reboot"
    $buttonRebootReg.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonRebootReg)
    $buttonRebootReg.Add_Click(
        {
            
            Start-Process -NoNewWindow cmd -Argument "/c wmic /node:$ipaddress os where Primary='TRUE' reboot"
            
            $Title = "Current Status"
            $height=100
            $width=400
            $color = "White"

            #create the form
            $form2 = New-Object System.Windows.Forms.Form
            $form2.Text = $title
            $form2.Height = $height
            $form2.Width = $width
            $form2.BackColor = $color
            $form2.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
            $form2.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
            
            
            $label1 = New-Object system.Windows.Forms.Label
            $label1.Text = "not started"
            $label1.Left=10
            $label1.Top= 10
            $label1.Width= $width - 20
            $label1.Height=15
            $label1.Font= "Verdana"
            $form2.controls.add($label1)
            
            $label2 = New-Object system.Windows.Forms.Label
            $label2.Text = "Destination unreachable"
            $label2.Left=10
            $label2.Top= 45
            $label2.Width= $width - 20
            $label2.Height=15
            $label2.Font= "Verdana"
            $form2.controls.add($label2)
            
            $form2.Show() | Out-Null
            $form2.Focus() | Out-Null

            $label1.Text = "Rebooting..."
            $form2.Refresh()

            Start-Sleep -Seconds 3
            
            $time = 0

            do
            {
                $test = Test-Connection -ComputerName $ipaddress -quiet
                if($test -eq $true)
                {
                    $label2.text = "$($ipaddress) is up."
                    $form2.Refresh()
                }
                elseif($test -eq $false)
                {
                    $label2.text = "$($ipaddress) is down."
                    $form2.Refresh()
                }
                $time++
                Write-Host $time
            }
            while ($time -lt 20)

            <#
            do
            {
                $test = Test-Connection -ComputerName $ipaddress -quiet
                $label2.text = "$($ipaddress) is down."
                $form2.Refresh()
            }
            while ($test -eq $false)
            
                    
            $label2.text = "$($ipaddress) is up!"
            $form2.Refresh()
            #>

            Start-Sleep -Seconds 2

            $form2.Close()
        }
    )

    # page break
    $labelExecBreak.Location = New-Object System.Drawing.Point(0,400)
    $labelExecBreak.Width = 1280
    $labelExecBreak.AutoSize = $false
    $labelExecBreak.Height = 2
    $labelExecBreak.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $scriptRegistry.Controls.Add($labelExecBreak)
    
    # Label for defining section for execution
    $labelRegExec.Text = "Step 3: Execution"
    $labelRegExec.Location = New-Object System.Drawing.Point(543,405)
    $labelRegExec.AutoSize = $true
    $labelRegExec.Font = $sectionFont
    $scriptRegistry.Controls.Add($labelRegExec)

    # Target User label
    $labelUserTarget.Text = "Who is the 'Bad Guy'?"
    $labelUserTarget.Location = New-Object System.Drawing.Point(280,453)
    $labelUserTarget.AutoSize = $True
    $labelUserTarget.Font = $labelFont
    $scriptRegistry.Controls.Add($labelUserTarget)

    # Target User textbox
    $textUserTarget.Text = "example: bad.guy.adm"
    $textUserTarget.Location = New-Object System.Drawing.Point(460,450)
    $textUserTarget.Size = New-Object System.Drawing.Size(250,40)
    $textUserTarget.Font = $textFont
    $scriptRegistry.Controls.Add($textUserTarget)

    # Target User button
    $buttonUserTarget.Text = "Set"
    $buttonUserTarget.Location = New-Object System.Drawing.Point(730,453)
    $buttonUserTarget.Size = $buttonSize
    $buttonUserTarget.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonUserTarget)
    $buttonUserTarget.Add_Click(
        {

            $script:userTarget = $textUserTarget.Text
            [System.Windows.Forms.MessageBox]::Show("$($userTarget) is the bad guy.","Confirmed","OK")
        }
    )

    # Edit Root Registry Hive Label
    $labelRootHive.Text = "What is the root registry hive?"
    $labelRootHive.Location = New-Object System.Drawing.Point(220,503)
    $labelRootHive.AutoSize = $True
    $labelRootHive.Font = $labelFont
    $scriptRegistry.Controls.Add($labelRootHive)

    # Edit Root Registry Hive textbox
    $textRootHive.Text = "example: McAfeee"
    $textRootHive.Location = New-Object System.Drawing.Point(460,500)
    $textRootHive.Size = New-Object System.Drawing.Size(250,40)
    $textRootHive.Font = $textFont
    $scriptRegistry.Controls.Add($textRootHive)

    # Edit Root Registry Hive button
    $buttonRootHive.Text = "Set"
    $buttonRootHive.Location = New-Object System.Drawing.Point(730,503)
    $buttonRootHive.Size = $buttonSize
    $buttonRootHive.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonRootHive)
    $buttonRootHive.Add_Click(
        {

            $script:rootHive = $textRootHive.Text
            [System.Windows.Forms.MessageBox]::Show("The Root Registry Hive is $($rootHive).","Confirmed","OK")
        }
    )
    
    # Run script
    $buttonRunReg.Location = New-Object System.Drawing.Point(580,600)
    $buttonRunReg.Size = $buttonSize
    $buttonRunReg.Text = "Run"
    $buttonRunReg.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonRunReg)
    $buttonRunReg.Add_Click(
        {
            Get-Date -Format F | Out-File -FilePath $logLocation -Append
            "###########################################################################################" | Out-File -FilePath $logLocation -Append
            ;"";""| Out-File -FilePath $logLocation -Append
                
            Set-Registry -hive $rootHive

        }
    )

    ##########################################################################################
    #
    #   Begin section for Cleanup Tab
    #
    ##########################################################################################

    # Cleanup Script
    $scriptCleanup.UseVisualStyleBackColor = $True
    $scriptCleanup.Name = "scriptCleanup"
    $scriptCleanup.Text = "Cleanup Script"
    $tabControl.Controls.Add($scriptCleanup)

    ##########################################################################################
    #
    #   Begin section for running or canceling the scripts
    #
    ##########################################################################################

    # Cancel Button
    $buttonCancel.location = New-Object System.Drawing.Size(585,690)
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

Function Run-PoshSSH
{
    [cmdletbinding()]

    Param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('comment','uncomment','check')]
        [string]$Item
    )

    $BASEPATH = "C:\Users\erik.machaby.adm.AFSCN.000\Desktop\dev\opfor\"
    $POSHSSH = $BASEPATH + "posh-ssh\Posh-SSH.psd1"
    $UNAME = $Env:USERDOMAIN + '\' + $Env:USERNAME

    Import-Module $POSHSSH

    $sensorIP  = "172.20.32.111"

    $CREDS = Get-Credential -Credential $UNAME -ErrorAction Stop

    Switch($Item)
    {
        'check' {

            $sessionID = New-SSHSession -ComputerName $sensorIP -Credential $CREDS -AcceptKey
            $result = Invoke-SSHCommand -SSHSession $sessionID -Command "~/machaby/ruleCheck.sh"
            $status = $result.Output
            Remove-SSHSession -SSHSession $sessionID | out-null
            return $status

        }
        'comment' {

            $sessionID = New-SSHSession -ComputerName $sensorIP -Credential $CREDS -AcceptKey
            $result = Invoke-SSHCommand -SSHSession $sessionID -Command "~/machaby/ruleComment.sh"
            $status = $result.Output
            Remove-SSHSession -SSHSession $sessionID | out-null
            return $status

        }
        'uncomment'{

            $sessionID = New-SSHSession -ComputerName $sensorIP -Credential $CREDS -AcceptKey
            $result = Invoke-SSHCommand -SSHSession $sessionID -Command "~/machaby/ruleUncomment.sh"
            $status = $result.Output
            Remove-SSHSession -SSHSession $sessionID | out-null
            return $status

        }
    
    }
    
    

}

New-Form