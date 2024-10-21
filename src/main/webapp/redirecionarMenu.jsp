<%@ page import="bancodedados.Usuario"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecionar Menu</title>
    <script type="text/javascript">
        function redirecionar(url) {
            window.location.href = url;
        }
    </script>
</head>
<body>
    <%
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
        if (usuarioLogado != null) {
            String tipoUsuario = usuarioLogado.getTipodeUsuario();
            
            if (tipoUsuario.equals("admin")) {
                %>
                <script>
                    redirecionar('http://localhost:8080/menuadmin/index.jsp');
                </script>
                <%
            } else if (tipoUsuario.equals("vendedor")) {
                %>
                <script>
                    redirecionar('http://localhost:8080/menuvendedor/index.jsp');
                </script>
                <%
            } else if (tipoUsuario.equals("cliente")) {
                %>
                <script>
                    redirecionar('http://localhost:8080/menucliente/index.jsp');
                </script>
                <%
            } else if (tipoUsuario.equals("funcionario")) {
                %>
                <script>
                    redirecionar('http://localhost:8080/menufuncionario/index.jsp');
                </script>
                <%
            } else {
                %>
                <script>
                    alert('Tipo de usuário desconhecido!');
                    redirecionar('http://localhost:8080/home.jsp');
                </script>
                <%
            }
        } else {
            %>
            <script>
                alert('Nenhum usuário logado! Redirecionando para a página inicial.');
                redirecionar('http://localhost:8080/home.jsp');
            </script>
            <%
        }
    %>
</body>
</html>