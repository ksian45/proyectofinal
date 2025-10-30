<%-- 
    Document   : modalMarcas
    Created on : 24/10/2025, 10:30:58 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalMarcas" tabindex="-1" aria-labelledby="modalMarcasLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form id="formMarcas" class="needs-validation" novalidate enctype="multipart/form-data">
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalMarcasLabel">Nueva Marca</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_marca" name="id_marca" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="marca" class="form-label">Nombre de la Marca</label>
                            <input type="text" class="form-control" id="marca" name="marca" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el nombre de la marca.
                            </div>
                        </div>
                    </div>
                    
                    <hr>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="imagenMarca" class="form-label">Logo de la Marca</Glabel>
                            <input type="file" class="form-control" id="imagenMarca" name="imagenMarca" accept="image/png" required>
                            <small class="form-text text-muted">
                                Solo se aceptan archivos en formato .PNG
                            </small>
                            <div class="invalid-feedback">
                                Por favor, seleccione un logo en formato PNG.
                            </div>
                        </div>
                        
                        <div class="col-12 text-center">
                            <label class="form-label">Previsualización</label>
                            <img id="imgPreviewMarca" src="https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG" alt="Vista previa" class="img-thumbnail" style="width: 150px; height: 150px; object-fit: contain;">
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
  'useS strict'
  
  // --- Script de Validación de Bootstrap ---
  var forms = document.querySelectorAll('#formMarcas.needs-validation');
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
  var fileInputMarca = document.getElementById('imagenMarca');
  var imgPreviewMarca = document.getElementById('imgPreviewMarca');
  
  if (fileInputMarca) {
      fileInputMarca.addEventListener('change', function() {
          var file = this.files[0];
          
          if (file) {
              var reader = new FileReader();
              reader.onload = function(e) {
                  imgPreviewMarca.src = e.target.result;
              }
              reader.readAsDataURL(file);
          } else {
              imgPreviewMarca.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG';
          }
      });
  }
  
  // --- Limpiar el modal al cerrarse (opcional pero recomendado) ---
  $('#modalMarcas').on('hidden.bs.modal', function () {
      var form = $(this).find('form')[0];
      form.classList.remove('was-validated'); // Quita los mensajes de error
      form.reset(); // Resetea el formulario
      imgPreviewMarca.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG'; // Resetea la imagen
      
      // Resetea los campos ocultos para modo "Crear"
      $('#id_marca').val('');
      $('#accion').val('crear');
      $('#modalMarcasLabel').text('Nueva Marca');
      
      // Asegura que el input de imagen sea requerido para "Crear"
      $('#imagenMarca').prop('required', true);
  });
  
})()
</script>
