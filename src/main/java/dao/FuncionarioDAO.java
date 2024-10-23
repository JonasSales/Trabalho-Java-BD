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

    private static final String SELECT_SQL = "select * from vw_funcionarios order by id_funcionario";
    private static final String SELECT_INDIVIDUAL_SQL = "SELECT * FROM vw_funcionarios where email = ?";
    private static final String UPDATE_SQL = "UPDATE funcionario SET salario = ?, cargo=?, id_patrao = ? WHERE id_funcionario= ?";
    private static final String DELETE_SQL = "delete from usuarios WHERE id_usuario= ?";

    public static void main(String[] args) {
        //BuscarUsuarios();
        //InserirUsuario();
        //AtualizarUsuario();
        //DeletarUsuario();
    }

    public static ArrayList BuscarFuncionarios(Usuario a) {
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
                    int id = rs.getInt("id_funcionario");
                    String nome = rs.getString("nome");
                    double salario = rs.getDouble("salario");
                    String cargo = rs.getString("cargo");
                    Funcionario clt = new Funcionario();
                    clt.setId(id);
                    clt.setNome(nome);
                    clt.setSalario(salario);
                    clt.setCargo(cargo);
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
    public static boolean AtualizarFuncionario(Funcionario funcionario) {
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
    public static boolean DeletarFuncionario(int id_funcionario) {
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
    
    public static Funcionario BuscarFuncionarioPorEmail(String email) {
        Funcionario u = new Funcionario();
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECT_INDIVIDUAL_SQL);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id_funcionario");
                String nome = rs.getString("nome");
                String cpf = rs.getString("cpf");
                Double salario = rs.getDouble("salario");
                String cargo = rs.getString("cargo");
                int id_patrao = rs.getInt("id_patrao");
                String tipousuario = rs.getString("tipousuario");
                u.setId(id);
                u.setNome(nome);
                u.setEmail(email);
                u.setCpf(cpf);
                u.setSalario(salario);
                u.setCargo(cargo);
                u.setIdPatrao(id_patrao);
                u.setTipodeUsuario(tipousuario);
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }
    
}
