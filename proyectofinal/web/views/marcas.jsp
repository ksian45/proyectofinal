    <%-- 
    Document   : marcas
    Created on : 16/10/2025, 10:55:12 p. m.
    Author     : guich
--%>
<%@page import="modelo.Marcas"%>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marcas | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
    <style>
        .marca-img {
            height: 100px;
            width: auto;
            max-width: 100%;
            object-fit: contain;
            margin: 0 auto 15px auto;
            display: block;
            background-color: #f8f9fa;
            border-radius: .25rem;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a></li>
            <li class="nav-item d-none d-sm-inline-block"><a href="#" class="nav-link font-weight-bold">MI EMPRESA</a></li>
            <li class="nav-item d-none d-sm-inline-block"><a href="home" class="nav-link">Inicio</a></li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-user-circle"></i> Mi Perfil</a></li>
        </ul>
    </nav>

    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <a href="#" class="brand-link"><span class="brand-text font-weight-light">Panel Admin</span></a>
        <div class="sidebar">
            <nav class="mt-2" style="flex-grow: 1;"><ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false"></ul></nav>
            <nav class="mt-auto mb-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item"><hr class="bg-secondary mx-2 my-1"></li>
                    <li class="nav-item">
                        <a href="#" class="nav-link"><i class="nav-icon fas fa-user-cog"></i><p>Perfil<i class="right fas fa-angle-left"></i></p></a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item"><a href="url_configuracion" class="nav-link"><i class="fas fa-cog nav-icon"></i><p>Configuración</p></a></li>
                            <li class="nav-item"><a href="url_cerrar_sesion" class="nav-link"><i class="fas fa-sign-out-alt nav-icon"></i><p>Cerrar Sesión</p></a></li>
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
                    <div class="card-header"><h3 class="card-title">Gestión de Marcas</h3></div>
                    <div class="card-body">
                        <button id="btn_nueva_marca" class="btn btn-primary mb-4" data-toggle="modal" data-target="#modalMarcas">
                            <i class="fas fa-plus"></i> Nueva Marca
                        </button>

                        <div class="row" id="contenedorMarcas">
                            <%
                                try {
                                    Marcas brand = new Marcas();
                                    DefaultTableModel tabla = brand.leer(); // Clase debe traer 3 columnas: id, marca, imagen
                                    for (int t = 0; t < tabla.getRowCount(); t++) {
                                        String id_marca = tabla.getValueAt(t, 0).toString();
                                        String marca = tabla.getValueAt(t, 1).toString();
                                        String imagenNombre = (tabla.getValueAt(t, 2) != null) ? tabla.getValueAt(t, 2).toString() : "";
                                        
                                        String rutaImagen = imagenNombre.isEmpty() ? "https://placehold.co/150x150/EFEFEF/AAAAAA&text=Sin+Imagen" : request.getContextPath() + "/public/images/" + imagenNombre;
                            %>
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="<%= rutaImagen %>" alt="Logo de <%= marca %>" class="marca-img">
                                        <h5 class="card-title font-weight-bold"><%= marca %></h5>
                                        <div class="mt-auto">
                                            <button type="button"
                                                class="btn btn-warning btn-sm btn_editar_marca"
                                                data-id="<%= id_marca %>"
                                                data-nombre="<%= marca %>"
                                                data-imagen="<%= rutaImagen %>">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button"
                                                class="btn btn-danger btn-sm btn_eliminar_marca"
                                                data-id="<%= id_marca %>"
                                                data-nombre="<%= marca %>">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% 
                                    } // Fin del for
                                } catch (Exception e) {
                                    out.println("<div class='col-12'><p class='text-danger text-center'>Error al cargar marcas: " + e.getMessage() + "</p></div>");
                                    e.printStackTrace();
                                }
                            %>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%-- Script para leer los mensajes del Servlet --%>
<%
    String mensajeTipo = (String) session.getAttribute("mensajeTipo");
    String mensajeTexto = (String) session.getAttribute("mensajeTexto");
    if (mensajeTipo != null && mensajeTexto != null) {
        session.removeAttribute("mensajeTipo");
        session.removeAttribute("mensajeTexto");
    }
%>

<script>
$(document).ready(function() {
    
    // Mostrar SweetAlert si viene del servlet
    var mensajeTipo = "<%= mensajeTipo %>";
    var mensajeTexto = "<%= mensajeTexto %>";
    if (mensajeTipo && mensajeTipo !== "null" && mensajeTexto && mensajeTexto !== "null") {
        Swal.fire({
            icon: mensajeTipo,
            title: (mensajeTipo === 'success') ? '¡Éxito!' : 'Error',
            text: mensajeTexto,
            confirmButtonText: 'Aceptar'
        });
    }

    // Lógica para "Crear"
    // Esta SÍ va aquí, porque "escucha" el 'show.bs.modal'
    $('#modalMarcas').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        if (button.attr('id') === 'btn_nueva_marca') {
            var form = $('#formMarcas');
            form[0].reset();
            form.removeClass('was-validated');
            $('#id_marca').val('0');
            $('#accion').val('crear');
            $('#modalMarcasLabel').text('Nueva Marca');
            $('#btnGuardar').text('Guardar');
            $('#imagenMarca').prop('required', true); 
            $('#imgPreviewMarca').attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo');
        }
    });

    // Lógica para "Editar"
    // Esta SÍ va aquí, porque "escucha" el clic en .btn_editar_marca
    $('#contenedorMarcas').on('click', '.btn_editar_marca', function() {
        var id = $(this).data('id');
        var nombre = $(this).data('nombre');
        var imagen = $(this).data('imagen');

        var form = $('#formMarcas');
        form[0].reset();
        form.removeClass('was-validated');
        $('#id_marca').val(id);
        $('#accion').val('modificar');
        $('#marca').val(nombre);
        $('#imagenMarca').prop('required', false);
        $('#imgPreviewMarca').attr('src', imagen);
        $('#modalMarcasLabel').text('Editar Marca');
        $('#btnGuardar').text('Actualizar');
        $('#modalMarcas').modal('show');
    });

    // Lógica para "Eliminar" (Borrado Físico)
    // Esta SÍ va aquí, porque "escucha" el clic en .btn_eliminar_marca
    $('#contenedorMarcas').on('click', '.btn_eliminar_marca', function() {
        var id_marca = $(this).data('id');
        var nombre_marca = $(this).data('nombre');
        
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡Vas a eliminar '" + nombre_marca + "'! No podrás revertir esta acción.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Sí, ¡eliminar!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                var formDel = $('<form>', {
                    'method': 'POST',
                    'action': '<%= request.getContextPath() %>/sr_marca'
                }).hide();
                formDel.append($('<input>', {type: 'hidden', name: 'id_marca', value: id_marca}));
                formDel.append($('<input>', {type: 'hidden', name: 'accion', value: 'eliminar'}));
                $('body').append(formDel);
                formDel.submit();
            }
        });
    });

   

});
</script>

<%-- Aquí es donde llamamos al otro archivo --%>
<jsp:include page="modalMarcas.jsp" />

</body>
</html>