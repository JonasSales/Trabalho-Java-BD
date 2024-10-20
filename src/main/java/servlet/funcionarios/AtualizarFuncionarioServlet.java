package servlet.funcionarios;

import bancodedados.Usuario;
import bancodedados.Funcionario;

import dao.FuncionarioDAO;
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

@WebServlet(name="AtualizarFuncionarioServlet", urlPatterns={"/AtualizarFuncionarioServlet"})
public class AtualizarFuncionarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("funcionarios/acessar/atualizar_funcionario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario a = (Usuario) session.getAttribute("usuario");
        
        int id_funcionario = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String datadenascimento = request.getParameter("datadenascimento");
        
        Double salario = Double.valueOf(request.getParameter("salario"));
        String cargo = request.getParameter("cargo");
        
        Usuario nUsuario = new Usuario();
        
        nUsuario.setId(id_funcionario);
        nUsuario.setEmail(email);
        nUsuario.setSenha(senha);
        nUsuario.setNome(nome);
        nUsuario.setCpf(cpf);
        nUsuario.setDatadenascimento(datadenascimento);
        nUsuario.setTipodeUsuario("funcionario");
        
        boolean inserido = UsuarioDAO.AtualizarUsuario(nUsuario);
        
        Funcionario nFuncionario = FuncionarioDAO.BuscarFuncionario(id_funcionario);
        
        nFuncionario.setIdPatrao(a.getId());
        nFuncionario.setId(id_funcionario);
        nFuncionario.setIdPatrao(a.getId());
        nFuncionario.setSalario(salario);
        nFuncionario.setCargo(cargo);
        
        boolean atualizar= FuncionarioDAO.AtualizarFuncionario(nFuncionario);
        
        boolean log = LogDAO.inserirLog(a, "update", "funcionarios");
        
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
            
            if (inserido && log && atualizar) {
                out.println("<h1>Funcionario atualizado com sucesso!</h1>");
                out.println("<p>Você será redirecionado para a página de login em 5 segundos...</p>");
            } else {
                out.println("<h1>Erro ao realizar cadastro.</h1>");
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
