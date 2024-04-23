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
<div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table id="tutorialesTable" class="table table-bordered table-dark">
            <thead>
            
            <div class="input-group mb-3">
                <div class="form-outline" data-mdb-input-init>
                    <input id="search-focus" type="search" id="form1" class="form-control" 
                           placeholder="Buscar por titulo" />
                </div>

                <div class="input-group-append" style="margin-left: 10px;">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categor�as
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="padding: 10px;">
                        <li><a class="dropdown-item" href="#" data-categoria="0">Todas las Categor�as</a></li>
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
                        <li><a class="dropdown-item" href="#" data-categoria="<%= idCategoria%>"><%= categoria%></a></li>
                            <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                    </ul>
                </div>
            </div>


            <tr>
                <th>ID</th>
                <th>Titulo</th>
                <th>Prioridad</th>
                <th>Ver</th>
                <th>Estado</th>
                <th>Categoria</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
                <%
                    try {

                        // Obtener la conexi�n a la base de datos
                        gestionarTutoriales gestionar = new gestionarTutoriales();
                        conn = gestionar.establecerConexion();

                        // Crear una declaraci�n para la consulta
                        String sql = "SELECT idTutorial, titulo, prioridad, url, estado, categoria "
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
                            String estado = rs.getString("estado");
                            String categoria = rs.getString("categoria");
                %>
                <tr>
                    <td><%= idTutorial%></td>
                    <td><%= titulo%></td>
                    <td><%= prioridad%></td>
                    <td><a href="<%= url%>" target="_blank"><i class="fas fa-eye"></i></a></td>
                    <td><%= estado%></td>
                    <td><%= categoria%></td>
                    <td>
                        
                        <div class="btn-group" role="group" aria-label="Acciones">
                            <!-- Bot�n de edici�n -->
                            <a href="#" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editModal" title="Editar"
                               data-id="<%= idTutorial%>"
                               data-titulo="<%= titulo%>"
                               data-prioridad="<%= prioridad%>"
                               data-url="<%= url%>"
                               data-estado="<%= estado%>"
                               data-categoria="<%= categoria%>">
                                <i class="fas fa-edit"></i> 
                            </a>
                             <!-- Bot�n de borrado -->
                            <a href="#" title="Eliminar" class="btn btn-danger btn-sm" onclick="confirmarEliminacion(<%= idTutorial%>)">
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

<!-- Script de filtrado de b�squeda -->
<script>
    $(document).ready(function () {
        // Manejar el evento de entrada en la caja de b�squeda
        $('#search-focus').on('input', function () {
            var searchTerm = $(this).val().toLowerCase();

            // Filtrar las filas de la tabla bas�ndonos en el t�rmino de b�squeda
            $('tbody tr').each(function () {
                var titulo = $(this).find('td:eq(1)').text().toLowerCase(); // Correcci�n aqu�

                // Mostrar u ocultar la fila seg�n si coincide con el t�rmino de b�squeda
                if (titulo.includes(searchTerm)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    });
</script>

<script>
    $(document).ready(function () {
        // Manejar el cambio de opci�n en el select de categor�a
        $('#categoriaSelect').on('change', function () {
            var categoriaId = $(this).val();

            // Mostrar todas las filas si la opci�n seleccionada es 0 (Todas las Categor�as)
            if (categoriaId === '0') {
                $('tbody tr').show();
                return;
            }

            // Filtrar las filas de la tabla bas�ndonos en la categor�a seleccionada
            $('tbody tr').each(function () {
                var categoria = $(this).find('td:eq(5)').text(); // Cambiar el �ndice seg�n la posici�n de la columna de categor�a
                if (categoria !== categoriaId) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        });
    });
</script>


<%@include file= "templates/scriptModales.jsp" %>
<%@include file= "templates/footer.jsp" %>
