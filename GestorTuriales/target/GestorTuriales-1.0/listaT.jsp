<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>

<%@page import="umariana.gestorturiales.gestionarTutoriales"%>

<%@include file= "templates/header.jsp" %>

<div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table class="table table-bordered table-dark">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Prioridad</th>
                    <th>URL</th>
                    <th>Estado</th>
                    <th>Categoria</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Declarar las variables fuera del bloque try
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        // Obtener la conexión a la base de datos
                        gestionarTutoriales gestionar = new gestionarTutoriales();
                        conn = gestionar.establecerConexion();
                        
                        // Crear una declaración para la consulta
                        String sql = "SELECT idTutorial, titulo, prioridad, url, estado, categoria " +
                                     "FROM tutoriales " +
                                     "INNER JOIN categorias ON tutoriales.idCategoria = categorias.idCategoria";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                
                        // Iterar sobre el conjunto de resultados y mostrar cada fila en la tabla
                        while (rs.next()) {
                            int idTutorial = rs.getInt("idTutorial");
                            String titulo = rs.getString("titulo");
                            int prioridad = rs.getInt("prioridad");
                            String url = rs.getString("url");
                            String estado = rs.getString("estado");
                            String categoria = rs.getString("categoria");
                %>
                <tr>
                    <td><%= idTutorial %></td>
                    <td><%= titulo %></td>
                    <td><%= prioridad %></td>
                    <td><a href="<%= url %>"><%= url %></a></td>
                    <td><%= estado %></td>
                    <td><%= categoria %></td>
                </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Cerrar recursos
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>


    </div>
</div>


<%@include file= "templates/footer.jsp" %>
