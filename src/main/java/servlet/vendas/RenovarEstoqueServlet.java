package servlet.vendas;

import bancodedados.Produto;
import dao.ProdutoDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet(name = "RenovarEstoqueServlet", urlPatterns = {"/RenovarEstoqueServlet"})
public class RenovarEstoqueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("vendas/registrarvendas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ArrayList<Produto> carrinho = (ArrayList<Produto>) session.getAttribute("carrinho");
        carrinho = (ArrayList<Produto>) session.getAttribute("carrinho");
        if (carrinho == null) {
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }else{
         for (Produto u : carrinho) {
            Produto produto = ProdutoDAO.BuscarProduto(u.getId_produto(), u.getId_vendedor());
            u.setQuantidade(produto.getQuantidade() - u.getQuantidade());
            ProdutoDAO.AtualizarEstoque(u);
            }
        }
        carrinho.clear();
        RequestDispatcher rd = request.getRequestDispatcher("vendas/registrarvendas.jsp");
        rd.forward(request, response);
        }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
