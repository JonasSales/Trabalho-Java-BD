package servlet.vendedor;

import bancodedados.Usuario;
import bancodedados.Vendedor;
import dao.LogDAO;
import dao.UsuarioDAO;
import dao.VendedorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet(name = "AtualizarVendedorServlet", urlPatterns = {"/AtualizarVendedorServlet"})
public class AtualizarVendedorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("atualizar/atualizar_vendedor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                ? (Usuario) session.getAttribute("vendedor")
                : (Usuario) session.getAttribute("admin");

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String cnpj = request.getParameter("cnpj");
        String cidade = request.getParameter("cidade");
        String estado = request.getParameter("estado");
        String admin = "admin";

        int id = 0;
        Vendedor nUsuario = new Vendedor();

        nUsuario.setId(id);
        nUsuario.setEmail(email);
        nUsuario.setSenha(senha);
        nUsuario.setNome(nome);
        nUsuario.setCpf(cpf);
        nUsuario.setCnpj(cnpj);
        nUsuario.setCidade(cidade);
        nUsuario.setEstado(estado);
        nUsuario.setTipodeUsuario("vendedor");

        boolean inserido = false;
        boolean inserido2 = false;
        boolean log = false;

        if (usuarioLogado.getTipodeUsuario().equals(admin)) {
            nUsuario.setId(id);
            nUsuario.setTipodeUsuario("vendedor");
            inserido = UsuarioDAO.AtualizarUsuario(nUsuario);
            inserido2 = VendedorDAO.atualizarVendedor(nUsuario);
            log = LogDAO.inserirLog(usuarioLogado, "update", "vendedor");
        } else {
            nUsuario.setId(usuarioLogado.getId());
            nUsuario.setTipodeUsuario("vendedor");
            inserido = UsuarioDAO.AtualizarUsuario(nUsuario);
            inserido2 = VendedorDAO.atualizarVendedor(nUsuario);
            log = LogDAO.inserirLog(nUsuario, "update", "vendedor");
        }

        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado do Cadastro</title>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("window.location.href = 'http://localhost:8080/apresentacao.html';"); // Substitua pela sua página principal
            out.println("}, 5000);"); // Redireciona após 5 segundos
            out.println("</script>");
            out.println("</head>");
            out.println("<body>");

            if (inserido && inserido2 && log) {
                out.println("<h1>Atualização realizada com sucesso!</h1>");
                out.println("<p>Você será redirecionado para a página de login em 5 segundos...</p>");
            } else {
                out.println("<h1>Erro ao realizar atualização.</h1>");
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
