<%-- 
    Document   : compras
    Created on : 20/10/2025, 10:48:28 p. m.
    Author     : guich
--%>

<%@ page import="java.sql.*, modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Mantenimiento Compras (Maestro-Detalle)</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
   
    
  <style>
    .container { margin-top: 24px; }
    table td, table th { vertical-align: middle; }
    .btn-small { padding: .25rem .5rem; font-size: .85rem; }
  </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
 <div class="wrapper">
    
    <a href="<%= request.getContextPath() %>/index.jsp" class="nav-link">
                          <i class="fas fa-home"></i>
                          <p>Menu Principal</p>
                          </a>
    
    
<div class="container">
  <h3>Compras — Registro Maestro/Detalle</h3>

  <!-- Enlace a mantenimiento proveedores -->
  <p>
    <a href="<%= request.getContextPath() %>/proveedores.jsp">Ir a Mantenimiento Proveedores</a>
  </p>

  <!-- FORMULARIO: envia arrays id_producto[], cantidad[], precio_costo_unitario[] -->
  <form action="<%= request.getContextPath() %>/registrarCompra" method="post" id="formCompra">
    <div class="card mb-3">
      <div class="card-body">
        <div class="form-row">
          <div class="form-group col-md-3">
            <label>No. Orden Compra</label>
            <!-- opcional: el servlet calcula el siguiente; el usuario puede ver/cambiar -->
            <input type="number" name="no_orden_compra" class="form-control" placeholder="(auto)" />
            <small class="form-text text-muted">Si deja vacío, se genera automáticamente.</small>
          </div>

          <div class="form-group col-md-4">
            <label>Proveedor</label>
           <select name="id_proveedor" id="id_proveedor" class="form-control" required>
  <option value="">-- Seleccione Proveedor --</option>
  <%
    try (Connection c = Conexion.getConexion();
         PreparedStatement ps = c.prepareStatement("SELECT * FROM proveedores LIMIT 100");
         ResultSet rs = ps.executeQuery()) {
         
         boolean tieneDatos = false;
         while (rs.next()) {
             tieneDatos = true;
             out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
         }

         if (!tieneDatos) {
             out.println("<option value=''>⚠️ No hay proveedores en la tabla</option>");
         }

    } catch (Exception e) {
        out.println("<option value=''>⚠️ Error: " + e.getMessage() + "</option>");
    }
  %>
</select>

          </div>

          <div class="form-group col-md-3">
            <label>Fecha de Orden</label>
            <input type="date" name="fecha_orden" class="form-control" value="<%= new java.sql.Date(System.currentTimeMillis()) %>" required>
          </div>

          <div class="form-group col-md-2">
            <label>Estado</label>
            <select name="estado" class="form-control">
              <option value="1" selected>Activo</option>
              <option value="0">Cancelado</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <!-- DETALLE: filas dinámicas -->
    <div class="card mb-3">
      <div class="card-header d-flex justify-content-between align-items-center">
        <span>Detalle de Compra</span>
        <div>
          <button type="button" id="btnAdd" class="btn btn-sm btn-primary">Agregar fila</button>
          <button type="button" id="btnRemove" class="btn btn-sm btn-danger">Eliminar fila</button>
        </div>
      </div>
      <div class="card-body p-0">
        <table class="table table-sm mb-0" id="tablaDetalle">
          <thead class="thead-light">
            <tr>
              <th style="width:42%;">Producto</th>
              <th style="width:14%;">Cantidad</th>
              <th style="width:20%;">Precio Costo Unitario (Q)</th>
              <th style="width:20%;">Subtotal (Q)</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <select name="id_producto[]" class="form-control producto-select" required>
                  <option value="">-- Seleccione --</option>
                  <%
                    try (Connection c = Conexion.getConexion();
                         PreparedStatement ps = c.prepareStatement("SELECT id_producto, producto, precio_costo FROM productos WHERE estado = 1 ORDER BY producto");
                         ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            out.println("<option value='" + rs.getInt("id_producto") + "' data-precio='" + rs.getBigDecimal("precio_costo") + "'>"
                                      + rs.getString("producto") + "</option>");
                        }
                    } catch (Exception e) {
                        out.println("<option value=''>Error cargando productos</option>");
                    }
                  %>
                </select>
              </td>
              <td><input type="number" name="cantidad[]" class="form-control cantidad" min="1" value="1" required></td>
              <td><input type="number" step="0.01" name="precio_costo_unitario[]" class="form-control precio" required></td>
              <td><input type="number" step="0.01" name="subtotal[]" class="form-control subtotal" readonly></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="card-footer text-right">
        <strong>Total Compra: Q <span id="totalCompra">0.00</span></strong>
        <input type="hidden" name="total_compra" id="total_compra" value="0.00" />
      </div>
    </div>

    <div class="text-right">
      <button type="submit" class="btn btn-success">Guardar Compra</button>
      
    </div>
  </form>

  <hr>

  <!-- LISTADO SIMPLE DE COMPRAS (MAESTRO) -->
  <h5 class="mt-4">Compras registradas (últimas 20)</h5>
  <table class="table table-sm table-bordered">
    <thead class="thead-dark">
      <tr>
        <th>No. Orden</th>
        <th>Proveedor</th>
        <th>Fecha Orden</th>
        <th>Total</th>
        <th>Estado</th>
      </tr>
    </thead>
    <tbody>
      <%
        // Lista rápida con JOIN para mostrar proveedor y total (suma de detalle por compra)
        String sqlList = "SELECT c.no_orden_compra, p.proveedor, c.fecha_orden, COALESCE(SUM(cd.cantidad * cd.precio_costo_unitario),0) AS total, c.estado "
                       + "FROM compras c LEFT JOIN compras_detalle cd ON c.id_compra = cd.id_compra "
                       + "LEFT JOIN proveedores p ON c.id_proveedor = p.id_proveedor "
                       + "GROUP BY c.id_compra ORDER BY c.fecha_ingreso DESC LIMIT 20";
        try (Connection c = Conexion.getConexion();
             PreparedStatement ps = c.prepareStatement(sqlList);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("no_orden_compra") + "</td>");
                out.println("<td>" + rs.getString("proveedor") + "</td>");
                out.println("<td>" + rs.getDate("fecha_orden") + "</td>");
                out.println("<td>Q " + String.format("%.2f", rs.getDouble("total")) + "</td>");
                out.println("<td>" + (rs.getInt("estado")==1 ? "Activo" : "Cancelado") + "</td>");
                out.println("</tr>");
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='5'>Error cargando compras</td></tr>");
        }
      %>
    </tbody>
  </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // funciones para agregar/quitar filas
  function recalcFila($tr) {
    const precio = parseFloat($tr.find('.precio').val() || 0);
    const cantidad = parseFloat($tr.find('.cantidad').val() || 0);
    const subtotal = precio * cantidad;
    $tr.find('.subtotal').val(subtotal.toFixed(2));
    recalcTotal();
  }

  function recalcTotal() {
    let total = 0;
    $('#tablaDetalle tbody tr').each(function() {
      total += parseFloat($(this).find('.subtotal').val() || 0);
    });
    $('#totalCompra').text(total.toFixed(2));
    $('#total_compra').val(total.toFixed(2));
  }

  $(document).ready(function() {
    // cuando cambia producto seleccionamos precio por defecto
    $(document).on('change', '.producto-select', function() {
      const precio = parseFloat($(this).find('option:selected').data('precio') || 0);
      const $row = $(this).closest('tr');
      $row.find('.precio').val(precio.toFixed(2));
      recalcFila($row);
    });

    // cuando cambia cantidad o precio recalcular fila
    $(document).on('input', '.cantidad, .precio', function() {
      recalcFila($(this).closest('tr'));
    });

    // agregar fila
    $('#btnAdd').click(function() {
      const $new = $('#tablaDetalle tbody tr:first').clone();
      $new.find('input').val('');
      $new.find('.cantidad').val(1);
      $('#tablaDetalle tbody').append($new);
    });

    // eliminar fila
    $('#btnRemove').click(function() {
      const $rows = $('#tablaDetalle tbody tr');
      if ($rows.length > 1) $rows.last().remove();
      recalcTotal();
    });

    // inicializar recalc
    $('#tablaDetalle tbody tr').each(function() {
      const $row = $(this);
      const precio = parseFloat($row.find('.producto-select option:selected').data('precio') || 0);
      if (precio) $row.find('.precio').val(precio.toFixed(2));
      recalcFila($row);
    });
  });
</script>

 <footer class="main-footer">
        <strong>Copyright &copy; 2025 <a href="#">Mi Empresa</a>.</strong> Todos los derechos reservados.
        <div class="float-right d-none d-sm-inline-block"><b>Versión</b> 1.0</div>
    </footer>
</div>

</body>
</html>
