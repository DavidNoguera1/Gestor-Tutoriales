<%-- 
    Document   : scriptModales
    Created on : 17/04/2024, 8:26:20?a.?m.
    Author     : Sistemas
--%>

<script>
    function confirmarEliminacion(idTutorial) {
        var confirmacion = confirm("�Est� seguro de que desea borrar este tutorial?");
        if (confirmacion) {
            window.location.href = "SvAgregarTutorial?idTutorial=" + idTutorial;
        } else {
            alert("Eliminaci�n cancelada.");
        }
    }
</script>


<!-- Ventana Modal para Edici�n de Tutorial -->
<div class="modal fade modal-dark" id="editModal" tabindex="-1" aria-labelledby="editModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edici�n de Tutorial</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvEditarTutorial" method="POST">
                    <div class="mb-3">
                        <label for="id" class="col-form-label">ID:</label>
                        <input type="text" class="form-control" id="id" name="id" placeholder="ID del tutorial" readonly required>
                    </div>
                    <div class="mb-3">
                        <label for="titulo" class="col-form-label">T�tulo:</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" placeholder="T�tulo del tutorial" required>
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
                        <label for="categoria" class="col-form-label">Categor�a:</label>
                        <input type="text" class="form-control" id="categoria" name="categoria" placeholder="Categor�a del tutorial" required>
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
    // Imprimir los datos del bot�n en la consola
    $(document).ready(function () {
        $('.btn-success').click(function () {
            console.log("ID: " + $(this).data('id'));
            console.log("T�tulo: " + $(this).data('titulo'));
            console.log("Prioridad: " + $(this).data('prioridad'));
            console.log("URL: " + $(this).data('url'));
            console.log("Estado: " + $(this).data('estado'));
            console.log("Categor�a: " + $(this).data('categoria'));
        });
    });
</script>