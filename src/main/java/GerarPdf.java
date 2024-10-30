import bancodedados.Log;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.util.ArrayList;

public class GerarPdf {

    public static void gerarPdf(ArrayList<Log> logs) {
        Document document = new Document();
        
        try {
            // Definindo o caminho do arquivo de saída
            String outputPath = "C:\\Users\\jocin\\OneDrive\\Documentos\\NetBeansProjects\\Trabalho-bd\\Trabalho-Java-BD\\src\\main\\webapp\\output.pdf";
            PdfWriter.getInstance(document, new FileOutputStream(outputPath));
            document.open();

            // Criando um título para o relatório
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
            Paragraph title = new Paragraph("Relatório de Logs\n\n", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Criando a tabela com 6 colunas
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            // Adicionando os cabeçalhos das colunas
            String[] headers = {"DATA", "HORA", "AÇÃO", "TABELA", "ID DE QUEM ALTEROU", "TIPO DO USUÁRIO"};
            for (String header : headers) {
                table.addCell(header);
            }

            // Preenchendo a tabela com os dados de log
            for (Log u : logs) {
                table.addCell(u.getData());
                table.addCell(u.getHora());
                table.addCell(u.getAcao());
                table.addCell(u.getTabela());
                table.addCell(String.valueOf(u.getId_usuario()));
                table.addCell(u.getTipoUsuario());
            }

            document.add(table);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            document.close();
        }
    }
}
