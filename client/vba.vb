Public WithEvents App As Application



Private Sub App_SlideShowNextSlide(ByVal Wn As SlideShowWindow)
    Dim command As String
    Dim query As String
    Dim slide_id As Integer
    Dim page_num As Integer

    slide_id = 4
    page_num = Wn.View.CurrentShowPosition - 1 ' 0 based index
    
    query = "http://localhost:3000/api/v1/page_change -XPOST -d 'token=aabbcc&slide_id=" & slide_id & "&page_num=" & page_num & "'"
    command = "do shell script ""curl " + query + """  "
    
    getUrlContents = VBA.MacScript(command)
End Sub
