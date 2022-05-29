<!DOCTYPE html>
  <%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
  <!-- #Include file="conexao.inc" -->
<html>
  <head>
    <title>Controle de Processos</title>
    <meta charset="utf-8">
  </head>
  <body>
      <div>
        <%
            StrConveniado = "SELECT * FROM Conveniados"
            Set rsListaConveniados = conexao.Execute(StrConveniado)
        %>

        <table align="center" border="1" width="80%" cellspacing="0" cellpadding="0" 
            bgcolor="#D9FFEC" style="border-collapse: collapse; text-align: center;" id="table1">
            <tr bgcolor="#8DB4B4">
                <td>Código</td>
                <td>Nome Conveniado</td>
                <td>CPF</td>
                <td>Convênio</td>
                <td>Usuário</td>
            </tr>

        <%
            Do Until rsListaConveniados.EoF
        %>

        <tr>
            <td><a href="conveniados_edicao_index.asp?cod_conveniado1=<% = rsListaConveniados.Fields("Codigo") %>">
                <% = rsListaConveniados.Fields("Codigo") %></a></td>
            <td><% = rsListaConveniados.Fields("CPF_Conveniado") %></td>
            <td><% = rsListaConveniados.Fields("Convenio") %></td>
            <td><% = rsListaConveniados.Fields("Usuario") %></td>
        </tr>

        <%
            rsListaConveniados.MoveNext
            Loop
            
            conexao.Close
            Set add_action = Nothing
            Set conexao = Nothing
        %>
        </table>
      </div>

      <a href="default.asp">Menu</a>
  </body>
</html>