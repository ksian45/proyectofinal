<%-- 
    Document   : modalPuestos
    Created on : 24/10/2025, 10:05:02 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalPuestos" tabindex="-1" aria-labelledby="modalPuestosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form id="formPuestos" class="needs-validation" novalidate enctype="multipart/form-data">
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalPuestosLabel">Nuevo Puesto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_puesto" name="id_puesto" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="puesto" class="form-label">Nombre del Puesto</label>
                            <input type="text" class="form-control" id="puesto" name="puesto" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre del puesto.
                            </div>
                        </div>
                    </div>
                    
                    <hr>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="imagenPuesto" class="form-label">Imagen del Puesto</label>
                            <input type="file" class="form-control" id="imagenPuesto" name="imagenPuesto" accept="image/*" required>
                            <div class="invalid-feedback">
                                Por favor, seleccione una imagen.
                            </div>
                        </div>
                        
                        <div class="col-12 text-center">
                            <label class="form-label">Previsualización</label>
                            <img id="imgPreviewPuesto" src="https://placehold.co/150x150/EFEFEF/AAAAAA&text=Image" alt="Vista previa" class="img-thumbnail" style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%;">
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
  
  // --- Script de Validación de Bootstrap ---
  var forms = document.querySelectorAll('#formPuestos.needs-validation');
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
    
  // --- Script de Previsualización de Imagen ---
  var fileInputPuesto = document.getElementById('imagenPuesto');
  var imgPreviewPuesto = document.getElementById('imgPreviewPuesto');
  
  if (fileInputPuesto) {
      fileInputPuesto.addEventListener('change', function() {
          var file = this.files[0];
          
          if (file) {
              var reader = new FileReader();
              reader.onload = function(e) {
                  imgPreviewPuesto.src = e.target.result;
              }
              reader.readAsDataURL(file);
          } else {
              imgPreviewPuesto.src = 'https://placehold.co/100x100/EFEFEF/AAAAAA&text=Imagen';
          }
      });
  }
  
  $('#modalPuestos').on('hidden.bs.modal', function () {
      var form = $(this).find('form')[0];
      form.classList.remove('was-validated'); // Quita los mensajes de error
      form.reset(); // Resetea el formulario
      imgPreviewPuesto.src = 'https://placehold.co/100x100/EFEFEF/AAAAAA&text=Imagen'; // Resetea la imagen
      
      // Resetea los campos ocultos para modo "Crear"
      $('#id_puesto').val('');
      $('#accion').val('crear');
      $('#modalPuestosLabel').text('Nuevo Puesto');
      
      // Asegura que el input de imagen sea requerido para "Crear"
      $('#imagenPuesto').prop('required', true);
  });
  
})()
</script>