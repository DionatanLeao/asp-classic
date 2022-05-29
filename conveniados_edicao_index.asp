<!DOCTYPE html>
    <%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html>
  <head>
    <title>Controle de Processos</title>
    <meta charset="utf-8">
  </head>
  <body>
    <%
        codConvenio = Request.QueryString("cod_conveniado1")

        StrConveniado = "SELECT * FROM Conveniados WHERE Codigo = " & codConvenio
        Set rsSQL = conexao.Execute(StrConveniado)
    %>
    
    <p style="text-align:center">Conveniados [<small>Edição</small>]</p>

    <div style="text-align: left; position: absolute; left: 50%; top: 10%; margin-left: -110px; margin-top: -40px;"><br/>
        <form action="conveniados_edicao_update.asp" method="post">
            <p>
                <label for="nome">Código:</label><br/>
                <input type="text" required="required" name="codigo" id="codigo" size="6" disabled="yes" 
                    value="<% = rsSQL.Fields("Codigo")%>"/>
                <input type="hidden" required="required" name="codigo1" id="codigo1" size="6">
            </p>
            <p>
                <label for="nome">Nome Completo:</label><br/>
                <input type="text" required="required" name="nome" id="nome" placeholder="Nome completo" 
                    size="40" style="text-transform: uppercase;" autofocus value="<% = rsSQL.Fields("Nome_Conveniado")%>"/>
            </p>
            <p>
                <label for="cpf">CPF:</label><br>
                <input type="text" name="cpf" id="cpf" placeholder="Apenas números" 
                    minlength="11" maxlength="11" pattern="\d{11}" value="<% = rsSQL.Fields("CPF_Conveniado")%>"/>
            </p>
            <p>
                <label for="nome">Número do Convênio:</label><br>
                <input type="text" name="convenio" id="convenio" required="required" 
                   autocomplete="on" maxlength="10" placeholder="Número do convênio" pattern="[0-9]+$" 
                    value="<% = rsSQL.Fields("Convenio")%>"/>
            </p>
            <p>
                <label for="usuario">Usuário:</label><br>
                <input type="text" name="usuario" id="usuario" placeholder="Nome do usuário" style="text-transform: lowercase;" 
                    required="required" value="<% = rsSQL.Fields("Usuario")%>"/>
            </p>
            <p>
                <label for="senha">Senha:</label><br>
                <input type="password" name="senha" id="senha" maxlength="10" required="required" value="<% = rsSQL.Fields("Senha")%>"/>
            </p>
            <p>
                <label for="senha2">Confirme a Senha:</label><br>
                <input type="password" name="senha2" id="senha2" maxlength="10" required="required" value="<% = rsSQL.Fields("Senha")%>"/>
            </p>

            <input type="submit" name="submit" value="Editar"/>
            <input type="reset" name="reset" value="Limpar"/>
        </form>
        <a href="default.asp">Menu</a>
    </div>
      
  </body>
</html>