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
 * @author PC
 */
@WebServlet(name = "SvEditar", urlPatterns = {"/SvEditar"})
public class SvEditar extends HttpServlet {

   gestionarTutoriales gestionar = new gestionarTutoriales();
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String titulo = request.getParameter("titulo");
        int prioridad = Integer.parseInt(request.getParameter("prioridad"));
        String url = request.getParameter("url");
        int categoria = Integer.parseInt(request.getParameter("categoria"));
        int idTutorial = Integer.parseInt(request.getParameter("id"));

        try {
            gestionar.editarTutorial(idTutorial, titulo, prioridad, url, categoria);
            // Redirigir a la página de éxito o mostrar un mensaje de éxito
            
            response.sendRedirect(request.getContextPath() + "/listaT.jsp");

            System.out.println("Tutorial editado exitosamente.");
            
        } catch (SQLException e) {
            
            // Manejar cualquier error de SQL
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al editar el tutorial. Por favor, inténtelo de nuevo."); // Esto mostrará un mensaje de error en la página
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
