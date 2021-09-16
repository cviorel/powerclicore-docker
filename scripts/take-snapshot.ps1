$VI_SERVER = (Get-ChildItem ENV:VI_SERVER).Value
$VI_USERNAME = (Get-ChildItem ENV:VI_USERNAME).Value
$VI_PASSWORD = (Get-ChildItem ENV:VI_PASSWORD).Value

if (Test-Path -Path '/tmp/vm_list') {
    $VI_VM = Get-Content -Path '/tmp/vm_list' | Where-Object { -not ([String]::IsNullOrEmpty($_.Trim()) -or $_ -match "^#") }
}

Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false | Out-Null
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Out-Null

Write-Output "VI_SERVER=$VI_SERVER"
Write-Output "VI_VM=$VI_VM"

Write-Output "`nConnecting to vCenter Server ..."
Connect-VIServer -Server $VI_SERVER -User $VI_USERNAME -Password $VI_PASSWORD | Out-Null

$time = (Get-Date -Format yyyMMddHHmmss)
Get-VM $VI_VM | New-Snapshot -Name "Snapshot: $time" -Description "N/A" -Quiesce | Out-Null

Write-Output `n"Disconnecting ...`n"
Disconnect-VIServer * -Confirm:$false
