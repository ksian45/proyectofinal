<%-- 
    Document   : proveedores
    Created on : 20/10/2025, 10:06:06 p. m.
    Author     : guich
--%>
<%@page import="modelo.Proveedores"%>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proveedores | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <style>
        #tablaProveedores th, #tablaProveedores td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item"></li>
        </ul>
        <ul class="navbar-nav ml-auto">
           
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
                            <div class="card-header"><h3 class="card-title">Gestión de Proveedores</h3></div>
                            <div class="card-body">
                                <button id="btn_nuevo_proveedor" class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalProveedores"><i class="fas fa-plus"></i> Nuevo Proveedor</button>

                                <div class="table-responsive">
                                    <table id="tablaProveedores" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Proveedor</th>
                                                <th>NIT</th>
                                                <th>Dirección</th>
                                                <th>Teléfono</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                try {
                                                    Proveedores proveedor = new Proveedores();
                                                    DefaultTableModel tabla = proveedor.leer();
                                                    for(int t=0; t<tabla.getRowCount(); t++){
                                                        // Añadimos data-attributes para TODOS los campos para facilitar la edición
                                                        out.println("<tr data-id='"+ tabla.getValueAt(t, 0) +"' " +
                                                                        "data-proveedor='"+ tabla.getValueAt(t, 1) +"' " +
                                                                        "data-nit='"+ tabla.getValueAt(t, 2) +"' " +
                                                                        "data-direccion='"+ tabla.getValueAt(t, 3) +"' " +
                                                                        "data-telefono='"+ tabla.getValueAt(t, 4) +"'>");

                                                        out.println("<td>"+ tabla.getValueAt(t, 1) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 2) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 3) +"</td>");
                                                        out.println("<td>"+ tabla.getValueAt(t, 4) +"</td>");

                                                        // Añadimos las clases .btn-editar y .btn-eliminar
                                                        out.println("<td class='text-center'>");
                                                        out.println("  <div class='btn-group' role='group' aria-label='Acciones'>");
                                                        out.println("    <button type='button' class='btn btn-warning btn-sm btn-editar'><i class='fas fa-edit'></i></button>");
                                                        out.println("    <button type='button' class='btn btn-danger btn-sm btn-eliminar'><i class='fas fa-trash'></i></button>");
                                                        out.println("  </div>");
                                                        out.println("</td>");
                                                        out.println("</tr>");   
                                                    }
                                                } catch (Exception e) {
                                                    out.println("<tr><td colspan='5' class='text-center text-danger'>Error al cargar datos: " + e.getMessage() + "</td></tr>");
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
    $('#tablaProveedores').DataTable({
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

    // --- LÓGICA MODAL "CREAR" ---
    $('#modalProveedores').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        if (button.attr('id') === 'btn_nuevo_proveedor') {
            var form = $('#formProveedores'); // Asumimos que el form se llama así
            form[0].reset();
            form.removeClass('was-validated');
            $('#id_proveedor').val('0'); // Asumimos que el id oculto es 'id_proveedor'
            $('#accion').val('crear'); // Asumimos que el input oculto es 'accion'
            $('#modalProveedoresLabel').text('Nuevo Proveedor'); // Asumimos que el título es 'modalProveedoresLabel'
            $('#btnGuardar').text('Guardar'); // Asumimos que el botón es 'btnGuardar'
        }
    });

    // --- LÓGICA MODAL "EDITAR" ---
    $('#tablaProveedores tbody').on('click', '.btn-editar', function() {
        var tr = $(this).closest('tr');
        
        // Asignamos los IDs y valores del modal (los IDs deben coincidir)
        $('#id_proveedor').val(tr.data('id'));
        $('#accion').val('modificar');
        $('#proveedor').val(tr.data('proveedor'));
        $('#nit').val(tr.data('nit'));
        $('#direccion').val(tr.data('direccion'));
        $('#telefono').val(tr.data('telefono'));
        
        $('#modalProveedoresLabel').text('Editar Proveedor');
        $('#btnGuardar').text('Actualizar');
        
        $('#modalProveedores').modal('show');
    });

    // --- LÓGICA "ELIMINAR" (Borrado Físico) ---
    $('#tablaProveedores tbody').on('click', '.btn-eliminar', function() {
        var tr = $(this).closest('tr');
        var id_proveedor = tr.data('id');
        var nombre_proveedor = tr.data('proveedor'); // Para mostrar en la alerta

        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡Vas a eliminar a '" + nombre_proveedor + "'! No podrás revertir esta acción.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, ¡eliminar!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                var form = $('<form>', {
                    'method': 'POST',
                    'action': '<%= request.getContextPath() %>/sr_proveedor' // Asumimos que el servlet se llama así
                }).hide();

                var idInput = $('<input>', {'type': 'hidden', 'name': 'id_proveedor', 'value': id_proveedor});
                var accionInput = $('<input>', {'type': 'hidden', 'name': 'accion', 'value': 'eliminar'});

                form.append(idInput).append(accionInput);
                $('body').append(form);
                form.submit();
            }
        });
    });

});
</script>

<jsp:include page="modalProveedores.jsp" />
</body>
</html>