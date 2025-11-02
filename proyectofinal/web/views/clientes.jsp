<%-- 
    Document   : clientes
    Created on : 16/10/2025, 8:54:22 p. m.
    Author     : guich
--%>
<%@page import="modelo.Clientes"%>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>t
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes | Supermercado</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
    <style>
        #tablaClientes th, #tablaClientes td {
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
                    <!--Aqui pondremos los modulos dinamicos-->
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
                                <h3 class="card-title">Gestión de Clientes</h3>
                            </div>
                            <div class="card-body">
                                <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#modalClientes"><i class="fas fa-plus"></i> Nuevo Cliente</button>

                                <div class="table-responsive">
                                    <table id="tablaClientes" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Nombres</th>
                                                <th>Apellidos</th>
                                                <th>NIT</th>
                                                <th>Género</th>
                                                <th>Teléfono</th>
                                                <th>Correo Electrónico</th>
                                                <th>Fecha Ingreso</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                            Clientes cliente = new Clientes();
                                            DefaultTableModel tabla = new DefaultTableModel();
                                            tabla = cliente.leer();
                                            for(int t=0;t<tabla.getRowCount();t++){
                                                out.println("<tr data-id="+ tabla.getValueAt(t, 0) + " >");
                                 
                                                out.println("<td>"+ tabla.getValueAt(t, 1) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 2) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 3) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 4) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 5) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 6) +"</td>");
                                                out.println("<td>"+ tabla.getValueAt(t, 7) +"</td>");
                                                out.println("<td class='text-center'><div class='btn-group' role='group' aria-label='Acciones'><button type='button' class='btn btn-warning btn-sm btn-editar' data-id='"+ tabla.getValueAt(t, 0) +"'><i class='fas fa-edit'></i></button><button type='button' class='btn btn-danger btn-sm btn-eliminar' data-id='"+ tabla.getValueAt(t, 0) +"'><i class='fas fa-trash'></i></button></div></td>");
                                                out.println("  </button>");
                                                out.println("</td>");
                                                out.println("</tr>");    
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
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 0.1 </div>
    </footer>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>

<%
    String mensajeTipo = (String) session.getAttribute("mensajeTipo");
    String mensajeTexto = (String) session.getAttribute("mensajeTexto");
    String jsMensajeTipo = null;
    String jsMensajeTexto = null;
    if (mensajeTipo != null && mensajeTexto != null) {
        jsMensajeTipo = mensajeTipo;
        jsMensajeTexto = mensajeTexto;
        session.removeAttribute("mensajeTipo");
        session.removeAttribute("mensajeTexto");
    }
%>

<script>
    $(document).ready(function() {
        $('#tablaClientes').DataTable({
            "language": {"url": "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"},
            "lengthMenu": [ [5, 10, 25, 50, 100], [5, 10, 25, 50, 100] ],
            "responsive": true
        });
    });
    
    // 2. SweetAlert // MOSTRAR MENSAJE
    var mensajeTipo = "<%= jsMensajeTipo %>";
    var mensajeTexto = "<%= jsMensajeTexto %>";
    if (mensajeTipo && mensajeTipo !== "null" && mensajeTexto && mensajeTexto !== "null") {
        var tituloAlerta = (mensajeTipo === 'success') ? '¡Éxito!' : 'Error';
        Swal.fire({
            icon: mensajeTipo,
            title: tituloAlerta,
            text: mensajeTexto,
            confirmButtonText: 'Aceptar'
        });
    }

    // 3. LÓGICA DEL MODAL (Nuevo y Editar)
    
    $('#modalClientes').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var form = $('#formClientes'); 
        form.removeClass('was-validated');

        if (button.attr('id') === 'btn_nuevo') {
            // --- MODO CREAR --- // CREAR (LIMPIAR)
            form[0].reset(); 
            $('#id_cliente').val('0');
            $('#accion').val('crear');
            $('#modalClientesLabel').text('Nuevo Cliente');
            $('#btnGuardar').text('Guardar');
        }
    });

    $('#tablaClientes tbody').on('click', '.btn-editar', function() {
        // --- MODO EDITAR --- // EDITAR (RELLENAR)
        var fila = $(this).closest('tr');
        
        //Leer datos
        var id_cliente = fila.data('id');
        var nombres = fila.find('td:eq(0)').text();
        var apellidos = fila.find('td:eq(1)').text();
        var nit = fila.find('td:eq(2)').text();
        var genero_texto = fila.find('td:eq(3)').text();
        var telefono = fila.find('td:eq(4)').text();
        var correo_electronico = fila.find('td:eq(5)').text();
        
        //Poner datos
        $('#id_cliente').val(id_cliente);
        $('#accion').val('modificar');
        $('#nombres').val(nombres);
        $('#apellidos').val(apellidos);
        $('#nit').val(nit);
        
        var genero_val = genero_texto.trim() === 'Masculino' ? '0' : '1';
        $('#genero').val(genero_val);
        
        $('#telefono').val(telefono);
        $('#correo_electronico').val(correo_electronico);
        
        //Textos modal
        $('#modalClientesLabel').text('Editar Cliente');
        $('#btnGuardar').text('Actualizar');

        //Mostrar modal
        $('#modalClientes').modal('show'); 
    });
    
   // LÓGICA BOTÓN ELIMINAR --- // ELIMINAR (CONFIRMAR)
    $('#tablaClientes tbody').on('click', '.btn-eliminar', function() {
        
        //Leer ID
        var id_cliente = $(this).data('id');
        
        //Confirmar
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás revertir esta acción!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, ¡eliminar!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            //Si confirma
            if (result.isConfirmed) {
                
                //Formulario fantasma
                var form = $('<form>', {
                    'method': 'POST',
                    'action': '<%= request.getContextPath() %>/sr_cliente'
                }).hide();

                //Campo ID
                var idInput = $('<input>', {
                    'type': 'hidden',
                    'name': 'id_cliente',
                    'value': id_cliente
                });
                
                //Campo Acción
                var accionInput = $('<input>', {
                    'type': 'hidden',
                    'name': 'accion',
                    'value': 'eliminar'
                });

                //Enviar
                form.append(idInput).append(accionInput);
                $('body').append(form);
                form.submit();
            }
        });
    });
    
</script>
<!-- Llamada a los modals -->
<jsp:include page="modalClientes.jsp" />
</body>
</html>