<%-- 
    Document   : scriptModales
    Created on : 17/04/2024, 8:26:20?a.?m.
    Author     : Sistemas
    Esta pagina no visible almacena modales y scripts a empleaser en listasT.jsp 
--%>

<%@page import="umariana.gestorturiales.gestionarTutoriales"%>
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
                <form action="SvEditar" method="POST">
                    <div class="mb-3" hidden>
                        <label for="id" class="col-form-label">ID:</label>
                        <input type="text" class="form-control" id="id" name="id" placeholder="ID del tutorial" readonly required>
                    </div>
                    <div class="mb-3">
                        <label for="titulo" class="col-form-label">Título:</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Título del tutorial" required>
                    </div>
                    <div class="mb-3">
                        <label for="prioridad" class="col-form-label">Prioridad:</label>
                        <select class="form-select" id="prioridad" name="prioridad" required>
                            <!-- Opciones de prioridad -->
                            <% for (int i = 1; i <= 10; i++) { %>
                            <option value="<%= i %>"><%= i %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="url" class="col-form-label">URL:</label>
                        <input type="text" class="form-control" id="url" name="url" placeholder="URL del tutorial" required>
                    </div>
                    <div class="mb-3" hidden>
                        <label for="estado" class="col-form-label">Estado:</label>
                        <select class="form-select" id="estado" name="estado" required>
                            <!-- Opciones de estado -->
                            <option value="Revisado">Revisado</option>
                            <option value="Por revisar">Por revisar</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="categoria" class="col-form-label">Categoría:</label>
                        <select class="form-select" id="categoria" name="categoria" required>
                            <!-- Opciones de categoría -->
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
                            <option value="<%= idCategoria %>"><%= categoria %></option>
                            <% 
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            %>
                        </select>
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

        // Establecer la categoría actual como seleccionada
        modal.find('#categoria option').each(function () {
            if ($(this).text() === categoria) {
                $(this).prop('selected', true);
            }
        });
    });
</script>



