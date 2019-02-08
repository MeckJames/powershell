Add-Type -assembly System.Windows.Forms

#title for the winform
$Title = "Current Status"
#winform dimensions
$height=100
$width=400
#winform background color
$color = "White"

#create the form
$form1 = New-Object System.Windows.Forms.Form
$form1.Text = $title
$form1.Height = $height
$form1.Width = $width
$form1.BackColor = $color

$form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
#display center screen
$form1.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# create label
$label1 = New-Object system.Windows.Forms.Label
$label1.Text = "not started"
$label1.Left=10
$label1.Top= 10
$label1.Width= $width - 20
#adjusted height to accommodate progress bar
$label1.Height=15
$label1.Font= "Verdana"
#optional to show border
#$label1.BorderStyle=1

#add the label to the form
$form1.controls.add($label1)

$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$progressBar1.Name = 'progressBar1'
$progressBar1.Value = 0
$progressBar1.Style="Continuous"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = $width - 40
$System_Drawing_Size.Height = 20
$progressBar1.Size = $System_Drawing_Size
$progressBar1.Left = 10
$progressBar1.Top = 40
$form1.Controls.Add($progressBar1)

$form1.Show() | Out-Null
$form1.Focus() | Out-Null

$label1.Text = "Starting..."
$form1.Refresh()

Start-Sleep -Seconds 3

$count = 0

while ($count -lt $pings) {
    $count++
    [int]$pct = ($count/$pings)*100

    $progressBar1.Value = $pct
    $label1.Text = "Attempt $($count)"
    $form1.Refresh()

    "Current attmept is: $($count)" | Out-File -FilePath $logLocation -Append
    ping $ipaddress | Out-File -FilePath $logLocation -Append

}

$form1.Close()