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
    #   Begin section for declaring sections of the form
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
        $labelIP = New-Object System.Windows.Forms.Label
        $textIP = New-Object System.Windows.Forms.TextBox
        $buttonIPUpdate = New-Object System.Windows.Forms.Button
        $labelPings = New-Object System.Windows.Forms.Label
        $textPings = New-Object System.Windows.Forms.TextBox
        $buttonPingUpdate = New-Object System.Windows.Forms.Button
        $labelIPRegistry = New-Object System.Windows.Forms.Label
        $textIPRegistry = New-Object System.Windows.Forms.TextBox
        $buttonIPUpdateRegistry = New-Object System.Windows.Forms.Button
        $labelSetupBreak = New-Object System.Windows.Forms.Label
        $labelExecBreak = New-Object System.Windows.Forms.Label
        $labelRegSetup = New-Object System.Windows.Forms.Label
        $labelRegExec = New-Object System.Windows.Forms.Label
        $labelUserTarget = New-Object System.Windows.Forms.Label
        $textUserTarget = New-Object System.Windows.Forms.TextBox
        $buttonUserTarget = New-Object System.Windows.Forms.Button
        $labelRootHive = New-Object System.Windows.Forms.Label
        $textRootHive = New-Object System.Windows.Forms.TextBox
        $buttonRootHive = New-Object System.Windows.Forms.Button
        $buttonOkay = New-Object System.Windows.Forms.Button
        $buttonCancel = New-Object System.Windows.Forms.Button

        # Button size standardization
        $buttonSize = New-Object System.Drawing.Size(120,25)

        # Setting up fonts for specific pieces
        $mainFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $buttonFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Regular)
        $labelFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Italic -bor [System.Drawing.FontStyle]::Bold))
        $textFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Italic)
        $resultFont = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Bold)
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

        $selectedTab = $tabControl.SelectedTab

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
            $logLocation = $textLogBeacon.Text

            if (!(Test-Path $logLocation))
            {
                New-Item -Path $selectedFolder.Self.Path -ItemType File -Name beaconlog.txt
            }
        }
    )

    # IP Address Label
    $labelIP.Text = "What is the Desitnation IP?"
    $labelIP.Location = New-Object System.Drawing.Size(340,103)
    $labelIP.AutoSize = $True
    $labelIP.Font = $labelFont
    $scriptBeacon.Controls.Add($labelIP)

    # IP Address for Beacon Script
    $textIP.text = "000.000.000.000"
    $textIP.Location = New-Object System.Drawing.Point(560,100)
    $textIP.Size = New-Object System.Drawing.Size(150,40)
    $textIP.Font = $textFont
    $textIP.Add_KeyDown({

        if($_.KeyCode -eq "Enter")
        {

            $buttonIPUpdate

        }

    })
    $scriptBeacon.Controls.Add($textIP)

    # IP Address update Button
    $buttonIPUpdate.location = New-Object System.Drawing.Size(730,103)
    $buttonIPUpdate.Size = $buttonSize
    $buttonIPUpdate.Text = "Set"
    $buttonIPUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonIPUpdate)
    $buttonIPUpdate.Add_Click(
        {
            $ipaddress = $textIP.Text
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

    # How many times it attempts to "reach out"
    $labelPings.Text = "How many pings?"
    $labelPings.Location = New-Object System.Drawing.Size(405,150)
    $labelPings.AutoSize = $True
    $labelPings.Font = $labelFont
    $scriptBeacon.Controls.Add($labelPings)

    # Get input from User
    $textPings.Text = "100"
    $textPings.Location = New-Object System.Drawing.Point(560,150)
    $textPings.Size = New-Object System.Drawing.Size(75,40)
    $textPings.Font = $textFont
    $scriptBeacon.Controls.Add($textPings)

    # Ping Number update Button
    $buttonPingUpdate.location = New-Object System.Drawing.Size(730,153)
    $buttonPingUpdate.Size = $buttonSize
    $buttonPingUpdate.Text = "Set"
    $buttonPingUpdate.Font = $buttonFont
    $scriptBeacon.Controls.Add($buttonPingUpdate)
    $buttonPingUpdate.Add_Click(
        {
            $pings = $textPings.Text
            [System.Windows.Forms.MessageBox]::Show("Max tries is set!","Confirmed","OK")
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
            $logLocation = $textLogReg.Text

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
            $ipaddress = $textIPRegistry.Text
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
    $labelRegSetup.Text = "Setup"
    $labelRegSetup.Location = New-Object System.Drawing.Point(570,155)
    $labelRegSetup.AutoSize = $True
    $labelRegSetup.Font = New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Regular)
    $scriptRegistry.Controls.Add($labelRegSetup)

    # Target User label
    $labelUserTarget.Text = "Who is the 'Bad Guy'?"
    $labelUserTarget.Location = New-Object System.Drawing.Point(280,203)
    $labelUserTarget.AutoSize = $True
    $labelUserTarget.Font = $labelFont
    $scriptRegistry.Controls.Add($labelUserTarget)

    # Target User textbox
    $textUserTarget.Text = "example: bad.guy.adm"
    $textUserTarget.Location = New-Object System.Drawing.Point(460,200)
    $textUserTarget.Size = New-Object System.Drawing.Size(250,40)
    $textUserTarget.Font = $textFont
    $scriptRegistry.Controls.Add($textUserTarget)

    # Target User button
    $buttonUserTarget.Text = "Set"
    $buttonUserTarget.Location = New-Object System.Drawing.Point(730,203)
    $buttonUserTarget.Size = $buttonSize
    $buttonUserTarget.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonUserTarget)
    $buttonUserTarget.Add_Click(
        {

            $userTarget = $textUserTarget.Text
            [System.Windows.Forms.MessageBox]::Show("$($userTarget) is the bad guy.","Confirmed","OK")
        }
    )

    # Edit Root Registry Hive Label
    $labelRootHive.Text = "Change the root registry hive?"
    $labelRootHive.Location = New-Object System.Drawing.Point(220,253)
    $labelRootHive.AutoSize = $True
    $labelRootHive.Font = $labelFont
    $scriptRegistry.Controls.Add($labelRootHive)

    # Edit Root Registry Hive textbox
    $textRootHive.Text = "example: McAfeee"
    $textRootHive.Location = New-Object System.Drawing.Point(460,250)
    $textRootHive.Size = New-Object System.Drawing.Size(250,40)
    $textRootHive.Font = $textFont
    $scriptRegistry.Controls.Add($textRootHive)

    # Edit Root Registry Hive button
    $buttonRootHive.Text = "Set"
    $buttonRootHive.Location = New-Object System.Drawing.Point(730,253)
    $buttonRootHive.Size = $buttonSize
    $buttonRootHive.Font = $buttonFont
    $scriptRegistry.Controls.Add($buttonRootHive)
    $buttonRootHive.Add_Click(
        {

            $rootHive = $textRootHive.Text
            [System.Windows.Forms.MessageBox]::Show("The Root Registry Hive is $($rootHive).","Confirmed","OK")
        }
    )

    # page break
    $labelExecBreak.Location = New-Object System.Drawing.Point(0,300)
    $labelExecBreak.Width = 1280
    $labelExecBreak.AutoSize = $false
    $labelExecBreak.Height = 2
    $labelExecBreak.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $scriptRegistry.Controls.Add($labelExecBreak)
    
    # Label for defining section for setup
    $labelRegExec.Text = "Execution"
    $labelRegExec.Location = New-Object System.Drawing.Point(555,305)
    $labelRegExec.AutoSize = $True
    $labelRegExec.Font = New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Regular)
    $scriptRegistry.Controls.Add($labelRegExec)

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

    # Okay Button
    $buttonOkay.location = New-Object System.Drawing.Size(480,690)
    $buttonOkay.Size = $buttonSize
    $buttonOkay.Text = "Okay"
    $buttonOkay.Font = $buttonFont
    $form.Controls.Add($buttonOkay)
    $buttonOkay.Add_Click(
        {

            If ($selectedTab.TabIndex -eq 1)
            { 
                Get-Date -Format F | Out-File -FilePath $logLocation -Append
                "###########################################################################################" | Out-File -FilePath $logLocation -Append
                ;"";""| Out-File -FilePath $logLocation -Append
                "'Bad' IP is: $($ipaddress)" | Out-File -FilePath $logLocation -Append
                ;""| Out-File -FilePath $logLocation -Append
                "Script will attempt to ping $($pings) times." | Out-File -FilePath $logLocation -Append
                ;"";""| Out-File -FilePath $logLocation -Append
                Run-Beacon
                

            }
            elseif ($selectedTab.TabIndex -eq 2)
            {

                Get-Date -Format F | Out-File -FilePath $logLocation -Append
                "###########################################################################################" | Out-File -FilePath $logLocation -Append
                ;"";""| Out-File -FilePath $logLocation -Append
                
                Set-Registry -add -hive $rootHive

            }

        }
    )

    # Cancel Button
    $buttonCancel.location = New-Object System.Drawing.Size(680,690)
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
    $form.Focus() | Out-Null
}

New-Form