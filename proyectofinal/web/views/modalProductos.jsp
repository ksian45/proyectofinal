<%-- 
    Document   : modalProductos
    Created on : 23/10/2025, 12:49:26 a. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalProductos" tabindex="-1" aria-labelledby="modalProductosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">

            <form id="formProductos" class="needs-validation" novalidate enctype="multipart/form-data">
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalProductosLabel">Nuevo Producto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_producto" name="id_producto" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="producto" class="form-label">Producto</label>
                            <input type="text" class="form-control" id="producto" name="producto" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre del producto.
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="marca" class="form-label">Marca</label>
                            <select class="form-control" id="marca" name="marca" required>
                                <option value="" selected disabled>Seleccione una marca...</option>
                                <option value="1">Dos Pinos</option>
                                <option value="2">Bimbo</option>
                                <option value="3">Nescafé</option>
                            </select>
                            <div class="invalid-feedback">
                                Por favor, seleccione una marca.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                            <div class="invalid-feedback">
                                Por favor, ingrese una descripción.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="precio_costo" class="form-label">Precio Costo</label>
                            <input type="number" class="form-control" id="precio_costo" name="precio_costo" step="0.01" min="0" required>
                            <div class="invalid-feedback">
                                Ingrese un precio de costo válido.
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="precio_venta" class="form-label">Precio Venta</label>
                            <input type="number" class="form-control" id="precio_venta" name="precio_venta" step="0.01" min="0" required>
                            <div class="invalid-feedback">
                                Ingrese un precio de venta válido.
                            </div>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="stock" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                            <div class="invalid-feedback">
                                Ingrese una cantidad de stock válida.
                            </div>
                        </div>
                    </div>
                    
                    <hr>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="imagen" class="form-label">Imagen</label>
                            <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
                            <div class="invalid-feedback">
                                Por favor, seleccione una imagen.
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3 text-center">
                            <label class="form-label">Previsualización</label>
                            <img id="imgPreview" src="https://placehold.co/150x150/EFEFEF/AAAAAA&text=Vista+Previa" alt="Vista previa de la imagen" class="img-thumbnail" style="width: 150px; height: 150px; object-fit: cover;">
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
(function () {
  'use strict'
  
  // --- Script de Validación de Bootstrap ---
  var forms = document.querySelectorAll('.needs-validation')
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
    
  // --- Script de Previsualización de Imagen ---
  var fileInput = document.getElementById('imagen');
  var imgPreview = document.getElementById('imgPreview');
  
  if (fileInput) {
      fileInput.addEventListener('change', function() {
          var file = this.files[0];
          
          if (file) {
              var reader = new FileReader();
              
              reader.onload = function(e) {
                  imgPreview.src = e.target.result;
              }
              
              reader.readAsDataURL(file);
              
              // Si estás editando, podrías querer cambiar el 'required'
              // fileInput.required = false; (Lógica adicional para editar)
          } else {
              // Si no seleccionan nada, muestra el placeholder
              imgPreview.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Vista+Previa';
          }
      });
  }
  
  // --- Limpiar el modal al cerrarse (opcional pero recomendado) ---
  $('#modalProductos').on('hidden.bs.modal', function () {
      var form = $(this).find('form')[0];
      form.classList.remove('was-validated'); // Quita los mensajes de error
      form.reset(); // Resetea el formulario
      imgPreview.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Vista+Previa'; // Resetea la imagen
      
      // Resetea los campos ocultos para modo "Crear"
      $('#id_producto').val('');
      $('#accion').val('crear');
      $('#modalProductosLabel').text('Nuevo Producto');
      
      // Asegura que el input de imagen sea requerido para "Crear"
      $('#imagen').prop('required', true);
  });
  
})()
</script>
