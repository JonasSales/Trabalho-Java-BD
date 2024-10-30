package servlet.clientes;

import bancodedados.Usuario;
import dao.UsuarioDAO;
import dao.LogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeletarClienteServlet", urlPatterns = {"/DeletarClienteServlet"})
public class DeletarClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("deletar/deletar_conta.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id_cliente = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        boolean verificador = false;
        boolean log = false;

        if (session.getAttribute("funcionario") != null) {

            Usuario usuarioLogado = (Usuario) session.getAttribute("funcionario");
            log = LogDAO.inserirLog(usuarioLogado, "delete", "funcionario");

        } else if (session.getAttribute("admin") != null) {

            Usuario usuarioLogado = (Usuario) session.getAttribute("admin");
            verificador = true;
            log = LogDAO.inserirLog(usuarioLogado, "delete", "usuarios");
            
        } else if (session.getAttribute("vendedor") != null) {

            verificador = true;
            Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor");
            log = LogDAO.inserirLog(usuarioLogado, "delete", "usuarios");

        } else {

            Usuario usuarioLogado = (Usuario) session.getAttribute("cliente");
            log = LogDAO.inserirLog(usuarioLogado, "delete", "cliente");

        }

        boolean inserido = UsuarioDAO.DeletarUsuario(id_cliente);
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (inserido && log) {

                out.println("<html>");
                out.println("<head><title>Deletação Concluída</title></head>");
                out.println("<body>");
                out.println("<h1>Deletado com sucesso</h1>");
                if (!verificador) {
                    session.invalidate();
                    out.println("<script>");
                    out.println("window.top.location.href = 'http://localhost:8080/LogoutServlet';"); // Redireciona a página principal
                    out.println("</script>");
                    out.println("</body>");
                    out.println("</html>");
                }

            } else {
                out.println("<html>");
                out.println("<head><title>Erro</title></head>");
                out.println("<body>");
                out.println("<h1>Erro ao deletar cliente.</h1>");
                out.println("<p>Por favor, verifique se o ID: " + id_cliente + " realmente existe.</p>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para cadastro de usuários";
    }
}
