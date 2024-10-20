package servlet.clientes;

import bancodedados.Usuario;
import dao.LogDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet(name = "CadastrarClienteServlet", urlPatterns = {"/CadastrarClienteServlet"})
public class CadastrarClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("clientes/acessar/adicionar_cliente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String datadenascimento = request.getParameter("datadenascimento");

        Usuario geral = new Usuario();
        geral.setEmail(email);
        geral.setSenha(senha);
        geral.setNome(nome);
        geral.setCpf(cpf);
        geral.setDatadenascimento(datadenascimento);
        geral.setTipodeUsuario("cliente");

        boolean inserido = UsuarioDAO.InserirUsuario(geral);
        boolean log = LogDAO.inserirLog(geral, "insert", "usuarios");
        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo

        try (PrintWriter out = response.getWriter()) {

            if (inserido && log) {
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/LoginServlet';"); // Substitua pela sua página principal
                out.println("}, 3000);"); // Redireciona após 5 segundos
                out.println("</script>");
                out.println("<h1>Você foi cadastrado com sucesso com sucesso!</h1>");
                out.println("<p>Agora você será redirecionado para a página de login em 3 segundos...</p>");
            } else {
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/CadastrarClienteServlet';"); // Substitua pela sua página principal
                out.println("}, 3000);"); // Redireciona após 5 segundos
                out.println("</script>");
                out.println("<h1>Esse email já está cadastrado, por favor utilize outro.</h1>");
                out.println("<p>Tente novamente.</p>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para cadastro de usuários";
    }
}
