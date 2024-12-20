<%@page import="bancodedados.Vendedor"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Adicionar produto</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraDimensoes, redirecionar} from 'http://localhost:8080/utils.js';
            window.mascaraDimensoes = mascaraDimensoes;
            window.redirecionar = redirecionar;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Vendedor usuarioLogado = (Vendedor) session.getAttribute("vendedor");
            if (usuarioLogado.getTipodeUsuario().equals("vendedor")) {%>
            <form action="http://localhost:8080/CadastrarProdutoServlet" method="post">
            <h2>Adicionar</h2>
            <label>ID:</label>
            <input type="number" id="id_produto" name="id_produto" required>
            <label>Nome do produto:</label>
            <input type="text" id="nome" name="nome" required>
            <label>Categoria:</label>
            <input type="text" id="categoria"  name="categoria" required>
            <label>Marca:</label>
            <input type="text" id="marca"  name="marca" required>
            <label>Publico:
                <select  id="publico" name="publico">
                    <option value="Adulto">Adulto</option>
                    <option value="Infantil">Infantil</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino">Feminino</option>
                    <option value ="Unissex">Unissex</option>
                  </select>  
              </label> 
            <input type="hidden" name="id_vendedor" value="<%=usuarioLogado.getId()%>">
            <input type="submit" value="Adicionar">
            </form>
        
        <%} else {%>
        <div>
            Voc� n�o tem permiss�o para acessar esta p�gina. Por favor, entre como cliente.
        </div>
        <script>
            setTimeout(function () {
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona ap�s 5 segundos
            }, 5000);
        </script>
        <%}%>
    </body>
</html>
