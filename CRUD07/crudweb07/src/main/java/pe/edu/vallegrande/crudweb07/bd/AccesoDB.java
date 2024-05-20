package pe.edu.vallegrande.crudweb07.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AccesoDB {
    // Método para obtener la conexión a la base de datos
    public static Connection getConnection() throws SQLException {
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String urlDB = "jdbc:sqlserver://localhost:14033;databaseName=db_graciela;encrypt=True;TrustServerCertificate=True;";
        String user = "sa";
        String pass = "deyton@123";

        try {
            // Paso 1: Cargar el driver a memoria
            Class.forName(driver);
            // Paso 2: Obtener el objeto Connection
            return DriverManager.getConnection(urlDB, user, pass);
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de la base de datos.");
        }
    }

    // Método main para probar la conexión
    public static void main(String[] args) {
        try {
            // Obtener la conexión a la base de datos
            Connection connection = AccesoDB.getConnection();

            // Si llegamos aquí sin lanzar una excepción, la conexión fue exitosa
            System.out.println("Conexión exitosa a la base de datos.");

            // Aquí puedes realizar cualquier otra operación con la conexión si lo deseas

            // Finalmente, cerramos la conexión
            connection.close();

        } catch (SQLException e) {
            // Si algo salió mal, mostramos el mensaje de error
            System.err.println("Error al conectar a la base de datos: " + e.getMessage());
        }
    }
}
