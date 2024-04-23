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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el parámetro de la URL (método GET)
        int idTutorial = Integer.parseInt(request.getParameter("idTutorial"));

        try {
            // Llamar al método eliminarTutorial de la clase gestionarTutoriales
            gestionar.eliminarTutorial(idTutorial);

            // Redirigir a listaT.jsp después de eliminar el tutorial
            response.sendRedirect(request.getContextPath() + "/listaT.jsp?deleteSuccess=true");

            System.out.println("Tutorial eliminado exitosamente.");
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al eliminar el tutorial. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        int prioridad = Integer.parseInt(request.getParameter("prioridad"));
        String url = request.getParameter("url");
        int categoria = Integer.parseInt(request.getParameter("categoria"));

        try {
            // Llamar al método agregarTutorial de la clase gestionarTutoriales
            gestionar.agregarTutorial(titulo, prioridad, url, categoria);

            // Redirigir a listaT.jsp después de agregar el tutorial
            response.sendRedirect(request.getContextPath() + "/listaT.jsp?success=true");

            System.out.println("Tutorial agregado exitosamente.");
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al agregar el tutorial. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
