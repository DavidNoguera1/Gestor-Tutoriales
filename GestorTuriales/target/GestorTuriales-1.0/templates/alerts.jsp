

<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    Se a�adi� el tutorial con �xito.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>


<%
    String deleteSuccess = request.getParameter("deleteSuccess");
    if ("true".equals(deleteSuccess)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Se elimin� el tutorial con �xito.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>


<%
    String editSuccess = request.getParameter("editSuccess");
    if ("true".equals(editSuccess)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Se edit� la informacion tutorial con �xito.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>


<%
    String editSuccessParam = request.getParameter("editSuccessC");
    if ("true".equals(editSuccessParam)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        Se edit� la categor�a con �xito.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>

<%
    String deleteSuccessParam = request.getParameter("deleteSuccessC");
    if ("true".equals(deleteSuccessParam)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        La categor�a se elimin� con �xito.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>

<%
    String successC = request.getParameter("successC");
    if ("true".equals(successC)) {
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    La categoria fue a�adida �xito.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>