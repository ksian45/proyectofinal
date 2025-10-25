<%-- 
    Document   : puestos
    Created on : 16/10/2025, 10:36:12 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Puestos | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">

    <style>
        .puesto-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover; 
            margin: 0 auto 15px auto; 
            display: block;
            border: 3px solid #dee2e6;
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
            <nav class="mt-2" style="flex-grow: 1;">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    </ul>
            </nav>
            <nav class="mt-auto mb-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item"><hr class="bg-secondary mx-2 my-1"></li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
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
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Gestión de Puestos</h3>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-primary mb-4" data-toggle="modal" data-target="#modalPuestos"><i class="fas fa-plus"></i> Nuevo Puesto</button>

                        <div class="row">
                            
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="https://cdn-icons-png.flaticon.com/512/4205/4205906.png" alt="Imagen del Puesto" class="puesto-img bg-light">
                                        
                                        <h5 class="card-title font-weight-bold">Gerente de Tienda</h5>
                                        <div class="mt-auto"> <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="https://cdn-icons-png.flaticon.com/512/4459/4459384.png" alt="Imagen del Puesto" class="puesto-img bg-light">
                                        
                                        <h5 class="card-title font-weight-bold">Cajero/a</h5>
                                        <div class="mt-auto">
                                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="https://cdn-icons-png.flaticon.com/512/1261/1261166.png" alt="Imagen del Puesto" class="puesto-img bg-light">
                                        
                                        <h5 class="card-title font-weight-bold">Bodeguero</h5>
                                        <div class="mt-auto">
                                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="https://cdn-icons-png.flaticon.com/512/291/291402.png" alt="Imagen del Puesto" class="puesto-img bg-light">
                                        
                                        <h5 class="card-title font-weight-bold">Personal de Limpieza</h5>
                                        <div class="mt-auto">
                                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <footer class="main-footer">
        <strong>Copyright &copy; 2025 <a href="#">Mi Empresa</a>.</strong> Todos los derechos reservados.
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 1.0</div>
    </footer>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>
<!-- Llamada a los modals -->
<jsp:include page="modalPuestos.jsp" />
</body>
</html>