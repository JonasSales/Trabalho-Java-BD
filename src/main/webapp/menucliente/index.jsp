<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>P�gina Principal</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
    <%Usuario usuarioLogado = (Usuario) session.getAttribute("cliente");
        // Verifica se o usu�rio est� logado e se � cliente
        String tipoUsuario = "cliente";
        if (usuarioLogado == null || !usuarioLogado.getTipodeUsuario().equals(tipoUsuario)) {%>
    <div>
                Voc� n�o tem permiss�o para acessar esta p�gina. Por favor, entre como cliente.
            </div>
            <script>
                setTimeout(function() {
                    window.location.href = 'http://localhost:8080/home.jsp'; // Redireciona ap�s 1 segundos
                }, 1000);
            </script>
    <%} else {%>
            <header>
                <h1>Menu Cliente</h1>
            </header>
            <nav>
                <a href="http://localhost:8080/atualizar/atualizar_cliente.jsp" target="centro">Atualizar dados</a>
                <a href="http://localhost:8080/listar/listar_estoque.jsp">Ver produtos</a>
                <a href="http://localhost:8080/deletar/deletar_conta.jsp" target="centro">Deletar conta</a>
                <a href="http://localhost:8080/LogoutServlet">Sair</a>
            </nav>
            <main>
                <iframe src="http://localhost:8080/apresentacao.html" name="centro"></iframe>
            </main>
            <footer>
                <p>Alunos: Jocineudo Oliveira, Jonas Sales, Thais Ribeiro � 2024</p>
            </footer>
    <%}%>
</body>
</html>
