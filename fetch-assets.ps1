# Fetch AI-generated assets for Headlines Barber Shop from Canva CDN
# Run this on Windows before Stage 2 git-commits the build folder.
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $false

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$heroUrl = @"
https://export-download.canva.com/aMvl8/DAHKjmaMvl8/-1/0/0001-6329187565820949508.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUH5AO7UJ26%2F20260524%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260524T060243Z&X-Amz-Expires=7181&X-Amz-Signature=3548800ef450b967b0428033d68f0e3a0c456523d35ae2bde5279d6402d132a6&X-Amz-SignedHeaders=host%3Bx-amz-expected-bucket-owner&response-expires=Sun%2C%2024%20May%202026%2008%3A02%3A24%20GMT
"@
Write-Host "Downloading hero.jpg..."
try {
    Invoke-WebRequest -Uri $heroUrl -OutFile "$here\hero.jpg" -UseBasicParsing
    if (Test-Path "$here\hero.jpg") {
        $sz = (Get-Item "$here\hero.jpg").Length
        Write-Host "OK - hero.jpg downloaded ($sz bytes)"
    } else {
        Write-Host "WARN - hero.jpg missing after download"
    }
} catch {
    Write-Host "ERROR - hero fetch failed: $_"
    Write-Host "NOTE - the Canva presigned URL may have expired (~24h lifetime). Site will fall back to gradient background until logo swap at \$250 close."
}
