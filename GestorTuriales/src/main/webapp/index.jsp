<%-- 
    Document   : index
    Created on : 12/04/2024, 8:00:41?a.?m.
    Author     : Sistemas
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>
<%@page import="umariana.gestorturiales.gestionarTutoriales"%>

<%@include file= "templates/header.jsp" %>

<div class="container text-center py-5">
    <h2 class="mb-3">Explora nuestros <a href="listaT.jsp">tutoriales</a></h2>
    <p class="lead">Descubre una amplia variedad de tutoriales en diferentes categorías. ¡Aprende y mejora tus habilidades!</p>
</div>

<div class="container d-flex justify-content-center align-items-center py-5">
    <div class="card bg-dark text-light p-3">
        <h1 class="text-center">Formulario para agregar tutoriales</h1>
        <form action="${pageContext.request.contextPath}/SvAgregarTutorial" method="POST">
            <div class="mb-3">
                <label for="titulo" class="form-label text-light">Título</label>
                <input type="text" name="titulo" class="form-control" id="titulo" required>
            </div>
            <div class="mb-3">
                <label for="prioridad" class="form-label text-light">Prioridad</label>
                <select name="prioridad" class="form-select" id="prioridad">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="url" class="form-label text-light">URL</label>
                <input type="text" name="url" class="form-control" id="url" required>
            </div>
            <div class="mb-3">
                <label for="categoria" class="form-label text-light">Categoría</label>
                <select name="categoria" class="form-select" id="categoria">
                    <%
                            gestionarTutoriales gestionar = new gestionarTutoriales();
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                        
                        try {
                            
                            
                            conn = gestionar.establecerConexion();

                            String sql = "SELECT idCategoria, categoria FROM categorias";
                            stmt = conn.prepareStatement(sql);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                                int idCategoria = rs.getInt("idCategoria");
                                String categoria = rs.getString("categoria");
                    %>
                    <option value="<%= idCategoria%>"><%= categoria%></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Agregar</button>
                <a text-align: center href="categorias.jsp">¿La categorías que buscas no esta? ¡Agregala! </a>
            </div>
        </form>
    </div>
</div>

<%@include file= "templates/footer.jsp" %>