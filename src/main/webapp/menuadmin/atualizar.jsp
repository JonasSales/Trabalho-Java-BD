<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualiza��o de Dados</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    <script type="module">
        import { redirecionar } from 'http://localhost:8080/utils.js';
        window.redirecionar = redirecionar;
    </script>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
    <%
        Usuario usuarioLogado = (Usuario) session.getAttribute("admin");
        // Verifica se o usu�rio est� logado e se � admin
        String tipoUsuario = "admin";
        if (usuarioLogado == null || !usuarioLogado.getTipodeUsuario().equals(tipoUsuario)) {
    %>
            <div>
                Voc� n�o tem permiss�o para acessar esta p�gina. Por favor, entre como administrador.
            </div>
            <script>
                setTimeout(function() {
                    redirecionar('http://localhost:8080');
                }, 5000); // redireciona ap�s 5 segundos
            </script>
    <%
        } else {
    %>
            <header>
                <h1>Atualizar</h1>
            </header>
            <nav>
                <br><br>
                <a href="http://localhost:8080/atualizar/atualizar_vendedor.jsp" target="centro">Atualizar Vendedor</a>
                <a href="http://localhost:8080/menuadmin/index.jsp">Voltar para a P�gina Principal</a>
            </nav>
            <main>
                <iframe src="http://localhost:8080/apresentacao.html" name="centro"></iframe>
            </main>
            <footer>
                <p>Alunos: Jocineudo Oliveira, Jonas Sales, Thais Ribeiro � 2024</p>
            </footer>
    <%
        }
    %>
</body>
</html>
