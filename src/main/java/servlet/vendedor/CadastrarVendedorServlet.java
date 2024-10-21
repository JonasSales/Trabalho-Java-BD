package servlet.vendedor;

import bancodedados.Usuario;
import bancodedados.Vendedor;

import dao.VendedorDAO;
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

@WebServlet(name = "CadastrarVendedorServlet", urlPatterns = {"/CadastrarVendedorServlet"})
public class CadastrarVendedorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("adicionar/adicionar_vendedor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String datadenascimento = request.getParameter("datadenascimento");
        String cnpj = request.getParameter("cnpj");
        String cidade = request.getParameter("cidade");
        String estado = request.getParameter("estado");

        boolean log = false;

        Vendedor vendedor = new Vendedor();

        vendedor.setEmail(email);
        vendedor.setSenha(senha);
        vendedor.setNome(nome);
        vendedor.setCpf(cpf);
        vendedor.setDatadenascimento(datadenascimento);
        vendedor.setTipodeUsuario("vendedor");
        vendedor.setCnpj(cnpj);
        vendedor.setCidade(cidade);
        vendedor.setEstado(estado);
        boolean inserido = UsuarioDAO.InserirUsuario(vendedor);
        Usuario buscarId = UsuarioDAO.BuscarUsuarioPorEmail(email);

        vendedor.setId(buscarId.getId());
        boolean atualizar = VendedorDAO.AtualizarVendedor(vendedor);

        HttpSession session = request.getSession();
        Usuario a = (Usuario) session.getAttribute("usuario");
        if (a == null) {
            log = LogDAO.inserirLog(vendedor, "insert", "vendedor");

        } else {
            log = LogDAO.inserirLog(a, "insert", "vendedor");
        }

        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado do Cadastro</title>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("</head>");
            out.println("<body>");

            if (inserido && log && atualizar) {
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/LoginServlet';"); // Substitua pela sua página principal
                out.println("}, 5000);"); // Redireciona após 5 segundos
                out.println("</script>");
                out.println("<h1>Você foi cadastrado com sucesso!</h1>");
                out.println("<p>Você será redirecionado para a página de login em 5 segundos...</p>");
            } else {
                out.println("<h1>Esse email já está sendo usado</h1>");
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
