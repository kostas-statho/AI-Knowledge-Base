Imports ClosedXML.Excel

Namespace Excel
    Public Class ExcelFileHelper
        Public Function OpenWorkbook(path As String) As XLWorkbook
            Return New XLWorkbook(path)
        End Function

        Public Function CreateWorkbook() As XLWorkbook
            Return New XLWorkbook()
        End Function

        Public Function ReadRange(wb As XLWorkbook, sheetName As String, address As String) As String(,)
            Dim ws = wb.Worksheet(sheetName)
            Dim rng = ws.Range(address)
            Dim result(rng.RowCount - 1, rng.ColumnCount - 1) As String
            For r = 1 To rng.RowCount
                For c = 1 To rng.ColumnCount
                    result(r - 1, c - 1) = rng.Cell(r, c).GetString()
                Next
            Next
            Return result
        End Function

        Public Sub WriteRange(wb As XLWorkbook, sheetName As String, address As String, data As String(,))
            Dim ws = wb.Worksheet(sheetName)
            Dim startCell = ws.Cell(address)
            For r = 0 To data.GetLength(0) - 1
                For c = 0 To data.GetLength(1) - 1
                    ws.Cell(startCell.Address.RowNumber + r, startCell.Address.ColumnNumber + c).Value = data(r, c)
                Next
            Next
        End Sub

        Public Sub SaveAs(wb As XLWorkbook, path As String)
            wb.SaveAs(path)
        End Sub
    End Class
End Namespace
