package dao;

import bancodedados.Produto;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import org.postgresql.Driver;

public class ProdutoDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";

    private static final String INSERT_SQL = "INSERT INTO produtos(id_produto, id_vendedor ,nome_produto, categoria, marca, publico) VALUES (?,?,?,?, ?, ?)";
    private static final String SELECT_SQL = "SELECT * FROM vw_produtos_estoque WHERE ((CAST(id_produto AS TEXT) LIKE ? or nome_produto like ?) and (id_vendedor = ?) and (quantidade >= 0));";
    private static final String UPDATEPRODUTO_SQL = "UPDATE produtos SET nome_produto = ?, categoria= ?, marca= ?, publico = ? WHERE ((id_produto = ?) and (id_vendedor = ?))";
    private static final String UPDATEESTOQUE_SQL = "UPDATE estoque SET quantidade= ?, peso= ?, dimensoes= ?, preco= ? WHERE ((id_produto = ?) and (id_vendedor = ?))";
    private static final String DELETE_SQL = "delete from produtos WHERE id_produto= ?";
    private static final String BUSCARPRODUTO_SQL = "SELECT * from vw_produtos_estoque WHERE ((id_produto = ?) and (id_vendedor = ?))";

    public static void main(String[] args) {

    }

    //CRUD
    //READ
    public static ArrayList<Produto> BuscarProdutos(String idProduto, int idVendedor) {
        ArrayList<Produto> produtos = new ArrayList<>();
        
        Connection c = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            c = DriverManager.getConnection(URL, USUARIO, SENHA);
            statement = c.prepareStatement(SELECT_SQL);
            statement.setString(1, "%" +  idProduto + "%");
            statement.setString(2, "%" +  idProduto + "%");
            statement.setInt(3, idVendedor);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Produto produto = new Produto();
                produto.setId_produto(resultSet.getLong("id_produto"));
                produto.setNome(resultSet.getString("nome_produto"));
                produto.setCategoria(resultSet.getString("categoria"));
                produto.setMarca(resultSet.getString("marca"));
                produto.setPublico(resultSet.getString("publico"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setPeso(resultSet.getDouble("peso"));
                produto.setDimensoes(resultSet.getString("dimensoes"));
                produto.setPreco(resultSet.getDouble("preco"));
                produtos.add(produto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Fechamento seguro dos recursos
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (c != null) {
                    c.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return produtos;
    }

    //CREATE
    public static boolean InserirProduto(Produto produto) {

        boolean sucesso = false;

        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);
            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);
            PreparedStatement stmt = c.prepareStatement(INSERT_SQL);

            stmt.setLong(1, produto.getId_produto());
            stmt.setLong(2, produto.getId_vendedor());
            stmt.setString(3, produto.getNome());
            stmt.setString(4, produto.getCategoria());
            stmt.setString(5, produto.getMarca());
            stmt.setString(6, produto.getPublico());

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
    public static boolean AtualizarProduto(Produto produto) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(UPDATEPRODUTO_SQL);

            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getCategoria());
            stmt.setString(3, produto.getMarca());
            stmt.setString(4, produto.getPublico());
            stmt.setLong(5, produto.getId_produto());
            stmt.setLong(6, produto.getId_vendedor());

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
    public static boolean DeletarProduto(Produto produto) {
        boolean sucesso = false;
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection c = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = c.prepareStatement(DELETE_SQL);
            stmt.setLong(1, produto.getId_produto());

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

    public static Produto BuscarProduto(long idProduto, int idVendedor) {
        Produto produto = new Produto();
        Connection c = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);
            c = DriverManager.getConnection(URL, USUARIO, SENHA);

            statement = c.prepareStatement(BUSCARPRODUTO_SQL);
            statement.setLong (1, idProduto);
            statement.setInt(2, idVendedor);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                
                produto.setId_produto(resultSet.getLong("id_produto"));
                produto.setId_vendedor(resultSet.getInt("id_vendedor"));
                produto.setNome(resultSet.getString("nome_produto"));
                produto.setCategoria(resultSet.getString("categoria"));
                produto.setMarca(resultSet.getString("marca"));
                produto.setPublico(resultSet.getString("publico"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setPeso(resultSet.getDouble("peso"));
                produto.setDimensoes(resultSet.getString("dimensoes"));
                produto.setPreco(resultSet.getDouble("preco"));
                
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Fechar recursos
            if (resultSet != null) try {
                resultSet.close();
            } catch (SQLException e) {
            }
            if (statement != null) try {
                statement.close();
            } catch (SQLException e) {
            }
            if (c != null) try {
                c.close();
            } catch (SQLException e) {
            }
        }

        return produto;
    }
    
    public static boolean AtualizarEstoque(Produto estoque) {
    boolean sucesso = false;
    try {
        Class.forName("org.postgresql.Driver");

        Connection c = DriverManager.getConnection(URL, USUARIO, SENHA);

        PreparedStatement stmt = c.prepareStatement(UPDATEESTOQUE_SQL);
        stmt.setInt(1, estoque.getQuantidade());
        stmt.setDouble(2, estoque.getPeso());
        stmt.setString(3, estoque.getDimensoes());
        stmt.setDouble(4, estoque.getPreco());
        stmt.setLong(5, estoque.getId_produto());
        stmt.setLong(6, estoque.getId_vendedor());

        int rowsAffect = stmt.executeUpdate();
        sucesso = rowsAffect > 0;

        stmt.close();
        c.close();

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();  // Use um logger para registro mais robusto
    }
    return sucesso;
}
    
}
