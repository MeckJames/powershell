Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Exercise Script"
$form.Width = 900
$form.Height = 720
$form.AutoSize = $true
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.text = "Test"
$label.Location = New-Object System.Drawing.Point(10,50)
$form.Controls.Add($label)


$button = New-Object System.Windows.Forms.Button
$button.location = New-Object System.Drawing.Size(300,50)
$button.Size = New-Object System.Drawing.Size(120,23)
$button.Text = "Browse"
$form.Controls.Add($button)
$button.Add_Click(
    {
        $openFile = New-Object System.Windows.Forms.OpenFileDialog
        $openFile.InitialDirectory = "C:\"
        $openFile.Filter = "txt files(*.txt)|*.txt|All Files (*.*)|*.*"
        $openFile.ShowDialog()
        $openFile.FileName
    }
)





$buttonOkay = New-Object System.Windows.Forms.Button
$buttonOkay.location = New-Object System.Drawing.Size(300,600)
$buttonOkay.Size = New-Object System.Drawing.Size(120,23)
$buttonOkay.Text = "Okay"
$form.Controls.Add($buttonOkay)
$buttonOkay.Add_Click(
    {
        $form.Close()
    }
)

$buttonCancel = New-Object System.Windows.Forms.Button
$buttonCancel.location = New-Object System.Drawing.Size(500,600)
$buttonCancel.Size = New-Object System.Drawing.Size(120,23)
$buttonCancel.Text = "Cancel"
$form.Controls.Add($buttonCancel)
$buttonCancel.Add_Click(
    {
        $form.Close()
    }
)


$form.ShowDialog()