Attribute VB_Name = "stdChart"
' stdChart - Excel embedded chart helpers

Option Explicit

Public Function CreateBarChart(ByVal ws As Worksheet, ByVal dataRange As String, _
                                ByVal title As String) As Chart
    Dim co As ChartObject
    Set co = ws.ChartObjects.Add(Left:=200, Top:=30, Width:=350, Height:=220)
    With co.Chart
        .SetSourceData ws.Range(dataRange)
        .ChartType = xlBarClustered
        .HasTitle = True
        .ChartTitle.Text = title
    End With
    Set CreateBarChart = co.Chart
End Function

Public Sub UpdateChartSeries(ByVal chart As Chart, ByVal newRange As String)
    chart.SetSourceData chart.Parent.Parent.Range(newRange)
End Sub

Public Sub ExportChartAsPng(ByVal chart As Chart, ByVal path As String)
    chart.Export Filename:=path, FilterName:="PNG"
End Sub
