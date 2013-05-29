Param([int]$process_identifier)

function GetProcessInfoById {
    param
    ([int]$processId)

    Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | where{$_.idprocess -eq $processId} | select `
    @{Name="Process Id"; Expression = {$_.idprocess}},`
    @{Name="Counter Name"; Expression = {$_.name}},`
    @{Name="Commit"; Expression = {$_.pageFileBytes / 1kb}},`
    @{Name="Working Set"; Expression = {$_.workingSet / 1kb}},`
    @{Name="Private Working Set"; Expression = {$_.workingSetPrivate / 1kb}}
}

GetProcessInfoById $process_identifier