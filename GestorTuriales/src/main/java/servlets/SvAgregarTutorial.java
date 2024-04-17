/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import umariana.gestorturiales.gestionarTutoriales;

/**
 *
 * @author Sistemas
 */
@WebServlet(name = "SvAgregarTutorial", urlPatterns = {"/SvAgregarTutorial"})
public class SvAgregarTutorial extends HttpServlet {

    gestionarTutoriales gestionar = new gestionarTutoriales();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Establecer la conexión a la base de datos
        Connection conn = gestionar.establecerConexion();

        if (conn != null) {
            try {
                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call eliminarTutorial(?)}");

                // Obtener el parámetro de la URL (método GET)
                int idTutorial = Integer.parseInt(request.getParameter("idTutorial"));

                // Establecer parámetros del procedimiento almacenado
                stmt.setInt(1, idTutorial);

                // Ejecutar el procedimiento almacenado
                stmt.execute();

                // Cerrar la conexión
                conn.close();

                // Redirigir a alguna página de éxito o mostrar un mensaje de éxito
                response.sendRedirect("listaT.jsp"); // Redirigir a una página de éxito

                System.out.println("Tutorial eliminado exitosamente.");
            } catch (SQLException e) {
                // Manejar cualquier error de SQL
                e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
                // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
                response.getWriter().println("Error al eliminar el tutorial. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
            }
        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Establecer la conexión a la base de datos
        Connection conn = gestionar.establecerConexion();

        if (conn != null) {
            try {
                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call InsertarTutorial(?, ?, ?, ?)}");

                // Obtener los parámetros del formulario
                String titulo = request.getParameter("titulo");
                int prioridad = Integer.parseInt(request.getParameter("prioridad"));
                String url = request.getParameter("url");
                int categoria = Integer.parseInt(request.getParameter("categoria"));

                // Establecer parámetros del procedimiento almacenado
                stmt.setString(1, titulo);
                stmt.setInt(2, prioridad);
                stmt.setString(3, url);
                stmt.setInt(4, categoria);

                // Ejecutar el procedimiento almacenado
                stmt.execute();

                // Cerrar la conexión
                conn.close();

                // Redirigir a alguna página de éxito o mostrar un mensaje de éxito
                response.sendRedirect("index.jsp"); // Redirigir a una página de éxito

                System.out.println("Conexion exitosa");
            } catch (SQLException e) {
                // Manejar cualquier error de SQL
                e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
                // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
                response.getWriter().println("Error al agregar pruebe de nuevo"); // Esto mostrará un mensaje de error en la página
            }
        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
