<%-- 
    Document   : productos
    Created on : 16/10/2025, 9:09:04 p. m.
    Author     : guich
--%>
<%@page import="modelo.Productos"%>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <style>
        #tablaProductos th, #tablaProductos td {
            text-align: center;
            vertical-align: middle;
        }
        .badge-success { background-color: #28a745; color: white; }
        .badge-danger { background-color: #dc3545; color: white; }
        .badge { display: inline-block; padding: .35em .65em; font-size: .75em; font-weight: 700; line-height: 1; text-align: center; white-space: nowrap; vertical-align: baseline; border-radius: .25rem; }
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a></li>
            
            
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
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header"><h3 class="card-title">Gestión de Productos</h3></div>
                            <div class="card-body">
                                <button id="btn_nuevo_producto" class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalProductos"><i class="fas fa-plus"></i> Nuevo Producto</button>
                                <div class="table-responsive">
                                    <table id="tablaProductos" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Producto</th>
                                                <th>Marca</th>
                                                <th>Descripción</th>
                                                <th>Precio Costo</th>
                                                <th>Precio Venta</th>
                                                <th>Stock</th>
                                                <th>Fecha Ingreso</th>
                                                <th>Estado</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try {
                                                    Productos producto = new Productos();
                                                    DefaultTableModel tabla = producto.leer();
                                                    for(int t=0; t<tabla.getRowCount(); t++){
                                                        String estadoValor = tabla.getValueAt(t, 10).toString();
                                                        String estadoTexto = estadoValor.equals("1") ? "<span class='badge badge-success'>Activo</span>" : "<span class='badge badge-danger'>Inactivo</span>";
                                                        String botonEstadoClase = estadoValor.equals("1") ? "btn-secondary" : "btn-success";
                                                        String botonEstadoIcono = estadoValor.equals("1") ? "fa-toggle-off" : "fa-toggle-on";

                                                        out.println("<tr data-id='"+ tabla.getValueAt(t, 0) +"' " +
                                                                        "data-producto='"+ tabla.getValueAt(t, 1) +"' " +
                                                                        "data-marca='"+ tabla.getValueAt(t, 2) +"' " +
                                                                        "data-idm='"+ tabla.getValueAt(t, 9) +"' " +
                                                                        "data-descripcion='"+ tabla.getValueAt(t, 3) +"' " +
                                                                        "data-img='"+ tabla.getValueAt(t, 4) +"' " +
                                                                        "data-costo='"+ tabla.getValueAt(t, 5) +"' " +
                                                                        "data-venta='"+ tabla.getValueAt(t, 6) +"' " +
                                                                        "data-stock='"+ tabla.getValueAt(t, 7) +"' " +
                                                                        "data-ingreso='"+ tabla.getValueAt(t, 8) +"' " +
                                                                        "data-estado='"+ estadoValor +"'>");

                                                        out.println("<td>"+ tabla.getValueAt(t, 1) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 2) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 3) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 5) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 6) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 7) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 8) +"</td>");
                                                        out.println("<td>"+ estadoTexto +"</td>");

                                                        out.println("<td class='text-center'>");
                                                        out.println("  <div class='btn-group' role='group' aria-label='Acciones'>");
                                                        out.println("    <button type='button' class='btn btn-primary btn-sm btn-ver'><i class='fas fa-eye'></i></button>");
                                                        out.println("    <button type='button' class='btn btn-warning btn-sm btn-editar'><i class='fas fa-edit'></i></button>");
                                                        out.println("    <button type='button' class='btn "+ botonEstadoClase +" btn-sm btn-eliminar'><i class='fas "+ botonEstadoIcono +"'></i></button>");
                                                        out.println("  </div>");
                                                        out.println("</td>");
                                                        out.println("</tr>");
                                                    }
                                                } catch (Exception e) {
                                                    out.println("<tr><td colspan='9' class='text-center text-danger'>Error al cargar datos: " + e.getMessage() + "</td></tr>");
                                                    e.printStackTrace();
                                                }
                                            %>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(document).ready(function() {

    // --- DATATABLES ---
    $('#tablaProductos').DataTable({
        "language": { "url": "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" },
        "lengthMenu": [ [5, 10, 25, 50, 100], [5, 10, 25, 50, 100] ],
        "responsive": true
    });

    // --- SWEETALERT (mensajes del servlet) ---
    <%
        String mensajeTipo = (String) session.getAttribute("mensajeTipo");
        String mensajeTexto = (String) session.getAttribute("mensajeTexto");
        if (mensajeTipo != null && mensajeTexto != null) {
            session.removeAttribute("mensajeTipo");
            session.removeAttribute("mensajeTexto");
    %>
        var tituloAlerta = ('<%= mensajeTipo %>' === 'success') ? '¡Éxito!' : 'Error';
        Swal.fire({
            icon: '<%= mensajeTipo %>',
            title: tituloAlerta,
            text: '<%= mensajeTexto %>',
            confirmButtonText: 'Aceptar'
        });
    <% } %>

    // --- LÓGICA MODAL "VER" ---
    $('#tablaProductos tbody').on('click', '.btn-ver', function() {
        var tr = $(this).closest('tr');
        $('#verProductoNombre').text(tr.data('producto'));
        $('#verProductoMarca').text(tr.data('marca'));
        $('#verProductoDescripcion').text(tr.data('descripcion'));
        $('#verProductoCosto').text(tr.data('costo'));
        $('#verProductoVenta').text(tr.data('venta'));
        $('#verProductoStock').text(tr.data('stock'));
        $('#verProductoIngreso').text(tr.data('ingreso'));
        var imagenUrl = tr.data('img');
        var rutaBase = "<%= request.getContextPath() %>/public/images/";
        if (imagenUrl && imagenUrl !== 'null' && imagenUrl !== '') {
            $('#imgVerProducto').attr('src', rutaBase + imagenUrl);
        } else {
            $('#imgVerProducto').attr('src', 'https://placehold.co/300x300/EFEFEF/AAAAAA&text=Sin+Imagen');
        }
        $('#modalVerProducto').modal('show');
    });

    // --- LÓGICA MODAL "CREAR" ---
    $('#modalProductos').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        if (button.attr('id') === 'btn_nuevo_producto') {
            var form = $('#formProductos');
            form[0].reset();
            form.removeClass('was-validated');
            $('#id_producto').val('0');
            $('#accion').val('crear');
            $('#imagen').prop('required', true);
            $('#imgPreview').attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Vista+Previa');
            $('#modalProductosLabel').text('Nuevo Producto');
            $('#btnGuardar').text('Guardar');
        }
    });

    // --- LÓGICA MODAL "EDITAR" ---
    $('#tablaProductos tbody').on('click', '.btn-editar', function() {
        var tr = $(this).closest('tr');
        $('#id_producto').val(tr.data('id'));
        $('#accion').val('modificar');
        $('#imagen').prop('required', false);
        $('#producto').val(tr.data('producto'));
        $('#marca').val(tr.data('idm'));
        $('#descripcion').val(tr.data('descripcion'));
        $('#precio_costo').val(tr.data('costo'));
        $('#precio_venta').val(tr.data('venta'));
        $('#stock').val(tr.data('stock'));
        var imagenUrl = tr.data('img');
        var rutaBase = "<%= request.getContextPath() %>/public/images/";
        if (imagenUrl && imagenUrl !== 'null' && imagenUrl !== '') {
            $('#imgPreview').attr('src', rutaBase + imagenUrl);
        } else {
            $('#imgPreview').attr('src', 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Sin+Imagen');
        }
        $('#modalProductosLabel').text('Editar Producto');
        $('#btnGuardar').text('Actualizar');
        $('#modalProductos').modal('show');
    });

    // --- LÓGICA "CAMBIAR ESTADO" ---
    $('#tablaProductos tbody').on('click', '.btn-eliminar', function() {
        var tr = $(this).closest('tr');
        var id_producto = tr.data('id');
        var estado_actual = tr.data('estado');

        var textoConfirmacion = estado_actual == 1 ? 'El producto se marcará como inactivo.' : 'El producto se volverá a activar.';
        var botonConfirmacion = estado_actual == 1 ? 'Sí, ¡desactivar!' : 'Sí, ¡activar!';
        var tituloConfirmacion = estado_actual == 1 ? '¿Desactivar Producto?' : '¿Reactivar Producto?';

        Swal.fire({
            title: tituloConfirmacion,
            text: textoConfirmacion,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: botonConfirmacion,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                var form = $('<form>', {
                    'method': 'POST',
                    'action': '<%= request.getContextPath() %>/sr_producto'
                }).hide();

                var idInput = $('<input>', {'type': 'hidden', 'name': 'id_producto', 'value': id_producto});
                var accionInput = $('<input>', {'type': 'hidden', 'name': 'accion', 'value': 'eliminar'});

                form.append(idInput).append(accionInput);
                $('body').append(form);
                form.submit();
            }
        });
    });

    // --- LÓGICA DE ENVÍO (Eliminada) ---
    // El formulario se enviará de forma tradicional
    
});
</script>

<jsp:include page="modalProductos.jsp" />
<jsp:include page="modalVerProducto.jsp" />
</body>
</html>