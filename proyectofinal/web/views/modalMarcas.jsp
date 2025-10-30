<%-- 
    Document   : modalMarcas
    Created on : 24/10/2025, 10:30:58 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalMarcas" tabindex="-1" aria-labelledby="modalMarcasLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<%= request.getContextPath() %>/sr_marca" method="post" id="formMarcas"
                  class="needs-validation" novalidate enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalMarcasLabel">Nueva Marca</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <input type="hidden" id="id_marca" name="id_marca" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">
                    <input type="hidden" id="imagenActual" name="imagenActual" value=""> <!-- Para mantener imagen al modificar -->

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="marca" class="form-label">Nombre de la Marca</label>
                            <input type="text" class="form-control" id="marca" name="marca" required>
                            <div class="invalid-feedback">Por favor, ingrese el nombre de la marca.</div>
                        </div>
                    </div>

                    <hr>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="imagenMarca" class="form-label">Logo de la Marca</label>
                            <input type="file" class="form-control" id="imagenMarca" name="imagenMarca" accept="image/png">
                            <small class="form-text text-muted">Solo se aceptan archivos en formato .PNG</small>
                            <div class="invalid-feedback">Por favor, seleccione un logo en formato PNG.</div>
                        </div>

                        <div class="col-12 text-center">
                            <label class="form-label">Previsualización</label>
                            <img id="imgPreviewMarca" src="https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG"
                                 alt="Vista previa" class="img-thumbnail"
                                 style="width: 150px; height: 150px; object-fit: contain;">
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="btnGuardar">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
(function () {
  'use strict';

  // --- Validación Bootstrap ---
  var forms = document.querySelectorAll('#formMarcas.needs-validation');
  Array.prototype.slice.call(forms).forEach(function (form) {
    form.addEventListener('submit', function (event) {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.classList.add('was-validated');
    }, false);
  });

  // --- Previsualización de imagen ---
  var fileInput = document.getElementById('imagenMarca');
  var preview = document.getElementById('imgPreviewMarca');
  if (fileInput) {
    fileInput.addEventListener('change', function() {
      var file = this.files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function(e) { preview.src = e.target.result; };
        reader.readAsDataURL(file);
      } else {
        preview.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG';
      }
    });
  }

  // --- Limpiar modal al cerrarse ---
  $('#modalMarcas').on('hidden.bs.modal', function () {
    var form = $(this).find('form')[0];
    form.classList.remove('was-validated');
    form.reset();
    preview.src = 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG';
    $('#id_marca').val('');
    $('#accion').val('crear');
    $('#imagenActual').val('');
    $('#modalMarcasLabel').text('Nueva Marca');
    $('#imagenMarca').prop('required', true); // obligatorio al crear
  });

  // --- Función para abrir modal con datos al modificar ---
  window.abrirModalMarca = function(id, nombre, rutaImagen) {
    $('#modalMarcas').modal('show');
    $('#id_marca').val(id);
    $('#marca').val(nombre);
    $('#accion').val('modificar');
    $('#modalMarcasLabel').text('Editar Marca');
    $('#imagenActual').val(rutaImagen); // ruta de la imagen existente
    preview.src = rutaImagen ? rutaImagen : 'https://placehold.co/150x150/EFEFEF/AAAAAA&text=Logo+PNG';
    $('#imagenMarca').prop('required', false); // no obligatorio al modificar
  };

})();
</script>



