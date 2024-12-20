<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trabalhe conosco</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, mascaraCNPJ} from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.mascaraCNPJ = mascaraCNPJ;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
            <form action="http://localhost:8080/CadastrarVendedorServlet" method="post">
            <h2>Insira os dados abaixo</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required>
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>CNPJ: </label>
            <input type="text" id="cnpj" name="cnpj" maxlength="18" pattern=".{18,18}" oninput="mascaraCNPJ(this)" required>
            <label>Cidade: </label>
            <input type="text" id="cidade" name="cidade" maxlength="30"  required>
            <label>Estado:
                <select  id="estado" name="estado">
                <option value="Acre">AC</option>
                <option value="Alagoas">AL</option>
                <option value="Amapá">AP</option>
                <option value="Amazonas">AM</option>
                <option value="Bahia">BA</option>
                <option value="Ceará">CE</option>
                <option value="Espírito Santo">ES</option>
                <option value="Goiás">GO</option>
                <option value="Maranhão">MA</option>
                <option value="Mato Grosso">MT</option>
                <option value="Mato Grosso do Sul">MS</option>
                <option value="Minas Gerais">MG</option>
                <option value="Pará">PA</option>
                <option value="Paraíba">PB</option>
                <option value="Paraná">PR</option>
                <option value="Pernambuco">PE</option>
                <option value="Piauí">PI</option>
                <option value="Rio de Janeiro">RJ</option>
                <option value="Rio Grande do Norte">RN</option>
                <option value="Rio Grande do Sul">RS</option>
                <option value="Rondônia">RO</option>
                <option value="Roraima">RR</option>
                <option value="Santa Catarina">SC</option>
                <option value="São Paulo">SP</option>
                <option value="Sergipe">SE</option>
                <option value="Tocantins">TO</option>
                <option value="Distrito Federal">DF</option>
            </select>
            </label>
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="submit" value="Cadastrar">
            </form>
    </body>
</html>
