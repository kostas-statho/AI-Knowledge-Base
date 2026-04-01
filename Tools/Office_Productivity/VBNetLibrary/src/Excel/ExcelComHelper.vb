Imports Microsoft.Office.Interop.Excel
Imports OfficeProductivity.Common

Namespace Excel
    Public Class ExcelComHelper
        Implements IDisposable

        Private _app As Application
        Private _disposed As Boolean

        Public Sub New(Optional visible As Boolean = False)
            _app = ThreadingHelper.RunOnSta(Of Application)(Function()
                Dim a As New Application()
                a.Visible = visible
                Return a
            End Function)
        End Sub

        Public Function OpenWorkbook(path As String) As Workbook
            Return ThreadingHelper.RunOnSta(Of Workbook)(Function() _app.Workbooks.Open(path))
        End Function

        Public Function CreateWorkbook() As Workbook
            Return ThreadingHelper.RunOnSta(Of Workbook)(Function() _app.Workbooks.Add())
        End Function

        Public Function ReadRange(wb As Workbook, sheetName As String, address As String) As Object(,)
            Return ThreadingHelper.RunOnSta(Of Object(,))(Function()
                Dim ws = CType(wb.Sheets(sheetName), Worksheet)
                Return CType(ws.Range(address).Value, Object(,))
            End Function)
        End Function

        Public Sub WriteRange(wb As Workbook, sheetName As String, address As String, data As Object(,))
            ThreadingHelper.RunOnSta(Sub()
                Dim ws = CType(wb.Sheets(sheetName), Worksheet)
                Dim r = ws.Range(address)
                Dim rows = data.GetLength(0)
                Dim cols = data.GetLength(1)
                ws.Range(r.Cells(1, 1), r.Cells(rows, cols)).Value = data
            End Sub)
        End Sub

        Public Sub SaveAs(wb As Workbook, path As String)
            ThreadingHelper.RunOnSta(Sub() wb.SaveAs(path, XlFileFormat.xlOpenXMLWorkbook))
        End Sub

        Public Sub Close(wb As Workbook, Optional save As Boolean = False)
            ThreadingHelper.RunOnSta(Sub() wb.Close(save))
            ComReleaser.Release(wb)
        End Sub

        Public Sub Dispose() Implements IDisposable.Dispose
            If Not _disposed Then
                ThreadingHelper.RunOnSta(Sub()
                    _app.Quit()
                    ComReleaser.Release(_app)
                End Sub)
                _disposed = True
            End If
        End Sub
    End Class
End Namespace
