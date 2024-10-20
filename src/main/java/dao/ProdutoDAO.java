
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
    
    private static final String INSERT_SQL = "INSERT INTO produtos(id_produto, nome_produto, categoria, marca, publico) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_SQL = "select * from produtos order by id_produto;";
    private static final String UPDATE_SQL = "UPDATE produtos SET nome_produto = ?, categoria= ?, marca= ?, publico = ? WHERE id_produto = ?";
    private static final String DELETE_SQL = "delete from produtos WHERE id_produto= ?";
    
    
    public static void main(String[] args){
        //BuscarUsuarios();
        //InserirUsuario();
        //AtualizarUsuario();
        //DeletarUsuario();
    }
    
    //CRUD
    //READ
    public static ArrayList BuscarProdutos(){
        ArrayList<Produto> produtos = new ArrayList();
        
        try {
    
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);

        
        Connection conectando = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        
        
        PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);
        
        ResultSet rs = stmt.executeQuery();
        
        
        while(rs.next()){
            int id = rs.getInt("id_produto");
            String nome = rs.getString("nome_produto");
            String categoria = rs.getString("categoria");
            String marca = rs.getString("marca");
            String publico = rs.getString("publico");
            
            Produto p = new Produto();
            
            p.setId_produto(id);
            p.setNome(nome);
            p.setCategoria(categoria);
            p.setMarca(marca);
            p.setPublico(publico);
            produtos.add(p);
        }
        
        stmt.close();
        conectando.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        
        return produtos;
    }
    
    //CREATE
    public static boolean InserirProduto(Produto produto){
        
        boolean sucesso = false;
        
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        Connection c = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        PreparedStatement stmt = c.prepareStatement(INSERT_SQL);
        
            stmt.setInt(1, produto.getId_produto());
            stmt.setString(2, produto.getNome());
            stmt.setString(3, produto.getCategoria());
            stmt.setString(4, produto.getMarca());
            stmt.setString(5, produto.getPublico());
        
         int rowsAffect = stmt.executeUpdate();
         
            if (rowsAffect > 0) {
                sucesso = true;
            }
         
        stmt.close();
        c.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        return sucesso;
 }
    
    //UPDATE
    public static boolean AtualizarProduto(Produto produto){
        boolean sucesso = false;
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection c = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        
        
        PreparedStatement stmt = c.prepareStatement(UPDATE_SQL);
        
        stmt.setString(1, produto.getNome());
        stmt.setString(2, produto.getCategoria());
        stmt.setString(3, produto.getMarca());
        stmt.setString(4, produto.getPublico());
        stmt.setInt(5, produto.getId_produto());
        
         int rowsAffect = stmt.executeUpdate();
         
            if (rowsAffect > 0) {
                sucesso = true;
            }
         
        stmt.close();
        c.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        
        return sucesso;
    }
    
    //DELETE
    public static boolean DeletarProduto(Produto produto){
        boolean sucesso = false;
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection c = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        
        PreparedStatement stmt = c.prepareStatement(DELETE_SQL);
        stmt.setInt(1, produto.getId_produto());
        
         int rowsAffect = stmt.executeUpdate();
         
            if (rowsAffect > 0) {
                sucesso = true;
            }
         
        stmt.close();
        c.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        
        return sucesso;
        
    }
}

    

