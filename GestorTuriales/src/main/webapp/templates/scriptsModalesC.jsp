<%-- 
    Document   : scriptModalesC
    Esta pagina no visible almacena modales y scripts a emplearce en categorias.jsp 
--%>

<script>
    function confirmarEliminacionCategoria(idCategoria) {
        var confirmacion = confirm("¿Está seguro de que desea borrar este categoria? (Se eliminaran tambien los tutoriales asociados con esta)");
        if (confirmacion) {
            window.location.href = "SvCategoria?idCategoria=" + idCategoria;
        } else {
            alert("Eliminación cancelada.");
        }
    }
</script>
