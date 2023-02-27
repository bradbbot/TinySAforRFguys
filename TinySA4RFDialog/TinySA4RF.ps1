Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "TinySA to IAS and WWB Converter"
$form.ClientSize = New-Object System.Drawing.Size(400,200)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# Create label for file selection
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(300,20)
$label.Text = "Select a TinySA CSV file to convert:"
$form.Controls.Add($label)

# Create textbox for file path
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(300,20)
$form.Controls.Add($textBox)

# Create button for browsing files
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(320,40)
$button.Size = New-Object System.Drawing.Size(70,20)
$button.Text = "Browse"
$button.Add_Click({
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "CSV files (*.csv)|*.csv"
    $dialog.InitialDirectory = [Environment]::GetFolderPath('Desktop')
    $dialog.Title = "Select a TinySA CSV file"
    if ($dialog.ShowDialog() -eq 'OK') {
        $textBox.Text = $dialog.FileName
    }
})
$form.Controls.Add($button)

# Create button for converting file
$convertButton = New-Object System.Windows.Forms.Button
$convertButton.Location = New-Object System.Drawing.Point(150,80)
$convertButton.Size = New-Object System.Drawing.Size(100,30)
$convertButton.Text = "Convert"
$convertButton.Add_Click({
    # Load input file
    $csv = Import-Csv -Path $textBox.Text -Delimiter ";" -Header freq, level 

    # Modify data
    foreach ($Item in $csv)
    {
        $Item.freq = [math]::Round($Item.freq/1000000,3)
        $Item.level = [math]::Round([decimal]::Parse($Item.level) * 0.8686)
    }

    # Generate output file name
    $date = Get-Date -Format "MMddyyyy-HHmm"
    $outputFileName = [System.IO.Path]::ChangeExtension($textBox.Text, '') + "-WWBIAS-" + $date + ".csv"

    # Export file without quotes and headers
    $csv | ConvertTo-Csv -Delimiter ',' -NoTypeInformation | Select-Object -Skip 1 | ForEach-Object { $_ -replace '"', '' } | Out-File $outputFileName

    [System.Windows.Forms.MessageBox]::Show("Conversion completed!")
})
$form.Controls.Add($convertButton)

# Show form
$form.Topmost = $true
[void] $form.ShowDialog()
