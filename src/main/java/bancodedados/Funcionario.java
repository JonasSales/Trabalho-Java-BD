
package bancodedados;


public class Funcionario extends Usuario{
    protected String cargo;
    protected int idPatrao;

    public int getIdPatrao() {
        return idPatrao;
    }

    public void setIdPatrao(int idPatrao) {
        this.idPatrao = idPatrao;
    }
    protected double salario;

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }
    
}
