<!DOCTYPE html>
  <%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
  <!-- #Include file="conexao.inc" -->
<html>
  <head>
    <title>Controle de Processos</title>
    <meta charset="utf-8">
  </head>
  <body>
    <%
        codigo = Request.QueryString("cod_conveniado1")

        Response.Write "codigo: " & codigo & "<br>"

        Set Conveniados = Server.CreateObject("ADOBD.RecordSet")

        inst_sql = "SELECT * FROM Conveniados WHERE Codigo = " & codigo

        Conveniados.Open inst_sql, conexao, 3, 3

        Conveniados.Delete
    %>

    <a href="default.asp">Menu</a>
    <a href="conveniados_inclusao_index.asp">Cadastrar novo Conveniado/Usuário</a>
    
  </body>
</html>