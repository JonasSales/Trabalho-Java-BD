package servlet.vendas;

import bancodedados.Funcionario;
import bancodedados.Produto;
import dao.FuncionarioDAO;
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

@WebServlet(name = "carrinhoServlet", urlPatterns = {"/carrinhoServlet"})
public class AdicionarCarrinhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("vendas/registrarvendas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        long id_produto = Long.parseLong(request.getParameter("idDoProduto"));
        int id_vendedor = Integer.parseInt(request.getParameter("idDoVendedor"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        ArrayList<Produto> carrinho = (ArrayList<Produto>) session.getAttribute("carrinho");
        carrinho = (ArrayList<Produto>) session.getAttribute("carrinho");
        Produto produto = ProdutoDAO.BuscarProduto(id_produto, id_vendedor);
        if (carrinho == null) {
            carrinho = new ArrayList<>();
            session.setAttribute("carrinho", carrinho);
        }
        boolean produtoExistente = false;

        for (Produto u : carrinho) {
            if (u.getId_produto() == produto.getId_produto()) {
                if (quantidade > produto.getQuantidade()) {
                    u.setQuantidade(produto.getQuantidade());
                } else {
                    u.setQuantidade(quantidade);
                }
                produtoExistente = true;
                break;
            }
        }
        if (!produtoExistente) {
            if (quantidade > produto.getQuantidade()) {
                produto.setQuantidade(produto.getQuantidade());
            } else {
                produto.setQuantidade(quantidade);
            }
            carrinho.add(produto);
        }
        RequestDispatcher rd = request.getRequestDispatcher("vendas/registrarvendas.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
