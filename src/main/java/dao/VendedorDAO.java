package dao;

import bancodedados.Vendedor;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import org.postgresql.Driver;
 
public class VendedorDAO {
    
    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";
    
    private static final String SELECT_SQL = "SELECT * FROM vendedor order by id_vendedor";
    private static final String SELECT_INDIVIDUAL_SQL = "select * from vw_vendedor where email = ?";
    private static final String UPDATE_SQL = "UPDATE vendedor SET cnpj = ?, cidade = ?, estado = ?  WHERE id_vendedor = ?";
    private static final String DELETE_SQL = "delete from vendedor WHERE id_vendedor = ?";
    
    public static void main(String[] args){
        
    }
    
    public static Vendedor BuscarVendedor(int idVendedor){
    Vendedor clt = new Vendedor();
        try {
    
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection conectando = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        
        PreparedStatement stmt = conectando.prepareStatement(SELECT_INDIVIDUAL_SQL);
        
        stmt.setInt(1, idVendedor);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            int id = rs.getInt("id_vendedor");
            String cnpj = rs.getString("cnpj");
            String cidade = rs.getString("cidade");
            String estado = rs.getString("estado");
            clt.setId(id);
            clt.setCnpj(cnpj); 
            clt.setCidade(cidade); 
            clt.setEstado(estado); 
        }
        stmt.close();
        conectando.close();   
    } catch(SQLException e){
        e.printStackTrace();
    }
        return clt;
    }
    
    
    public static ArrayList BuscarFuncionarios(){
        ArrayList<Vendedor> vendedores = new ArrayList();
        try {
    
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection conectando = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);
        
        ResultSet rs = stmt.executeQuery();
        
        
        while(rs.next()){
            int id = rs.getInt("id_vendedor");
            String cnpj = rs.getString("cnpj");
            String cidade = rs.getString("cidade");
            String estado = rs.getString("estado");
            
            Vendedor vendedor = new Vendedor();
            
            vendedor.setId(id);
            vendedor.setCnpj(cnpj);
            vendedor.setCidade(cidade);
            vendedor.setEstado(estado);
            
            vendedores.add(vendedor);
        }
        stmt.close();
        conectando.close();
        
        
    } catch(SQLException e){
        e.printStackTrace();
    }
        return vendedores;
    }
    
    //UPDATE
    public static boolean AtualizarVendedor(Vendedor vendedor){
        boolean sucesso = false;
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection c = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
            
        PreparedStatement stmt = c.prepareStatement(UPDATE_SQL);
        
        stmt.setString(1, vendedor.getCnpj());
        stmt.setString(2, vendedor.getCidade());
        stmt.setString(3, vendedor.getEstado());
        stmt.setInt(4, vendedor.getId());
        
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
    public static boolean DeletarFuncionario(Vendedor vendedor){
        boolean sucesso = false;
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        
        Connection c = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        
        PreparedStatement stmt = c.prepareStatement(DELETE_SQL);
        stmt.setInt(1, vendedor.getId());
        
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
    
    public static Vendedor BuscarVendedorPorEmail(String email) {
        Vendedor u = new Vendedor();
        try {
            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECT_INDIVIDUAL_SQL);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id_vendedor");
                String nome = rs.getString("nome");
                String cpf = rs.getString("cpf");
                String cnpj = rs.getString("cnpj");
                String estado = rs.getString("estado");
                String cidade = rs.getString("cidade");
                String tipousuario = rs.getString("tipousuario");
                u.setId(id);
                u.setNome(nome);
                u.setEmail(email);
                u.setTipodeUsuario(tipousuario);
                u.setCpf(cpf);
                u.setCidade(cidade);
                u.setEstado(estado);
                u.setCnpj(cnpj);
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    
}

    

