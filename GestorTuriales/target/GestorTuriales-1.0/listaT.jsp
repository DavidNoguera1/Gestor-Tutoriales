
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>

<%@page import="umariana.gestorturiales.gestionarTutoriales"%>

<%@include file= "templates/header.jsp" %>

<%
    // Obtener la conexión a la base de datos y crear una declaración para la consulta
    gestionarTutoriales gestionar = new gestionarTutoriales();
    Connection conn = gestionar.establecerConexion();
    PreparedStatement stmt = null;
    ResultSet rs = null;

%>

<div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table class="table table-bordered table-dark">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Prioridad</th>
                    <th>URL</th>
                    <th>Categoria</th>
                </tr>
            </thead>
            <tbody>
                <%      try {
                        conn = gestionar.establecerConexion();
                        String sql = "SELECT idTutorial, titulo, prioridad, url, categoria "
                                + "FROM tutoriales "
                                + "INNER JOIN categorias ON tutoriales.idCategoria = categorias.idCategoria";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        // Iterar sobre el conjunto de resultados y mostrar cada fila en la tabla
                        while (rs.next()) {
                            int idTutorial = rs.getInt("idTutorial");
                            String titulo = rs.getString("titulo");
                            int prioridad = rs.getInt("prioridad");
                            String url = rs.getString("url");
                            String categoria = rs.getString("categoria");
                %>
                <tr>
                    <td><%= idTutorial%></td>
                    <td><%= titulo%></td>
                    <td><%= prioridad%></td>
                    <td><a href="<%= url%>"><%= url%></a></td>
                    <td><%= categoria%></td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Cerrar recursos
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                            if (stmt != null) {
                                stmt.close();
                            }
                            if (conn != null) {
                                conn.close();
                            }
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
