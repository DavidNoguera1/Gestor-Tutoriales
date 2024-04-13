<%-- 
    Document   : index
    Created on : 12/04/2024, 8:00:41?a.?m.
    Author     : Sistemas
--%>

<%@include file= "templates/header.jsp" %>


<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card bg-dark text-light p-3">
        <h1 class="text-center">Formulario para agregar tutoriales</h1>
        <form action="SvAgregarTutorial" method="POST">
            <div class="form-group">
                <label for="titulo" class="text-light">Título</label>
                <input type="text" name="titulo" class="form-control" id="titulo">
            </div>
            <div class="form-group">
                <label for="prioridad" class="text-light">Prioridad</label>
                <select name="prioridad" class="form-control" id="prioridad">
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
            <div class="form-group">
                <label for="url" class="text-light">URL</label>
                <input type="text" name="url" class="form-control" id="url">
            </div>
            <div class="form-group">
                <label for="categoria" class="text-light">Categoría</label>
                <select name="categoria" class="form-control" id="categoria">
                    <option value="1">Logica de programacion</option>
                    <option value="2">Flutter</option>
                    <option value="3">Node.js</option>
                    <option value="4">Java</option>
                    <option value="5">Python</option>
                    <option value="6">MySQL</option>
                </select>
            </div>
            <div class="text-center">
                <input type="submit" value="Agregar" class="btn btn-primary">
            </div>
        </form>

    </div>
</div>

<%@include file= "templates/footer.jsp" %>