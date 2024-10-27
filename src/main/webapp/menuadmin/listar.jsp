<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Página Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
        <script type="module">
            import {redirecionar, reloadPage } from 'http://localhost:8080/utils.js';
            window.redirecionar = redirecionar;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("admin");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("funcionario");
            if (verificadorUm || verificadorDois || verificadorTres) {%>
        <header>
            <h1>Listas</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/listar/listar_vendedores.jsp" target="centro">Listar vendedores</a>
            <a href="http://localhost:8080/listar/listar_funcionarios.jsp" target="centro">Listar funcionarios </a>
            <a href="http://localhost:8080/menuadmin/log.jsp" target="centro">Ver logs</a>
            <a href="http://localhost:8080/menuadmin/index.jsp" >Voltar para a Página Principal</a>
        </nav>
        <main>
            <iframe src="http://localhost:8080/apresentacao.html" name ="centro"></iframe>
        </main>
        <footer>
            <p>Alunos: Jocineudo Oliveira Jonas Sales Thais Ribeiro © 2024</p>
        </footer>
        <%} else {%>
        <div>
            Você não tem permissão para acessar esta página. Por favor, entre como administrador.
        </div>
        <script>
            setTimeout(function () {
                redirecionar('http://localhost:8080');
            }, 5000); // redireciona após 5 segundos
        </script>
        <%}%>
    </body>
</html>