package pe.edu.vallegrande.crudweb07.prueba;

import pe.edu.vallegrande.crudweb07.bd.AccesoDB;
import java.sql.Connection;
import java.sql.SQLException;


public class prueba3 {

    public static void main(String[] args) {
        try {
            Connection cn = AccesoDB.getConnection();
            System.out.println("¡Conexión exitosa!");
            cn.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }
}
