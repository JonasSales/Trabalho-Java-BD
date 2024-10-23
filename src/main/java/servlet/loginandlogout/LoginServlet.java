package servlet.loginandlogout;

import bancodedados.Funcionario;
import bancodedados.Login;
import bancodedados.Usuario;
import bancodedados.Vendedor;

import dao.FuncionarioDAO;
import dao.LoginDAO;
import dao.UsuarioDAO;
import dao.VendedorDAO;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        boolean login = false;

        Login a = LoginDAO.BuscarUsuarioPorEmail(email);
        if (a.getEmail() != null && a.getSenha().equals(senha)) {
            login = true;
        }
        if(login){
            HttpSession session = request.getSession();
            String admin = "admin";
            String funcionario = "funcionario";
            String vendedor = "vendedor";
            String cliente = "cliente";
            
            if (a.getTipoUsuario().equals(admin)) {
                Usuario adminH = UsuarioDAO.BuscarUsuarioPorEmail(email);
                session.setAttribute("admin", adminH);
                RequestDispatcher rd = request.getRequestDispatcher("menuadmin/index.jsp");
                rd.forward(request, response);
            }
            else if(a.getTipoUsuario().equals(funcionario)){
                Funcionario funcionarioH = FuncionarioDAO.BuscarFuncionarioPorEmail(email);
                session.setAttribute("funcionario", funcionarioH);
                RequestDispatcher rd = request.getRequestDispatcher("menufuncionario/index.jsp");
                rd.forward(request, response);
            }
            else if(a.getTipoUsuario().equals(vendedor)){
                Vendedor vendedorH = VendedorDAO.BuscarVendedorPorEmail(email);
                session.setAttribute("vendedor", vendedorH);
                RequestDispatcher rd = request.getRequestDispatcher("menuvendedor/index.jsp");
                rd.forward(request, response);
            }
            else if(a.getTipoUsuario().equals(cliente)){
                Usuario clienteH = UsuarioDAO.BuscarUsuarioPorEmail(email);
                session.setAttribute("cliente", clienteH);
                RequestDispatcher rd = request.getRequestDispatcher("menucliente/index.jsp");
                rd.forward(request, response);
            }
        }
        else{
            request.setAttribute("erro", "email/senha incorretos");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
