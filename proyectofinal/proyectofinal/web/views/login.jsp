<%-- 
    Document   : login
    Created on : 11/10/2025, 12:48:23 a. m.
    Author     : guich
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #007BFF, #00BFFF);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .login-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            padding: 40px 30px;
            width: 100%;
            max-width: 380px;
        }
        .login-card h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            color: #333;
        }
        .btn-login {
            background-color: #007BFF;
            border: none;
            transition: 0.3s;
        }
        .btn-login:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Iniciar Sesión</h2>
    <form action="../LoginServlet" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Usuario</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Ingresa tu usuario" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Ingresa tu contraseña" required>
        </div>
        <button type="submit" class="btn btn-login w-100 text-white">Entrar</button>
    </form>

    <% String error = request.getParameter("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <c:if test="${param.mensaje == 'logout'}">
        <div class="alert alert-info text-center mt-3">
            Sesión cerrada correctamente.
        </div>
    </c:if>
</div>

<
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
