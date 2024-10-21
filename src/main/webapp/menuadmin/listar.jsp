<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>P�gina Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
        <script type="module">
            import {redirecionar,reloadPage } from 'http://localhost:8080/utils.js';
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("funcionario");
            if (verificadorUm || verificadorDois || verificadorTres) {%>
            <header>
            <h1>Listas</h1>
            </header>
            <nav>
            <strong><%= usuarioLogado.getNome() %></strong>
            <br><br/>
            <a href="http://localhost:8080/listar/listar_cliente.jsp">Listar clientes </a>
            <a href="http://localhost:8080/listar/listar_vendedores.jsp">Listar vendedores</a>
            <a href="http://localhost:8080/listar/listar_funcionarios.jsp">Listar funcionarios </a>
            <a href="http://localhost:8080/menuadmin/index.jsp">Voltar para a P�gina Principal</a>
            </nav>
            <main>
            <iframe src="http://localhost:8080/apresentacao.html" name ="centro"></iframe>
            </main>
            <footer>
            <p>Alunos: Jocineudo Oliveira Jonas Sales Thais Ribeiro � 2024</p>
            </footer>
            <%}else{%>
            <div>
                Voc� n�o tem permiss�o para acessar esta p�gina. Por favor, entre como administrador.
            </div>
            <script>
                setTimeout(function() {
                    redirecionar('http://localhost:8080');
                }, 5000); // redireciona ap�s 5 segundos
            </script>
            <%}%>
    </body>
</html>