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
        request.getRequestDispatcher("adicionar/cadastrarvendedor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String cnpj = request.getParameter("cnpj");
        String cidade = request.getParameter("cidade");
        String estado = request.getParameter("estado");

        
        Usuario geral = new Usuario();
        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("admin");
        
        if (usuarioLogado == null) {
            geral.setId(0);
        }
        
        Vendedor vendedor = new Vendedor();
        
        vendedor.setEmail(email);
        vendedor.setSenha(senha);
        vendedor.setNome(nome);
        vendedor.setCpf(cpf);
        vendedor.setTipodeUsuario("vendedor");
        vendedor.setCnpj(cnpj);
        vendedor.setCidade(cidade);
        vendedor.setEstado(estado);
        boolean inserido = UsuarioDAO.InserirUsuario(vendedor);
        Usuario buscarUsuario = UsuarioDAO.buscarUsuario(email, 0);

        vendedor.setId(buscarUsuario.getId());
        boolean atualizar = VendedorDAO.atualizarVendedor(vendedor);
        boolean log = LogDAO.inserirLog(buscarUsuario, "insert", "vendedor");
        
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
                out.println("}, 1000);"); // Redireciona após 5 segundos
                out.println("</script>");
                out.println("<h1>Você foi cadastrado com sucesso!</h1>");
            } else {
                out.println("<p>Esse email já existe.</p>");
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/CadastrarVendedorServlet';"); // Substitua pela sua página principal
                out.println("}, 2000);"); 
                out.println("</script>");
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
