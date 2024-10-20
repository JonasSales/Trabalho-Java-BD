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

@WebServlet(name="AtualizarProdutoServlet", urlPatterns={"/AtualizarProdutoServlet"})
public class AtualizarProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("produtos/acessar/atualizar_produto.html").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        int id_produto = Integer.parseInt(request.getParameter("id_produto"));
        String nome = request.getParameter("nome");
        String categoria = request.getParameter("categoria");
        String marca = request.getParameter("marca");
        String publico = request.getParameter("publico");
        
        Produto geral = new Produto();
        
        geral.setId_produto(id_produto);
        geral.setNome(nome);
        geral.setCategoria(categoria);
        geral.setMarca(marca);
        geral.setPublico(publico);;
        
        boolean inserido = ProdutoDAO.AtualizarProduto(geral);
        
        HttpSession session = request.getSession();
        Usuario a = (Usuario) session.getAttribute("usuario");
        boolean log = LogDAO.inserirLog(a, "update", "produto");
        
        
        response.setContentType("text/html;charset=UTF-8"); // Definindo o tipo de conteúdo
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado do Cadastro</title>");
            out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
            out.println("<script>");
            out.println("setTimeout(function() {");
            out.println("window.location.href = localhost:8080/apresentacao.html"); // Substitua pela sua página principal
            out.println("}, 5000);"); // Redireciona após 5 segundos
            out.println("</script>");
            out.println("</head>");
            out.println("<body>");
            
            if (inserido && log) {
                out.println("<h1>Produto atualizado com sucesso!</h1>");
                out.println("<p>Você será redirecionado para a página principal em 5 segundos...</p>");
            } else {
                out.println("<h1>Id não achado dentro da tabela.</h1>");
                out.println("<p>Por favor veja se existe este o id: " + geral.getId_produto() + " na tabela.</p>");
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
