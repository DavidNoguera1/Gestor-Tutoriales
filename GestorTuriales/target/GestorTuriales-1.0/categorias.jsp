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
        <h3 class="text-center mb-3">Agrega la categoria que necesites y mira las existentes</h3>
        <form action="${pageContext.request.contextPath}/SvCategoria" method="POST">
            <div class="mb-3">
                <label for="nuevaCategoria" class="form-label text-light">Nueva Categoría:</label>
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
                        <!-- Botón de edición de categoría -->
                        <a href="#" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editCategoriaModal" title="Editar"
                           data-id="<%= idCategoria %>"
                           data-nombre="<%= categoria %>">
                            <i class="fas fa-edit"></i> 
                        </a>

                        <!-- Botón de eliminación -->
                        <a href="#" title="Eliminar" class="btn btn-danger btn-sm" onclick="confirmarEliminacionCategoria(<%= idCategoria%>)">
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


<!-- Ventana Modal para Edición de Categoría -->
<div class="modal fade modal-dark" id="editCategoriaModal" tabindex="-1" aria-labelledby="editCategoriaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title" id="editCategoriaModalLabel">Edición de Categoría, el nuevo nombre de categoria se actualizara en los tutoriales que lo hayan poseido anteriormente.</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/SvEditar" method="GET">
                    <div class="mb-3" hidden>
                        <label for="idCategoria" class="col-form-label">ID:</label>
                        <input type="text" class="form-control" id="idCategoria" name="idCategoria" readonly required>
                    </div>
                    <div class="mb-3">
                        <label for="nuevoNombre" class="col-form-label">Nombre de la Categoría:</label>
                        <input type="text" class="form-control" id="nombreCategoria" name="nuevoNombre" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    $('#editCategoriaModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idCategoria = button.data('id');
        var nombreCategoria = button.data('nombre');

        // Establecer valores en los campos del formulario
        var modal = $(this);
        modal.find('#idCategoria').val(idCategoria);
        modal.find('#nombreCategoria').val(nombreCategoria);
    });

</script>


<%@include file= "templates/scriptsModalesC.jsp" %>
<%@include file= "templates/footer.jsp" %>
