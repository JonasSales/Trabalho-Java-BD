<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar Funcionario</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <%
            Usuario a = (Usuario) session.getAttribute("usuario");
            String vendedor = "vendedor";
            String funcionario = "funcionario";
            
            if( a == null || !a.getTipodeUsuario().equals(funcionario) || !a.getTipodeUsuario().equals(vendedor)) {
                out.println("<script>");
                out.println("redirecionar('http://localhost:8080/apresentacao.html');"); // Usa a função de redirecionamento
                out.println("</script>");
            }
            else {
        %>
                <form action="http://localhost:8080/AtualizarFuncionarioServlet" method="post">
                <h2>Atualizar Funcionario</h2>
                <label>Id funcionario:</label>");
                <input type="text" id="id" name="id" required>
                <label>Nome:</label>
                <input type="text" id="nome" name="nome" required> 
                <label>CPF: </label>"
                <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
                <label>Email:</label>
                <input type="email" id="email" name="email" required>
                <label>Data de Nascimento:</label>
                <input type="date" id="datadenascimento" name="datadenascimento" required>

                <label>Salario: </label>");
                <input type="number" id="salario" name="salario" required>;

                <label>Cargo:</label>");
                <input type="text" id="cargo" name="cargo" required>
                <label>Senha:</label>
                <input type="password" id ="senha" name="senha" required>
                <input type="submit" value="Cadastrar">
                </form> 
                <%}%>

    </body>
</html>
