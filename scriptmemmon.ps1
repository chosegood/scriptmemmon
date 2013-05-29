param(
    [int]$script_number,
    [int]$process_identifier
)

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

$scriptExecutionStart = Get-Date -format yyyyMMdd_HHmmss
$outputDir = "C:\temp\script" + $script_number + "\" + $scriptExecutionStart
$outputFile = $outputDir + "\output.txt"
[int]$i = 0

write-output "Creating output directory: " $outputDir
md -Path $outputDir
write-output "Appended results to " + $outputFile

do {
    "Hit Enter to take snapshot " + ++$i + " [ctrl-c to quit]";
    [Console]::ReadLine()
    "Step " + $i >> $outputFile
    GetProcessInfoById $process_identifier >> $outputFile
} while (1 -eq 1)
