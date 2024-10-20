package dao;

import bancodedados.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import org.postgresql.Driver;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UsuarioDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";

    private static final String SELECT_SQL = "SELECT id_usuario, nome, cpf, email, datadenascimento FROM usuarios where tipousuario = ? order by id_usuario; ";
    private static final String INSERT_SQL = "INSERT INTO usuarios (email, senha, nome, cpf,datadenascimento, tipousuario)  VALUES (?,?,?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?)";
    private static final String SELECTPOREMAIL_SQL = "select * from usuarios where email = ?";
    private static final String UPDATE_SQL = "UPDATE usuarios SET nome = ?, cpf = ?, email = ?, tipousuario = ? ,datadenascimento = TO_DATE(?, 'YYYY-MM-DD') WHERE id_usuario = ?";
    private static final String DELETE_SQL = "delete from usuarios WHERE id_usuario= ?";

    public static void main(String[] args) {
        
    }

    //CRUD
    public static ArrayList BuscarClientes(String tipoUsuario){
        ArrayList<Usuario> clientes = new ArrayList();
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        Connection conectando = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
          
        PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);
        
        stmt.setString(1, tipoUsuario);
        ResultSet rs = stmt.executeQuery();   
        while(rs.next()){
            int id = rs.getInt("id_usuario");
            String nome = rs.getString("nome");
            String cpf = rs.getString("cpf");
            String email = rs.getString("email");
            String dataDeNascimento = rs.getString("datadenascimento");
            Usuario c = new Usuario();
            
            c.setId(id);
            c.setNome(nome);
            c.setCpf(cpf);
            c.setEmail(email);
            c.setDatadenascimento(dataDeNascimento);
            clientes.add(c);
        }
        
        stmt.close();
        conectando.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        
        return clientes;
    }
    
    public static Usuario BuscarUsuarioPorEmail(String email) {
        Usuario u = new Usuario();
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECTPOREMAIL_SQL);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id_usuario");
                String senha = rs.getString("senha");
                String emailBD = rs.getString("email");
                String nome = rs.getString("nome");
                String tipousuario = rs.getString("tipousuario");
                u.setId(id);
                u.setSenha(senha);
                u.setEmail(emailBD);
                u.setNome(nome);
                u.setTipodeUsuario(tipousuario);
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return u;
    }

    //CREATE
    public static boolean InserirUsuario(Usuario usuario) {
        boolean sucesso = false;

        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);
            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);
            PreparedStatement stmt = c.prepareStatement(INSERT_SQL);

            stmt.setString(1, usuario.getEmail());
            stmt.setString(2, usuario.getSenha());
            stmt.setString(3, usuario.getNome());
            stmt.setString(4, usuario.getCpf());
            stmt.setString(5, usuario.getDatadenascimento());
            stmt.setString(6, usuario.getTipodeUsuario());

            int rowsAffect = stmt.executeUpdate();

            if (rowsAffect > 0) {
                sucesso = true;
            }

            stmt.close();
            c.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucesso;
    }

    //UPDATE
    public static boolean AtualizarUsuario(Usuario usuario) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(UPDATE_SQL);

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getCpf());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getTipodeUsuario());
            stmt.setString(5, usuario.getDatadenascimento());
            stmt.setInt(6, usuario.getId());

            int rowsAffect = stmt.executeUpdate();

            if (rowsAffect > 0) {
                sucesso = true;
            }

            stmt.close();
            c.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sucesso;
    }

    //DELETE
    public static boolean DeletarUsuario(int id_usuario) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(DELETE_SQL);
            stmt.setInt(1, id_usuario);

            int rowsAffect = stmt.executeUpdate();

            if (rowsAffect > 0) {
                sucesso = true;
            }

            stmt.close();
            c.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sucesso;

    }
}
