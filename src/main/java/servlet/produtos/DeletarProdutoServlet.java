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

@WebServlet(name="DeletarProdutoServlet", urlPatterns={"/DeletarProdutoServlet"})
public class DeletarProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("deletar/deletar_produto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        long id_produto = Long.parseLong(request.getParameter("id_produto"));
        
        
        Produto geral = new Produto();
        geral.setId_produto(id_produto);
        
        
        boolean inserido = ProdutoDAO.DeletarProduto(geral);
        
        HttpSession session = request.getSession();
        Usuario a = (Usuario) session.getAttribute("vendedor");
        boolean log = LogDAO.inserirLog(a, "delete", "produtos");
        
        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado do Cadastro</title>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("window.location.href =localhost:8080/apresentacao.html"); // Substitua pela sua página principal
            out.println("}, 5000);"); // Redireciona após 5 segundos
            out.println("</script>");
            out.println("</head>");
            out.println("<body>");
            
            if (inserido && log) {
                out.println("<h1>Produto deletado com sucesso!</h1>");
            } else {
                out.println("<h1>Erro ao deletar produto.</h1>");
                out.println("<p>Por favor verifique se o id: " +  geral.getId_produto()  + " está presente na tabela produtos.</p>");
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
