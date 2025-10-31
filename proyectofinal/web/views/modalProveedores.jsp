<%-- 
    Document   : modalProveedores
    Created on : 24/10/2025, 11:11:13 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- No necesitas los imports de Marcas aquí, los quité --%>

<div class="modal fade" id="modalProveedores" tabindex="-1" aria-labelledby="modalProveedoresLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">

            <%-- CORRECCIÓN: Añadido action y method al formulario --%>
            <form id="formProveedores" action="<%= request.getContextPath() %>/sr_proveedor" method="POST" class="needs-validation" novalidate>
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalProveedoresLabel">Nuevo Proveedor</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_proveedor" name="id_proveedor" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="proveedor" class="form-label">Nombre del Proveedor</label>
                            <input type="text" class="form-control" id="proveedor" name="proveedor" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre del proveedor.
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="nit" class="form-label">NIT</label>
                            <input type="text" class="form-control" id="nit" name="nit" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el NIT.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="direccion" class="form-label">Dirección</label>
                            <input type="text" class="form-control" id="direccion" name="direccion" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese la dirección.
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese un número de teléfono.
                            </div>
                        </div>
                    </div>

                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="btnGuardar">Guardar</button>
                </div>

            </form> </div>
    </div>
</div>

<script>
(function () {
  'use strict'
  
  // Script de Validación de Bootstrap
  var forms = document.querySelectorAll('#formProveedores.needs-validation');
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }
        form.classList.add('was-validated')
      }, false)
    });
  
  // Limpiar el modal al cerrarse
  $('#modalProveedores').on('hidden.bs.modal', function () {
     var form = $(this).find('form')[0];
     form.classList.remove('was-validated');
     form.reset();
     
     $('#id_proveedor').val('');
     $('#accion').val('crear');
     $('#modalProveedoresLabel').text('Nuevo Proveedor');
  });
  
})()
</script>