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
                    <th>Acciones</th>
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
                    <td>
                        <a href="<%= url %>" class="text-decoration-none">
                            <i class="fas fa-eye text-primary me-1"></i> 
                        </a>
                    </td>

                    <td><%= estado %></td>
                    <td><%= categoria %></td>
                    <td>
                        <!-- Botones -->
                        <div class="btn-group" role="group" aria-label="Acciones">

                            <!-- Botón de edición -->
                            <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editModal" title="Editar"
                               data-id="<%= idTutorial %>"
                               data-titulo="<%= titulo %>"
                               data-prioridad="<%= prioridad %>"
                               data-url="<%= url %>"
                               data-estado="<%= estado %>"
                               data-categoria="<%= categoria %>">
                                <i class="fas fa-edit"></i>
                            </a>



                            <!-- Botón de borrado -->    
                            <a href="#" title="Eliminar" class="btn btn-danger" onclick="confirmarEliminacion(<%= idTutorial %>)">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </td>
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


<script>
    function confirmarEliminacion(idTutorial) {
        var confirmacion = confirm("¿Está seguro de que desea borrar este tutorial?");
        if (confirmacion) {
            window.location.href = "SvAgregarTutorial?idTutorial=" + idTutorial;
        } else {
            alert("Eliminación cancelada.");
        }
    }
</script>


<!-- Ventana Modal para Edición de Tutorial -->
<div class="modal fade modal-dark" id="editModal" tabindex="-1" aria-labelledby="editModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edición de Tutorial</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvEditarTutorial" method="POST">
                    <div class="mb-3">
                        <label for="id" class="col-form-label">ID:</label>
                        <input type="text" class="form-control" id="id" name="id" placeholder="ID del tutorial" readonly required>
                    </div>
                    <div class="mb-3">
                        <label for="titulo" class="col-form-label">Título:</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Título del tutorial" required>
                    </div>
                    <div class="mb-3">
                        <label for="prioridad" class="col-form-label">Prioridad:</label>
                        <input type="number" class="form-control" id="prioridad" name="prioridad" placeholder="Prioridad del tutorial" required>
                    </div>
                    <div class="mb-3">
                        <label for="url" class="col-form-label">URL:</label>
                        <input type="text" class="form-control" id="url" name="url" placeholder="URL del tutorial" required>
                    </div>
                    <div class="mb-3">
                        <label for="estado" class="col-form-label">Estado:</label>
                        <select class="form-select" id="estado" name="estado" required>
                            <option value="Revisado">Revisado</option>
                            <option value="Por revisar">Por revisar</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="categoria" class="col-form-label">Categoría:</label>
                        <input type="text" class="form-control" id="categoria" name="categoria" placeholder="Categoría del tutorial" required>
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

<!-- Script para obtener los datos del tutorial y mostrarlos en la modal -->
<script>
    $('#editModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idTutorial = button.data('id');
        var titulo = button.data('titulo');
        var prioridad = button.data('prioridad');
        var url = button.data('url');
        var estado = button.data('estado');
        var categoria = button.data('categoria');

        // Establecer valores en los campos del formulario
        var modal = $(this);
        modal.find('#id').val(idTutorial);
        modal.find('#titulo').val(titulo);
        modal.find('#prioridad').val(prioridad);
        modal.find('#url').val(url);
        modal.find('#estado').val(estado);
        modal.find('#categoria').val(categoria);
    });
</script>

<script>
    // Imprimir los datos del botón en la consola
    $(document).ready(function () {
        $('.btn-success').click(function () {
            console.log("ID: " + $(this).data('id'));
            console.log("Título: " + $(this).data('titulo'));
            console.log("Prioridad: " + $(this).data('prioridad'));
            console.log("URL: " + $(this).data('url'));
            console.log("Estado: " + $(this).data('estado'));
            console.log("Categoría: " + $(this).data('categoria'));
        });
    });
</script>



<%@include file= "templates/footer.jsp" %>
