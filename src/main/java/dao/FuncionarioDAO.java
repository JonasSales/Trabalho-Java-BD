package dao;

import bancodedados.Funcionario;
import bancodedados.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import org.postgresql.Driver;

public class FuncionarioDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";

    private static final String SELECT_SQL = "select * from vw_funcionarios order by id_usuario";
    private static final String SELECT_INDIVIDUAL_SQL = "SELECT * FROM vw_funcionarios where (((email = ?) or (id_usuario= ?)) and (ativo = true))";
    private static final String UPDATE_SQL = "UPDATE funcionario SET salario = ?, cargo=?, id_patrao = ? WHERE (id_funcionario= ?)";
    private static final String DELETE_SQL = "update usuarios set ativo = false, email = id_usuario WHERE (id_usuario= ?)";

    public static void main(String[] args) {
        
    }

    public static ArrayList buscarFuncionarios(Usuario a) {
        ArrayList<Funcionario> funcionario = new ArrayList();
        try {

            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);
            PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);

            ResultSet rs = stmt.executeQuery();
            String admin = "admin";
            while (rs.next()) {

                if ((rs.getInt("id_patrao") == a.getId()) || a.getTipodeUsuario().equals(admin)) {
                    Funcionario clt = new Funcionario();
                    clt.setId(rs.getInt("id_usuario"));
                    clt.setNome(rs.getString("nome"));
                    clt.setSalario(rs.getDouble("salario"));
                    clt.setCargo(rs.getString("cargo"));
                    funcionario.add(clt);
                }

            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return funcionario;
    }

    //UPDATE
    public static boolean atualizarFuncionario(Funcionario funcionario) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(UPDATE_SQL);

            stmt.setDouble(1, funcionario.getSalario());
            stmt.setString(2, funcionario.getCargo());
            stmt.setInt(3,funcionario.getIdPatrao());
            stmt.setInt(4, funcionario.getId());

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
    public static boolean deletarFuncionario(int id_funcionario) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(DELETE_SQL);
            stmt.setInt(1, id_funcionario);

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
    
    public static Funcionario buscarFuncionario(String email, int idFuncionario) {
        Funcionario u = new Funcionario();
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECT_INDIVIDUAL_SQL);
            stmt.setString(1, email);
            stmt.setInt(2, idFuncionario);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                u.setId(rs.getInt("id_usuario"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setCpf(rs.getString("cpf"));
                u.setSalario(rs.getDouble("salario"));
                u.setCargo(rs.getString("cargo"));
                u.setIdPatrao(rs.getInt("id_patrao"));
                u.setTipodeUsuario(rs.getString("tipousuario"));
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }
    }
