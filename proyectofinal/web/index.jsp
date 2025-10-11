<%-- 
    Document   : index
    Created on : 11/10/2025, 12:47:02 a. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">

    <style>
        .main-header { position: fixed; top: 0; left: 0; right: 0; z-index: 1030; width: 100%; }
        .main-footer { position: fixed; bottom: 0; left: 0; right: 0; z-index: 1030; padding-top: 10px; }
        .content-wrapper { padding-top: 57px; margin-bottom: 55px; }

        .sidebar > div > nav:first-of-type {
            flex-grow: 1;
        }

        .sidebar {
            display: flex;
            flex-direction: column;
            height: calc(100vh - 57px);
            overflow-y: auto;
        }

        .sidebar > nav:last-of-type {
            margin-top: auto;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="#" class="nav-link font-weight-bold">MI EMPRESA</a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="home" class="nav-link">Inicio</a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#" role="button"><i class="fas fa-user-circle"></i> Mi Perfil</a>
            </li>
        </ul>
    </nav>

    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <a href="#" class="brand-link">
            <span class="brand-text font-weight-light">Panel Admin</span>
        </a>

        <div class="sidebar">
            <nav class="mt-2">
                <!-- Aqui debemos agregar el menu dinamico -->
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    </ul>
            </nav>
            <!-- Aqui debemos agregar el menu dinamico para perfil -->
            <nav class="mt-auto mb-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item"><hr class="bg-secondary mx-2 my-1"></li>

                    <li class="nav-item">
                        <a href="#" class="nav-link bg-secondary">
                            <i class="nav-icon fas fa-user-cog"></i>
                            <p>
                                Perfil
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="url_configuracion" class="nav-link">
                                    <i class="fas fa-cog nav-icon"></i>
                                    <p>Configuración</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="url_cerrar_sesion" class="nav-link">
                                    <i class="fas fa-sign-out-alt nav-icon"></i>
                                    <p>Cerrar Sesión</p>
                                </a>
                            </li>
                            </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </aside>

    <div class="content-wrapper">
        <section class="content pt-3">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header"><h3 class="card-title">Contenido Principal</h3></div>
                            <div class="card-body">
                                <p>Haz clic en "Perfil" en la parte inferior del menú lateral. Se desplegarán las opciones "Configuración" y "Cerrar Sesión".</p>
                                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                                <p>Sigue haciendo scroll...</p>
                                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                                <p>Fin del contenido.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <footer class="main-footer">
        <strong>Copyright &copy; 2024 <a href="#">Mi Empresa</a>.</strong> Todos los derechos reservados.
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 1.0</div>
    </footer>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>

</body>
</html>