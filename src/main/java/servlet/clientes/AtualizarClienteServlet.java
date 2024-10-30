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
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet(name = "AtualizarClienteServlet", urlPatterns = {"/AtualizarClienteServlet"})
public class AtualizarClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("atualizar/atualizar_cliente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Usuario usuarioLogado = (Usuario) session.getAttribute("funcionario");

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");

        
        Usuario geral = UsuarioDAO.buscarUsuario("", id);

        geral.setNome(nome);
        geral.setCpf(cpf);
        geral.setEmail(email);

        boolean inserido = false;
        boolean log = false;

        inserido = UsuarioDAO.AtualizarUsuario(geral);
        log = LogDAO.inserirLog(usuarioLogado, "update", "usuarios");

        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo

        try (PrintWriter out = response.getWriter()) {

            if (inserido && log) {
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/apresentacao.html';"); // Substitua pela sua página principal
                out.println("}, 5000);"); // Redireciona após 5 segundos
                out.println("</script>");
                out.println("<h1>Seus dados foram atualizado com sucesso!</h1>");
                out.println("<p>Está mensagem desaparecerá em 5 segundos...</p>");
            } else {
                out.println("<h1>Erro ao atualizar seus dados.</h1>");
                out.println("<h2>Tente novamente.</h2>");
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
