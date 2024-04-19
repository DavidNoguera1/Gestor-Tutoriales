<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>
<%@page import="umariana.gestorturiales.gestionarTutoriales"%>

<%@include file= "templates/header.jsp" %>

<%
// Declarar las variables fuera del bloque try
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<div class="container d-flex justify-content-center align-items-center mt-4">
    <!-- Formulario para agregar categorías nuevas -->
    <div class="card bg-dark text-light p-3 mx-3">
        <h3 class="text-center mb-3">¿La categoría que buscas no está? ¡Créala!</h3>
        <form action="${pageContext.request.contextPath}/SvCategoria" method="POST">
            <div class="mb-3">
                <label for="nuevaCategoria" class="form-label text-light">Nueva Categoría</label>
                <input type="text" name="nuevaCategoria" class="form-control" id="nuevaCategoria">
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Agregar</button>
            </div>
        </form>
    </div>
</div>

<div class="container p-4 d-flex justify-content-center" style="max-height: 70vh; overflow-y: auto;">
    <div class="col-md-8">
        <table id="categoriasTable" class="table table-bordered table-dark table-sm text-center">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Categoría</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    gestionarTutoriales gestionar = new gestionarTutoriales();
                    conn = gestionar.establecerConexion();
                    String sql = "SELECT idCategoria, categoria FROM categorias";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        int idCategoria = rs.getInt("idCategoria");
                        String categoria = rs.getString("categoria");
                %>
                <tr>
                    <td><%= idCategoria %></td>
                    <td><%= categoria %></td>
                    <td>
                        <!-- Botón de edición -->
                        <a href="#" class="btn btn-success btn-sm" title="Editar">
                            <i class="fas fa-edit"></i> 
                        </a>
                        <!-- Botón de eliminación -->
                        <a href="#" class="btn btn-danger btn-sm" title="Eliminar">
                            <i class="fas fa-trash"></i> 
                        </a>
                    </td>
                </tr>
                <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<%@include file= "templates/footer.jsp" %>
