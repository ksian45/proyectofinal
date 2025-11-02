<%-- 
    Document   : puestos
    Created on : 16/10/2025, 10:36:12 p. m.
    Author     : guich
--%>
<%@page import="modelo.Puestos"%>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Puestos | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

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
        .img-preview-modal {
            width: 150px; 
            height: 150px; 
            object-fit: contain;
            border-radius: .25rem;
            background-color: #f4f4f4;
        }
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a></li>
            
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"> <a href="<%= request.getContextPath() %>/index.jsp" class="nav-link">
                          <i class="fas fa-home"></i>
                          <p>Menu Principal</p>
                          </a></li>
        </ul>
    </nav>

    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <a href="#" class="brand-link"><span class="brand-text font-weight-light">Super Market</span></a>
        <div class="sidebar">
            <nav class="mt-2" style="flex-grow: 1;"><ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false"></ul></nav>
            <nav class="mt-auto mb-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item"><hr class="bg-secondary mx-2 my-1"></li>
                    <li class="nav-item">
                         <a href="<%= request.getContextPath() %>/index.jsp" class="nav-link">
                          <i class="fas fa-home"></i>
                          <p>Menu Principal</p>
                          </a>
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
                    <div class="card-header">
                        <h3 class="card-title">Gestión de Puestos</h3>
                    </div>
                    <div class="card-body">
                        <%-- Botón "Nuevo" con ID --%>
                        <button id="btn_nuevo_puesto" class="btn btn-primary mb-4" data-toggle="modal" data-target="#modalPuestos"><i class="fas fa-plus"></i> Nuevo Puesto</button>

                        <div class="row" id="contenedorPuestos">
                            <% 
                                try {
                                    Puestos puesto = new Puestos();
                                    DefaultTableModel tabla = puesto.leer();
                                    
                                    for(int t=0; t < tabla.getRowCount(); t++){
                                        String id_puesto = tabla.getValueAt(t, 0).toString();
                                        String nombre_puesto = tabla.getValueAt(t, 1).toString();
                                        String imagenNombre = (tabla.getValueAt(t, 2) != null) ? tabla.getValueAt(t, 2).toString() : "";
                                        
                                        String rutaImagen = imagenNombre.isEmpty() ? "https://placehold.co/150x150/EFEFEF/AAAAAA&text=Sin+Imagen" : request.getContextPath() + "/public/images/" + imagenNombre;
                            %>
                            
                            <div class='col-lg-3 col-md-4 col-sm-6 mb-4'>
                                <div class='card text-center h-100'>
                                    <div class='card-body d-flex flex-column'>
                                        <img src='<%= rutaImagen %>' alt='Imagen de <%= nombre_puesto %>' class='puesto-img bg-light'>
                                        <h5 class='card-title font-weight-bold'><%= nombre_puesto %></h5>
                                        <div class='mt-auto'>
                                            <%-- Botones con data-attributes --%>
                                            <button type='button' class='btn btn-warning btn-sm btn-editar' 
                                                data-id='<%= id_puesto %>' 
                                                data-puesto='<%= nombre_puesto %>' 
                                                data-imagen='<%= rutaImagen %>'>
                                                <i class='fas fa-edit'></i>
                                            </button>
                                            <button type='button' class='btn btn-danger btn-sm btn-eliminar' 
                                                data-id='<%= id_puesto %>' 
                                                data-puesto='<%= nombre_puesto %>'>
                                                <i class='fas fa-trash'></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <% 
                                    } // Fin for
                                } catch (Exception e) {
                                    out.println("<div class='col-12'><p class='text-danger text-center'>Error al cargar puestos: " + e.getMessage() + "</p></div>");
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
    $('#modalPuestos').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        if (button.attr('id') === 'btn_nuevo_puesto') {
            var form = $('#formPuestos');
            form[0].reset();
            form.removeClass('was-validated');
            $('#id_puesto').val('0');
            $('#accion').val('crear');
            $('#modalPuestosLabel').text('Nuevo Puesto');
            $('#btnGuardar').text('Guardar');
            $('#imagenPuesto').prop('required', true); 
            $('#imgPreviewPuesto').attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Imagen');
        }
    });

    // Lógica para "Editar"
    $('#contenedorPuestos').on('click', '.btn-editar', function() {
        var id = $(this).data('id');
        var puesto = $(this).data('puesto');
        var imagen = $(this).data('imagen');

        var form = $('#formPuestos');
        form[0].reset();
        form.removeClass('was-validated');
        $('#id_puesto').val(id);
        $('#accion').val('modificar');
        $('#puesto').val(puesto);
        $('#imagenPuesto').prop('required', false);
        $('#imgPreviewPuesto').attr('src', imagen);
        $('#modalPuestosLabel').text('Editar Puesto');
        $('#btnGuardar').text('Actualizar');
        $('#modalPuestos').modal('show');
    });

    // Lógica para "Eliminar" (Borrado Físico)
    $('#contenedorPuestos').on('click', '.btn-eliminar', function() {
        var id_puesto = $(this).data('id');
        var nombre_puesto = $(this).data('puesto');
        
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡Vas a eliminar '" + nombre_puesto + "'! No podrás revertir esta acción.",
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
                    'action': '<%= request.getContextPath() %>/sr_puesto' // Asumimos este servlet
                }).hide();
                formDel.append($('<input>', {type: 'hidden', name: 'id_puesto', value: id_puesto}));
                formDel.append($('<input>', {type: 'hidden', name: 'accion', value: 'eliminar'}));
                $('body').append(formDel);
                formDel.submit();
            }
        });
    });

});
</script>

<jsp:include page="modalPuestos.jsp" />
</body>
</html>