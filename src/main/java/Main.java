import bancodedados.Log;
import dao.LogDAO;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Log> logs = LogDAO.BuscarLog();
        GerarPdf.gerarPdf(logs);
        
    }
    
    
}
