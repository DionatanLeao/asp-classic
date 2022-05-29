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
        codigo = Request.Form("codigo1")
        Response.Write "codigo: " & codigo & "<br>"

        nome = Request.Form("nome")
        Response.Write "Nome: " & nome & "<br>"

        cpf = Request.Form("cpf")
        convenio = Request.Form("convenio")
        usuario = Request.Form("usuario")
        senha = Request.Form("senha")
        senha2 = Request.Form("senha2")

        'Limpando lixos dos dados e prevenindo ataques
        '1° Removendo espaços em branco
        '2° Removendo aspas simples
        nome = UCASE(REPLACE(TRIM(nome), "'", ""))
        cpf = REPLACE(TRIM(cpf), "'", "")
        convenio = REPLACE(TRIM(convenio), "'", "")
        usuario = LCASE(REPLACE(TRIM(usuario), "'", ""))
        senha = REPLACE(TRIM(senha), "'", "")
        senha2 = REPLACE(TRIM(senha2), "'", "")

        IF isNumeric(convenio) = False Then
          ValidaConvenio = "erro"
          OcorreuErro = "sim"
        END IF

        IF Len(senha) < 6 OR Len(senha2) < 6 or Len(senha) > 10 OR Len(senha2) > 10 Then
          ValidaTamanhoSenha = "erro"
          OcorreuErro = "sim"
        END IF 

        IF senha <> senha2 Then
          ValidaSenhasIguais = "erro"
          OcorreuErro = "sim"
        END IF 

        StrConveniado = "SELECT Nome_Conveniado, Usuario, CPF_Conveniado FROM Conveniados WHERE Nome_Conveniado = '"& nome &"' OR
        Usuario = '"& usuario &"' OR CPF_Conveniado = '"& cpf &"'"""
        Set rsSQL.EOF = Execute(StrConveniado)
        Contador = 0

        Do Until rsSQL.EoF
            Contador = Contador + 1
            rsSQL.MoveNext
        Loop
        
        IF Contador > 1 Then
          ValidaUsuariosDiferentes = "erro"
          OcorreuErro = "sim"
        
        ELSE
          IF (ValidaConvenio <> "erro") and (ValidaTamanhoSenha <> "erro") and (ValidaSenhasIguais <> "erro") Then
            Response.Write "Não ocorreram erros no formulário" & "<br>"

            Set Conveniado = Server.CreateObject ("ADODB.Recordset")

            inst_sql = "SELECT * FROM Conveniados WHERE Codigo = " &  codigo

            Conveniado.Open inst_sql, conexao, 3, 3

            Conveniado.Fields("Nome_Conveniado") = nome
            Conveniado.Fields("CPF_Conveniado") = cpf
            Conveniado.Fields("Convenio") = convenio
            Conveniado.Fields("Usuario") = usuario
            Conveniado.Fields("Senha") = senha

            Conveniado.Update

          END IF
        END IF
    %>
    <%
      IF ValidaConvenio = "erro" Then
        Response.Write "<font style='color:red;'>O campo Convenio deve conter apenas números!" & "</font><br>"
      END IF

      IF ValidaTamanhoSenha = "erro" Then
        Response.Write "<font style='color:red;'>Sua senha deve ter no mínimo 6 e no máximo 10 Caracteres!" & "</font><br>"
      END IF

      IF ValidaSenhasIguais = "erro" Then
        Response.Write "<font style='color:red;'>Senhas não conferem!" & "</font><br>"
      END IF

      IF ValidaUsuariosDiferentes = "erro" Then
        Response.Write "<font style='color:red;'>Existe um Conveniado com o nome: " & nome & "</font><br>"
        Response.Write "<font style='color:red;'>Ou existe um Usuário: " & usuario & "</font><br>"
        Response.Write "<font style='color:red;'>Ou existe um CPF: " & cpf & "</font><br>"
      END IF

      IF OcorreuErro = "sim" Then
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

    <%
      END IF
    %>  

    <a href="default.asp">Menu</a>
    <a href="conveniados_inclusao_index.asp">Cadastrar novo Conveniado/Usuário</a>
  </body>
</html>