<%-- 
    Document   : modalClientes
    Created on : 23/10/2025, 12:10:44 a. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalClientes" tabindex="-1" aria-labelledby="modalClientesLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">

            <form id="formEmpleados" class="needs-validation" novalidate>
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalClientesLabel">Nuevo Cliente</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_cliente" name="id_cliente" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="nombres" class="form-label">Nombres</label>
                            <input type="text" class="form-control" id="nombres" name="nombres" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese los nombres.
                            </div>
                        </div>

                        <div class="col-md-4 mb-3">
                            <label for="apellidos" class="form-label">Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese los apellidos.
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="nit" class="form-label">NIT</label>
                            <input type="text" class="form-control" id="nit" name="nit" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el NIT.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese un número de teléfono.
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="genero" class="form-label">Género</label>
                            <select class="form-control" id="genero" name="genero" required>
                                <option value="" selected disabled>Seleccione un género...</option>
                                <option value="0">Masculino</option>
                                <option value="1">Femenino</option>
                            </select>
                            <div class="invalid-feedback">
                                Por favor, seleccione un género.
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="correo_electronico" class="form-label">Correo Electronico</label>
                            <input type="email" class="form-control" id="correo_electronico" name="correo_electronico" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese un correo válido.
                            </div>
                        </div>
                    </div>


                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="btnGuardar">Guardar</button>
                </div>

            </form> </div>
    </div>
</div>

<script>
// Ejemplo de cómo activar la validación con JavaScript
(function () {
  'use strict'

  // Obtener todos los formularios a los que queremos aplicar estilos de validación de Bootstrap personalizados
  var forms = document.querySelectorAll('.needs-validation')

  // Bucle sobre ellos y evitar el envío
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }

        form.classList.add('was-validated')
      }, false)
    })
})()
</script>