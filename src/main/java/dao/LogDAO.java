package dao;

import bancodedados.Log;
import bancodedados.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import org.postgresql.Driver;

public class LogDAO {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres"; // nome do seu banco
    private static final String USUARIO = "postgres"; // seu usuário
    private static final String SENHA = "1234";
    private static final String SELECT_SQL = "select * from vw_tabela_log;";
    
    private static final String  INSERTLOG=  "select registrar_log(? ,? , CURRENT_DATE ,CURRENT_TIME::TIME, ?, ?)";

    public static void main(String[] args) {

    }

    public static ArrayList BuscarLog() {
        ArrayList<Log> logs = new ArrayList();

        try {

            Driver driver = new Driver();
            DriverManager.registerDriver(driver);

            Connection conectando = (Connection) DriverManager.getConnection(URL, USUARIO, SENHA);

            PreparedStatement stmt = conectando.prepareStatement(SELECT_SQL);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String data = rs.getString("data");
                String horario = rs.getString("horario");
                String acao = rs.getString("acao");
                String tabela = rs.getString("tabela");
                int id_usuario = rs.getInt("id_usuario");
                String tipoUsuario = rs.getString("tipo_usuario");

                Log p = new Log();

                p.setData(data);
                p.setHora(horario);
                p.setAcao(acao);
                p.setTabela(tabela);
                p.setId_usuario(id_usuario);
                p.setTipoUsuario(tipoUsuario);

                logs.add(p);
            }

            stmt.close();
            conectando.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return logs;
    }

    public static boolean inserirLog(Usuario usuario, String acao, String tabela) {
        boolean inserir = false;
        try {
        Driver driver = new Driver();
        DriverManager.registerDriver(driver);
        Connection conectando = (Connection) DriverManager.getConnection(URL,USUARIO,SENHA);
        PreparedStatement stmt = conectando.prepareStatement(INSERTLOG);
        //SELECT registrar_log('insert','USUARIOS',CURRENT_DATE,CURRENT_TIME::TIME,1,'admin');
        stmt.setString(1, acao);        
        stmt.setString(2, tabela);  
        stmt.setInt(3, usuario.getId());       
        stmt.setString(4, usuario.getTipodeUsuario());        
        
        
            if (stmt.execute()) {
                inserir = true;
            }   
            
        stmt.close();
        conectando.close();
    } catch(SQLException e){
        e.printStackTrace();
    }
        return inserir;
    }

}
