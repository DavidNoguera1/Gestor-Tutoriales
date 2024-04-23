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
@WebServlet(name = "SvCategoria", urlPatterns = {"/SvCategoria"})
public class SvCategoria extends HttpServlet {

    gestionarTutoriales gestionar = new gestionarTutoriales();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el parámetro de la URL (método GET)
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

        try {
            // Llamar al método eliminarTutorial de la clase gestionarTutoriales
            gestionar.eliminarCategoria(idCategoria);

            // Redirigir a listaT.jsp después de eliminar el tutorial
            response.sendRedirect(request.getContextPath() + "/categorias.jsp?deleteSuccessC=true");

            System.out.println("Categoria eliminado exitosamente.");
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al eliminar la categoria. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nuevaCategoria = request.getParameter("nuevaCategoria");

        try {
            // Llamar al método agregarCategoria de la clase gestionarTutoriales
            gestionar.agregarCategoria(nuevaCategoria);

            // Redirigir a donde desees después de agregar la categoría
            response.sendRedirect(request.getContextPath() + "/categorias.jsp?successC=true");

            System.out.println("Categoría agregada exitosamente.");
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al agregar la categoría. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
