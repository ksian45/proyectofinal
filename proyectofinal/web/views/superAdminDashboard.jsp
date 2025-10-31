<%-- 
    Document   : superAdminDashboard
    Created on : 26/10/2025, 1:23:10 p. m.
    Author     : Jruiz
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String rol = (String) session.getAttribute("rol");
  if (!"super_admin".equals(rol)) {
    response.sendRedirect("ventas.jsp");
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Super Admin</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #007BFF, #00BFFF);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card {
            width: 100%;
            max-width: 440px;
            border: none;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background: #007BFF;
            color: white;
            text-align: center;
            font-weight: 600;
            font-size: 1.4rem;
            border-radius: 20px 20px 0 0;
            padding: 1rem;
        }

        .form-label {
            font-weight: 500;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-primary {
            background: linear-gradient(90deg, #007BFF, #00BFFF);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 10px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: scale(1.03);
            background: linear-gradient(90deg, #0056b3, #007BFF);
        }

        .icon-header {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .alert {
            width: 100%;
            max-width: 440px;
            margin: 15px auto 0;
            border-radius: 10px;
            font-weight: 500;
        }

    </style>
</head>
<body>

<div>
    <div class="card">
        <div class="card-header">
            <i class="bi bi-shield-lock icon-header"></i><br>
            Panel Super Admin
        </div>
        <div class="card-body p-4">
            <h5 class="text-center mb-4 text-primary fw-semibold">Crear nuevo usuario</h5>

            <form method="POST" action="${pageContext.request.contextPath}/CrearUsuarioServlet">
                <div class="mb-3">
                    <label for="username" class="form-label">
                        <i class="bi bi-person-fill me-2"></i>Usuario
                    </label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Ingrese el usuario" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="bi bi-lock-fill me-2"></i>Contraseña
                    </label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese la contraseña" required>
                </div>

                <div class="mb-3">
                    <label for="rol" class="form-label">
                        <i class="bi bi-people-fill me-2"></i>Rol del usuario
                    </label>
                    <select class="form-select" id="rol" name="rol" required>
                        <option value="">Seleccione un rol</option>
                        <option value="admin">Administrador</option>
                        <option value="empleado">Empleado</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-person-plus me-2"></i>Crear Usuario
                </button>
            </form>
        </div>
    </div>

   <c:if test="${param.mensaje == 'creado'}">
    <div class="alert alert-success text-center mt-3">
        Usuario creado exitosamente. Ahora puedes iniciar sesión.
    </div>
</c:if>


</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
