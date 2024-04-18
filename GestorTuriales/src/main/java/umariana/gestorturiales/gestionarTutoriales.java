/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package umariana.gestorturiales;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Sistemas
 */
public class gestionarTutoriales {

    public Connection establecerConexion() {
        String url = "jdbc:mysql://localhost:3306/gestor?serverTimeZone=utc";
        String user = "root"; // Nombre de usuario correcto
        String password = "admin"; // Contraseña de tu base de datos, si la tienes
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Conexion exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion" + e.getMessage());
        }
        return conn;
    }

    public void agregarTutorial(String titulo, int prioridad, String url, int categoria) throws SQLException {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = establecerConexion();
            if (conn != null) {
                stmt = conn.prepareCall("{call InsertarTutorial(?, ?, ?, ?)}");
                stmt.setString(1, titulo);
                stmt.setInt(2, prioridad);
                stmt.setString(3, url);
                stmt.setInt(4, categoria);
                stmt.execute();
            }
        } finally {
            // Cerrar recursos
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void eliminarTutorial(int idTutorial) throws SQLException {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = establecerConexion();
            if (conn != null) {
                stmt = conn.prepareCall("{call eliminarTutorial(?)}");
                stmt.setInt(1, idTutorial);
                stmt.execute();
            }
        } finally {
            // Cerrar recursos
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Función para editar un tutorial
    public void editarTutorial(int idTutorial, String titulo, int prioridad, String url, int categoria) throws SQLException {
        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = establecerConexion();
            if (conn != null) {
                stmt = conn.prepareCall("{call editarTutorial(?, ?, ?, ?, ?)}");
                stmt.setInt(1, idTutorial);
                stmt.setString(2, titulo);
                stmt.setInt(3, prioridad);
                stmt.setString(4, url);
                stmt.setInt(5, categoria);
                stmt.execute();
            }
        } finally {
            // Cerrar recursos
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
   
}
