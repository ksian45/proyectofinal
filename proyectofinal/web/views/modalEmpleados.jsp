<%-- 
    Document   : modalEmpleados
    Created on : 22/10/2025, 11:44:28 p. m.
    Author     : guich
--%>
<%@page import="modelo.Puestos" %>
<%@page  import="java.util.HashMap" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="modalEmpleados" tabindex="-1" aria-labelledby="modalEmpleadosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">

            <form action="<%= request.getContextPath() %>/sr_empleado" method="post" id="formEmpleados" class="needs-validation" novalidate>
                
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEmpleadosLabel">Nuevo Empleado</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="id_empleado" name="id_empleado" value="">
                    <input type="hidden" id="accion" name="accion" value="crear">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="nombres" class="form-label">Nombres</label>
                            <input type="text" class="form-control" id="nombres" name="nombres" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese los nombres.
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="apellidos" class="form-label">Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese los apellidos.
                            </div>
                        </div>
                        
                    </div>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="direccion" class="form-label">Dirección</label>
                            <input type="text" class="form-control" id="direccion" name="direccion" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese la dirección.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese un número de teléfono.
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="dpi" class="form-label">DPI</label>
                            <input type="text" class="form-control" id="dpi" name="dpi" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese el DPI.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
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

                        <div class="col-md-6 mb-3">
                            <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                            <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                            <div class="invalid-feedback">
                                Por favor, ingrese la fecha de nacimiento.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="puesto" class="form-label">Puesto</label>
                            <select class="form-control" id="puesto" name="puesto" required>
                                <option value="" selected disabled>Seleccione un puesto...</option>
                                <%
                                    Puestos puesto = new Puestos();
                                    HashMap<String,String> drop = puesto.leer_puesto();
                                    for(String i:drop.keySet()){
                                      out.println("<option value='"+ i +"'>"+ drop.get(i)+"</option>");
                                      }

                                %>
                            </select>
                            <div class="invalid-feedback">
                                Por favor, seleccione un puesto.
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="fechaInicioLabores" class="form-label">Inicio de Labores</labeL>
                            <input type="date" class="form-control" id="fechaInicioLabores" name="fechaInicioLabores" required>
                             <div class="invalid-feedback">
                                Por favor, ingrese la fecha de inicio de labores.
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
(function () {
  'use strict'
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
})()
</script>