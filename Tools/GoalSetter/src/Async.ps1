# ----------------------------------------------
# Async helper  -  runs a scriptblock in a runspace,
# calls $onDone scriptblock when finished
# ----------------------------------------------
function Invoke-Async($script, $params, [scriptblock]$onDone, [scriptblock]$onError) {
    $rs = [runspacefactory]::CreateRunspace()
    $rs.Open()
    $ps = [powershell]::Create()
    $ps.Runspace = $rs
    [void]$ps.AddScript($script)
    [void]$ps.AddParameters($params)
    $handle = $ps.BeginInvoke()

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 300
    $timer.Add_Tick({
        if ($handle.IsCompleted) {
            $timer.Stop()
            $timer.Dispose()
            try {
                $result   = $ps.EndInvoke($handle)
                $errorMsg = if ($ps.Streams.Error.Count -gt 0) { $ps.Streams.Error[0].ToString() } else { $null }
                $ps.Dispose(); $rs.Dispose()
                if ($errorMsg) {
                    & $onError $errorMsg
                } else {
                    & $onDone $result
                }
            } catch {
                $ps.Dispose(); $rs.Dispose()
                & $onError $_.Exception.Message
            }
        }
    }.GetNewClosure())
    $timer.Start()
}
