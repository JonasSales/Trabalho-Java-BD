<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% String erro = (String)request.getAttribute("erro"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <form action="http://localhost:8080/LoginServlet" method="post">
            <h2>Login</h2>
            <label>Email:</label>
            <input type="email" id="email" name="email" maxlength="100"
                   required>
            <label>Senha:</label>
            <input type="password" id="senha" name="senha"
                   required>
            <input type="submit" value="Entrar no sistema">

        </form>
                    <%if (erro != null) {
             out.println("<h1>" + erro + "</h1>");

                }
            %>
    </body>
</html>
