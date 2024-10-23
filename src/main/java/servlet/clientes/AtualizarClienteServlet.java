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

        
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        //String senha = request.getParameter("senha");

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("funcionario") != null
                    ? (Usuario) session.getAttribute("funcionario")
                    : (session.getAttribute("admin") != null
                    ? (Usuario) session.getAttribute("admin")
                    : (Usuario) session.getAttribute("cliente"));
        String admin = "admin";
        Usuario geral = new Usuario();
        geral.setNome(nome);
        geral.setCpf(cpf);
        geral.setEmail(email);
        geral.setTipodeUsuario("cliente");
        boolean inserido = false; 
        boolean log = false;
        if (usuarioLogado.getTipodeUsuario().equals(admin)) {
            int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
            geral.setId(id_cliente);
            
            inserido = UsuarioDAO.AtualizarUsuario(geral);
            
            log = LogDAO.inserirLog(usuarioLogado, "update", "usuarios");
        }
        else{
            geral.setId(usuarioLogado.getId());
            inserido = UsuarioDAO.AtualizarUsuario(geral);
            log = LogDAO.inserirLog(geral, "update", "usuarios");
        }

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
