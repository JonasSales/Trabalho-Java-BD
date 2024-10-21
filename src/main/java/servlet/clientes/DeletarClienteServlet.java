package servlet.clientes;

import bancodedados.Usuario;
import dao.UsuarioDAO;
import dao.LogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet(name = "DeletarClienteServlet", urlPatterns = {"/DeletarClienteServlet"})
public class DeletarClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("deletar/deletar_cliente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id_cliente = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Usuario a = (Usuario) session.getAttribute("usuario");
        boolean log = LogDAO.inserirLog(a, "delete", "usuarios");
        boolean inserido = UsuarioDAO.DeletarUsuario(id_cliente);
        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo

        try (PrintWriter out = response.getWriter()) {
            if (inserido && log) {
                session.invalidate();

                out.println("<html>");
                out.println("<head>");
                out.println("<title>Deletação Concluída</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Obrigado pelo tempo que pudemos lhe ajudar!</h1>");
                out.println("<p>Você será redirecionado para a página principal em 3 segundos...</p>");
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.parent.location.href = 'http://localhost:8080/index.jsp';");
                out.println("}, 3000);"); 
                out.println("</script>");
                out.println("</body>");
                out.println("</html>");
            } else {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Erro</title>");
                out.println("</head>");
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
