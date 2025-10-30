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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
    <style>
        .marca-img {
            max-height: 100px;
            width: auto;
            max-width: 100%;
            object-fit: contain;
            margin: 0 auto 15px auto;
            display: block;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- NAVBAR -->
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

    <!-- SIDEBAR -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <a href="#" class="brand-link"><span class="brand-text font-weight-light">Panel Admin</span></a>
        <div class="sidebar">
            <nav class="mt-2" style="flex-grow: 1;">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false"></ul>
            </nav>
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

    <!-- CONTENT -->
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
                                Marcas brand = new Marcas();
                                DefaultTableModel tabla = brand.leer();
                                for (int t = 0; t < tabla.getRowCount(); t++) {
                                    String id_marca = tabla.getValueAt(t, 0).toString();
                                    String marca = tabla.getValueAt(t, 1).toString();
                                    String imagen = tabla.getValueAt(t, 2).toString();
                            %>
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card text-center h-100">
                                    <div class="card-body d-flex flex-column">
                                        <img src="<%= imagen %>" alt="Logo de <%= marca %>" class="marca-img bg-light">
                                        <h5 class="card-title font-weight-bold"><%= marca %></h5>
                                        <div class="mt-auto">
                                            <button type="button"
                                                class="btn btn-warning btn-sm btn_editar_marca"
                                                data-id="<%= id_marca %>"
                                                data-nombre="<%= marca %>"
                                                data-imagen="<%= imagen %>">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button"
                                                class="btn btn-danger btn-sm btn_eliminar_marca"
                                                data-id="<%= id_marca %>">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- FOOTER -->
    <footer class="main-footer">
        <strong>Copyright &copy; 2025 <a href="#">Mi Empresa</a>.</strong> Todos los derechos reservados.
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 1.0</div>
    </footer>
</div>

<!-- Modal Crear/Editar Marca -->
<div class="modal fade" id="modalMarcas" tabindex="-1" role="dialog" aria-labelledby="modalMarcasLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form id="formMarcas" enctype="multipart/form-data" method="post" action="<%= request.getContextPath() %>/sr_marca">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalMarcasLabel">Nueva Marca</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <input type="hidden" id="id_marca" name="id_marca" value="0">
          <input type="hidden" id="accion" name="accion" value="crear">
          <div class="form-group">
            <label for="marca">Nombre de la Marca</label>
            <input type="text" class="form-control" id="marca" name="marca" required>
          </div>
          <div class="form-group">
            <label for="imagenMarca">Imagen (PNG)</label>
            <input type="file" class="form-control-file" id="imagenMarca" name="imagenMarca" accept=".png">
            <img id="imgPreviewMarca" src="https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG" class="img-fluid mt-2">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
          <button type="submit" id="btnGuardar" class="btn btn-primary">Guardar</button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- SCRIPTS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
    // Mensaje SweetAlert
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

    var form = $('#formMarcas');
    var preview = $('#imgPreviewMarca');

    // Nueva Marca
    $('#btn_nueva_marca').click(function() {
        form[0].reset();
        form.removeClass('was-validated');
        $('#id_marca').val('0');
        $('#accion').val('crear');
        $('#modalMarcasLabel').text('Nueva Marca');
        $('#btnGuardar').text('Guardar');
        $('#imagenMarca').prop('required', true);
        preview.attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG');
    });

    // Editar Marca
    $('#contenedorMarcas').on('click', '.btn_editar_marca', function() {
        var id = $(this).data('id');
        var nombre = $(this).data('nombre');
        var imagen = $(this).data('imagen');

        form[0].reset();
        form.removeClass('was-validated');
        $('#id_marca').val(id);
        $('#accion').val('modificar');
        $('#marca').val(nombre);
        $('#imagenMarca').prop('required', false);
        preview.attr('src', imagen);
        $('#modalMarcasLabel').text('Editar Marca');
        $('#btnGuardar').text('Actualizar');
        $('#modalMarcas').modal('show');
    });

    // Eliminar Marca
    $('#contenedorMarcas').on('click', '.btn_eliminar_marca', function() {
        var id_marca = $(this).data('id');
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás revertir esta acción!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                var formDel = $('<form>', {
                    method: 'POST',
                    action: '<%= request.getContextPath() %>/sr_marca'
                }).hide();
                formDel.append($('<input>', {type: 'hidden', name: 'id_marca', value: id_marca}));
                formDel.append($('<input>', {type: 'hidden', name: 'accion', value: 'eliminar'}));
                $('body').append(formDel);
                formDel.submit();
            }
        });
    });

    // Validación Bootstrap
    form.on('submit', function(event) {
        if (!form[0].checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.addClass('was-validated');
    });

    // Previsualización Imagen
    $('#imagenMarca').change(function() {
        var file = this.files[0];
        if (file && file.type === 'image/png') {
            var reader = new FileReader();
            reader.onload = function(e) {
                preview.attr('src', e.target.result);
            }
            reader.readAsDataURL(file);
        } else {
            preview.attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG');
        }
    });
});
</script>
</body>
</html>


