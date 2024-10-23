package dao;

import bancodedados.Login;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import org.postgresql.Driver;
import java.sql.ResultSet;


public class LoginDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";

    private static final String SELECTPOREMAIL_SQL = "select email,senha,tipousuario from usuarios where email = ?";

    public static Login BuscarUsuarioPorEmail(String email) {
        Login u = new Login();
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECTPOREMAIL_SQL);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                String senha = rs.getString("senha");
                String emailBD = rs.getString("email");
                String tipousuario = rs.getString("tipousuario");
                u.setSenha(senha);
                u.setEmail(emailBD);
                u.setTipoUsuario(tipousuario);
                        
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return u;
    }

}
