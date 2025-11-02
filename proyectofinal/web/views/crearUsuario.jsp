<%-- 
    Document   : crearUsuario
    Created on : 26/10/2025, 9:06:06 p. m.
    Author     : Jruiz
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow col-md-6 mx-auto">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">Crear nuevo usuario</h3>

                <form action="CrearUsuarioServlet" method="post">

                    <div class="mb-3">
                        <label class="form-label">Usuario:</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Contraseña:</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rol:</label>
                        <select name="rol" class="form-select" required>
                            <option value="">Seleccionar...</option>
                            <option value="admin">Admin</option>
                            <option value="empleado">Empleado</option>
                        </select>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Crear</button>
                        <a href="superAdminDashboard.jsp" class="btn btn-secondary">Cancelar</a>
                    </div>
                </form>

                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger mt-3 text-center">
                        Error: <%= error %>
                    </div>
                <% } %>

            </div>
        </div>
    </div>
</body>
</html>
