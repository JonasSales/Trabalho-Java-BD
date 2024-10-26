package servlet.produtos;

import bancodedados.Produto;
import bancodedados.Usuario;
import dao.LogDAO;
import dao.ProdutoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

@WebServlet(name="CadastrarProdutoServlet", urlPatterns={"/CadastrarProdutoServlet"})
public class CadastrarProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("adicionar/adicionar_produto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
        
        String idProduto = request.getParameter("id_produto");
        String idVendedor = request.getParameter("id_vendedor");
        String nome = request.getParameter("nome");
        String categoria = request.getParameter("categoria");
        String marca = request.getParameter("marca");
        String publico = request.getParameter("publico");
        
        Produto geral = new Produto();
        
        geral.setId_produto(Integer.parseInt(idProduto));
        geral.setId_vendedor(Integer.parseInt(idVendedor));
        geral.setNome(nome);
        geral.setCategoria(categoria);
        geral.setMarca(marca);
        geral.setPublico(publico);
        
        boolean inserido = ProdutoDAO.InserirProduto(geral);
        
        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                        ? (Usuario) session.getAttribute("vendedor")
                        : (Usuario) session.getAttribute("funcionario");
        boolean log = LogDAO.inserirLog(usuarioLogado, "insert", "produtos");
        boolean log2 = LogDAO.inserirLog(usuarioLogado, "insert", "estoque");
        
        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado do Cadastro</title>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("window.location.href = 'localhost:8080/apresentacao.html'"); // Substitua pela sua página principal
            out.println("}, 5000);"); // Redireciona após 5 segundos
            out.println("</script>");
            out.println("</head>");
            out.println("<body>");
            
            if (inserido && log && log2) {
                out.println("<h1>Produto cadastrado com sucesso!</h1>");
            } else {
                out.println("<h1>Este produto já existe.</h1>");
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
