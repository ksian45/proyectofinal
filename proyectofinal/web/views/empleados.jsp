<%-- 
    Document   : empleados
    Created on : 16/10/2025, 8:43:33 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empleados | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
    <style>
        #tablaEmpleados th, #tablaEmpleados td {
            text-align: center;
            vertical-align: middle;
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
                    <!--Aqui tenemos que poner los modulos dinamicos-->
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
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Gestión de Empleados</h3>
                            </div>
                            <div class="card-body">
                                <button class="btn btn-primary mb-3"><i class="fas fa-plus"></i> Nuevo</button>

                                <div class="table-responsive">
                                    <table id="tablaEmpleados" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Nombres</th>
                                                <th>Apellidos</th>
                                                <th>Dirección</th>
                                                <th>Teléfono</th>
                                                <th>DPI</th>
                                                <th>Género</th>
                                                <th>Nacimiento</th>
                                                <th>Puesto</th>
                                                <th>Inicio Labores</th>
                                                <th>Ingreso</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Juan Carlos</td>
                                                <td>Pérez Gómez</td>
                                                <td>10a Calle 15-20 Zona 5</td>
                                                <td>5555-1234</td>
                                                <td>2345 67890 0101</td>
                                                <td>Masculino</td>
                                                <td>15/05/1990</td>
                                                <td>Bodeguero</td>
                                                <td>01/03/2020</td>
                                                <td>01/03/2020</td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Ana Lucía</td>
                                                <td>Martínez López</td>
                                                <td>Zona 1, Guatemala</td>
                                                <td>4444-5678</td>
                                                <td>3456 78901 0101</td>
                                                <td>Femenino</td>
                                                <td>20/08/1995</td>
                                                <td>Cajera</td>
                                                <td>15/07/2021</td>
                                                <td>15/07/2021</td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Pedro Antonio</td>
                                                <td>Ramírez Solís</td>
                                                <td>Colonia El Milagro, Mixco</td>
                                                <td>3333-9876</td>
                                                <td>4567 89012 0101</td>
                                                <td>Masculino</td>
                                                <td>01/11/1988</td>
                                                <td>Gerente de Tienda</td>
                                                <td>10/01/2018</td>
                                                <td>10/01/2018</td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></button>
                                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
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

<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>

<script>
    $(document).ready(function() {
        $('#tablaEmpleados').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
            },
            "lengthMenu": [ [5, 10, 25, 50, 100], [5, 10, 25, 50, 100] ],
            "responsive": true
        });
    });
</script>

</body>
</html>
