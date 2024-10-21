package servlet.vendedor;

import bancodedados.Usuario;
import bancodedados.Vendedor;
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

@WebServlet(name="AtualizarVendedorServlet", urlPatterns={"/AtualizarVendedorServlet"})
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
        Usuario a = (Usuario) session.getAttribute("usuario");
        
        
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String datadenascimento = request.getParameter("datadenascimento");
        String cnpj = request.getParameter("cnpj");
        String cidade = request.getParameter("cidade");
        String estado = request.getParameter("estado");
        String admin = "admin";
        
        Vendedor nUsuario = new Vendedor();
        
        nUsuario.setId(a.getId());
        nUsuario.setEmail(email);
        nUsuario.setSenha(senha);
        nUsuario.setNome(nome);
        nUsuario.setCpf(cpf);
        nUsuario.setDatadenascimento(datadenascimento);
        nUsuario.setCnpj(cnpj);
        nUsuario.setCidade(cidade);
        nUsuario.setEstado(estado);
        nUsuario.setTipodeUsuario("vendedor");

        boolean inserido = false; 
        boolean log = false;
        if (a.getTipodeUsuario().equals(admin)) {
            int id = Integer.parseInt(request.getParameter("id_vendedor"));
            nUsuario.setId(id);
            nUsuario.setTipodeUsuario("vendedor");
            inserido = UsuarioDAO.AtualizarUsuario(nUsuario);
            log = LogDAO.inserirLog(a, "update", "vendedor");
        }
        else{
            nUsuario.setId(a.getId());
            nUsuario.setTipodeUsuario("vendedor");
            inserido = UsuarioDAO.AtualizarUsuario(nUsuario);
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
            
            if (inserido && log) {
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
