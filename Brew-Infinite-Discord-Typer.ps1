Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing 
[System.Windows.Forms.Application]::EnableVisualStyles();

# thank you chatgpt for the awesome ui

Write-Host "Initializing"


$webClient = New-Object System.Net.WebClient
$imageUrl = "https://brew.rocks/stuff/brew_infinitetyping.png"
$imagePath = "$env:TEMP\dfakadfskjdfaskj.png"
$webClient.DownloadFile($imageUrl, $imagePath)

$form = New-Object Windows.Forms.Form
$form.Text = "Brew's Infinite Typer v1.0"
$form.Size = New-Object Drawing.Size(500, 400)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.MinimizeBox = $false
$form.MaximizeBox = $false

function go {
    $textBox1.Enabled = $false
    $textBox2.Enabled = $false
    $button.Enabled = $false
    $label.Text = "Running... To stop, close PowerShell."
    $channel = $textBox1.Text
    $auth = $textBox2.Text
    $censoredauth = $auth.SubString(0,7) + "#"* ($auth.length - 7)
    Write-Host "Sending typing requests in Channel ID" $channel "and with Auth Token" $censoredauth
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    while (1 -eq 1){
    Try
    {
    $outcome = Invoke-WebRequest -Uri https://discord.com/api/v9/channels/$channel/typing -Method POST -Headers @{'Authorization' = $auth; 'Content-Length' = '0'} -UseBasicParsing
    $outcome
    }
    Catch
    {
    [System.Windows.Forms.MessageBox]::Show("An error occured while sending the POST to Discord. Check the console for more details.",'Error!','OK','Error')
    Write-Host $Error[0] -ForegroundColor Red
    Write-Host "---------------------------------------------------" -ForegroundColor Red
    Write-Host "Error details are above. Please restart the script." -ForegroundColor Red
    break
    }
    Write-Host "Sent POST"
    Start-Sleep -Seconds 8
    }
}


$label = New-Object Windows.Forms.Label
$label.Text = "This will make a POST to Discord every 8 seconds. Not responsible if your Discord acct gets banned, it most likely won't anyway, but still."
$label.Location = New-Object Drawing.Point(20, 10)
$label.Size = New-Object Drawing.Size(460, 40)
$form.Controls.Add($label)


$pictureBox = New-Object Windows.Forms.PictureBox
$pictureBox.Location = New-Object Drawing.Point(20, 40)
$pictureBox.Size = New-Object Drawing.Size(460, 200)
$pictureBox.ImageLocation = $imagePath
$form.Controls.Add($pictureBox)

$textBox1 = New-Object Windows.Forms.TextBox
$textBox1.Location = New-Object Drawing.Point(20, 250)
$textBox1.Size = New-Object Drawing.Size(440, 20)
$textBox1.Name = "TextBox1"
$textBox1.Text = 'Channel ID'
$form.Controls.Add($textBox1)

$textBox2 = New-Object Windows.Forms.TextBox
$textBox2.Location = New-Object Drawing.Point(20, 280)
$textBox2.Size = New-Object Drawing.Size(440, 20)
$textBox2.Name = "TextBox2"
$textBox2.Text = 'Authorization Token'
$form.Controls.Add($textBox2)

$button = New-Object Windows.Forms.Button
$button.Location = New-Object Drawing.Point(200, 320)
$button.Size = New-Object Drawing.Size(100, 30)
$button.Text = "Start Typing"
$button.Add_Click({ go })
$form.Controls.Add($button)
Write-Host "Initialized"
$form.ShowDialog()

Remove-Item $imagePath
