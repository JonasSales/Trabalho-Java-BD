package dao;

import bancodedados.Estoque;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import org.postgresql.Driver;

public class EstoqueDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";

    private static final String SELECT_SQL = "select * from vw_produtos_estoque order by id_produto;";
    private static final String UPDATE_SQL = "UPDATE estoque SET quantidade= ?, peso= ?, dimensoes= ?, preco= ? WHERE id_produto = ?";
    private static final String SELECT_BY_ID_SQL = "SELECT * FROM vw_produtos_estoque WHERE id_produto = ?;";

    public static void main(String[] args) {
        //BuscarUsuarios();
        //InserirUsuario();
        //AtualizarUsuario();
        //DeletarUsuario();
    }

    //CRUD
    //READ
    public static ArrayList BuscarEstoque() {
        ArrayList<Estoque> estoque = new ArrayList();

        try {

            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id_produto");
                String nome = rs.getString("nome_produto");
                int quantidade = rs.getInt("quantidade");
                double peso = rs.getDouble("peso");
                String dimensoes = rs.getString("dimensoes");
                double preco = rs.getDouble("preco");

                Estoque p = new Estoque();

                p.setId(id);
                p.setNome(nome);
                p.setQuantidade(quantidade);
                p.setPeso(peso);
                p.setDimensoes(dimensoes);
                p.setPreco(preco);

                estoque.add(p);
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estoque;
    }

    //UPDATE
    public static boolean AtualizarEstoque(Estoque estoque) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(UPDATE_SQL);

            stmt.setInt(1, estoque.getQuantidade());
            stmt.setDouble(2, estoque.getPeso());
            stmt.setString(3, estoque.getDimensoes());
            stmt.setDouble(4, estoque.getPreco());
            stmt.setInt(5, estoque.getId());

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

    public static Estoque BuscarEstoquePorId(int idProduto) {
        Estoque estoque = null;

        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = DriverManager.getConnection(URL, USUARIO, SENHA);
            PreparedStatement stmt = conectando.prepareStatement(SELECT_BY_ID_SQL);
            stmt.setInt(1, idProduto);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                estoque = new Estoque();
                estoque.setId(rs.getInt("id_produto"));
                estoque.setNome(rs.getString("nome_produto"));
                estoque.setQuantidade(rs.getInt("quantidade"));
                estoque.setPeso(rs.getDouble("peso"));
                estoque.setDimensoes(rs.getString("dimensoes"));
                estoque.setPreco(rs.getDouble("preco"));
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estoque;
    }

}
