<%
    Set conexao = Server.CreateObject("ADODB.Connection")
    conexao.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("bd_controle.accdb") & ";"
%>