<%-- 
    Document   : index
    Created on : 11/10/2025, 12:47:02 a. m.
    Author     : jruiz
--%>

<%@ page import="java.util.List" %>
<%! 
    public void mostrarSubmodulos(Menu menu, JspWriter out, String indent) throws java.io.IOException {
        for (Menu hijo : menu.getHijos()) {
            out.println(indent + "<a href='" + hijo.getUrl() + "' class='btn btn-link btn-sm d-block mb-1'>");
            out.println(indent + "<i class='fas fa-angle-right'></i> " + hijo.getNombre() + "</a>");
            if (!hijo.getHijos().isEmpty()) {
                mostrarSubmodulos(hijo, out, indent + "&nbsp;&nbsp;&nbsp;");
            }
        }
    }
%>


<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.MenuDAO, modelo.Menu" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    if (usuario == null || (!"admin".equals(rol) && !"empleado".equals(rol))) {
        response.sendRedirect("views/login.jsp?error=acceso");
        return;
    }

    MenuDAO dao = new MenuDAO();
    List<Menu> modulos = dao.obtenerMenuCompleto();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal | Supermercado</title>

    <!-- Estilos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .brand-link {
            background-color: #001f3f !important;
            color: #fff !important;
            font-weight: bold;
            text-align: center;
            letter-spacing: 1px;
        }
        .navbar {
            background-color: #f8f9fa;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card {
            border-radius: 10px;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 4px 10px rgba(0,0,0,0.15);
        }
        .card-body i {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .main-footer {
            background: #001f3f;
            color: white;
            font-size: 14px;
        }
        .main-footer a {
            color: #00aaff;
        }
        .nav-sidebar .nav-link.active {
            background-color: #007bff !important;
            color: #fff !important;
        }
        .content-header h1 {
            font-weight: 600;
            color: #333;
        }
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Navbar superior -->
    <nav class="main-header navbar navbar-expand navbar-light border-bottom">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars text-primary"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="#" class="nav-link font-weight-bold text-dark">Supermercado</a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item d-flex align-items-center pr-3">
                <i class="fas fa-user-circle text-primary mr-2"></i>
                <span class="text-dark">Bienvenido, <strong><%= usuario %></strong></span>
            </li>
        </ul>
    </nav>

    <!-- Menú lateral -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <a href="#" class="brand-link">
            <i class="fas fa-store-alt"></i> <span class="ml-2">Panel Admin</span>
        </a>

        <div class="sidebar">
            <nav class="mt-3">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item">
                        <a href="index.jsp" class="nav-link active">
                            <i class="nav-icon fas fa-home"></i>
                            <p>Inicio</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="configuracion.jsp" class="nav-link">
                            <i class="nav-icon fas fa-cog"></i>
                            <p>Configuración</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%= request.getContextPath() %>/CerrarSesionServlet" class="nav-link">
                            <i class="nav-icon fas fa-sign-out-alt"></i>
                            <p>Cerrar Sesión</p>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </aside>

    <!-- Contenido principal -->
    <div class="content-wrapper">
        <section class="content-header text-center pt-4">
            <h1>Panel de Control</h1>
            <p class="text-muted">Selecciona un módulo para comenzar</p>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <% for (Menu m : modulos) {
                        String color = "primary";
                        if (m.getNombre().equalsIgnoreCase("Ventas")) color = "success";
                        else if (m.getNombre().equalsIgnoreCase("Compras")) color = "warning";
                        else if (m.getNombre().equalsIgnoreCase("Reportes")) color = "danger";
                    %>
                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card text-center shadow-sm border-<%= color %>">
                            <div class="card-body">
                                <i class="fas fa-folder-open text-<%= color %>"></i>
                                <h5 class="mt-3"><%= m.getNombre() %></h5>
                                <a href="<%= m.getUrl() %>" class="btn btn-outline-<%= color %> btn-sm mt-2">Ir al módulo</a>

                                <% if (!m.getHijos().isEmpty()) { %>
                                    <button class="btn btn-link btn-sm mt-2" data-toggle="collapse" data-target="#submodulo<%= m.getId() %>">
                                        <i class="fas fa-angle-down"></i> Ver submódulos
                                    </button>
                                    <div class="collapse mt-2" id="submodulo<%= m.getId() %>">
                                        <% for (Menu hijo : m.getHijos()) { %>
                                            <a href="<%= hijo.getUrl() %>" class="btn btn-outline-secondary btn-sm d-block mb-1">
                                                <i class="fas fa-angle-right"></i> <%= hijo.getNombre() %>
                                            </a>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="main-footer text-center py-2">
        <strong>&copy; 2025 <a href="#">Supermercado</a>.</strong> Todos los derechos reservados.
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 1.0</div>
    </footer>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>
</body>
</html>
