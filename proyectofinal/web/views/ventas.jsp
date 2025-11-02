<%-- 
    Document   : ventas
    Created on : 20/10/2025, 10:44:51 p. m.
    Author     : guich
--%>

<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Venta</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2.0/dist/css/adminlte.min.css">

    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f1f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            background: white;
            margin: 50px auto;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            color: #555;
        }
        select, input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }
        button {
            display: block;
            margin: 25px auto 0;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            background: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.2s;
        }
        
        #tablaVentas th, #tablaVentas td {
            text-align: center;
            vertical-align: middle;
        }
        button:hover {
            background: #0056b3;
        }
        .total-box {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 6px;
            margin-top: 10px;
            font-weight: bold;
            text-align: right;
            color: #222;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    
    
    
    
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="#" class="nav-link font-weight-bold">MI EMPRESA</a>
            </li>
           <!--
            <li class="nav-item d-none d-sm-inline-block">
                <a href="home" class="nav-link">Inicio</a>
             </li>
             -->
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#" role="button"><i class="fas fa-user-circle"></i> Mi Perfil</a>
            </li>
        </ul>
    </nav>

    <aside class="main-sidebar sidebar-dark-primary elevation-4">
         <a href="#" class="brand-link">
            <span class="brand-text font-weight-light">Supermercado</span>
         </a>

        <div class="sidebar">
            <nav class="mt-2" style="flex-grow: 1;">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    </ul>
            </nav>
            <nav class="mt-auto mb-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item"><hr class="bg-secondary mx-2 my-1"></li>
                    <li class="nav-item">
                        
                        <a href="<%= request.getContextPath() %>/index.jsp" class="nav-link">
                          <i class="fas fa-home"></i>
                          <p>Menu Principal</p>
                          </a>


                        <!--
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
                -->
            </nav>
        </div>
    </aside>



<div class="container">
    <h1>Registrar Venta</h1>
    <form action="<%= request.getContextPath() %>/registrarVenta" method="post">

        <!-- Cliente -->
        <label for="id_cliente">Cliente:</label>
        <select name="id_cliente" id="id_cliente" required>
            <option value="">Seleccione un cliente</option>
            <%
                try (Connection conn = Conexion.getConexion();
                     PreparedStatement ps = conn.prepareStatement("SELECT id_cliente, nombres, apellidos FROM clientes");
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        int id = rs.getInt("id_cliente");
                        String nombre = rs.getString("nombres") + " " + rs.getString("apellidos");
                        out.println("<option value='" + id + "'>" + nombre + "</option>");
                    }
                } catch (Exception e) {
                    out.println("<option disabled>Error cargando clientes</option>");
                }
            %>
        </select>

        <!-- Empleado -->
        <label for="id_empleado">Empleado:</label>
        <select name="id_empleado" id="id_empleado" required>
            <option value="">Seleccione un empleado</option>
            <%
                try (Connection conn = Conexion.getConexion();
                     PreparedStatement ps = conn.prepareStatement("SELECT id_empleado, nombres, apellidos FROM empleados");
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        int id = rs.getInt("id_empleado");
                        String nombre = rs.getString("nombres") + " " + rs.getString("apellidos");
                        out.println("<option value='" + id + "'>" + nombre + "</option>");
                    }
                } catch (Exception e) {
                    out.println("<option disabled>Error cargando empleados</option>");
                }
            %>
        </select>

        <!-- Producto -->
        <label for="id_producto">Producto:</label>
        <select name="id_producto" id="producto" required>
            <option value="">Seleccione un producto</option>
            <%
                try (Connection conn = Conexion.getConexion();
                     PreparedStatement ps = conn.prepareStatement("SELECT id_producto, producto, precio_venta FROM productos");
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
                        int id = rs.getInt("id_producto");
                        String nombre = rs.getString("producto");
                        double precio = rs.getDouble("precio_venta");
                        out.println("<option value='" + id + "' data-precio='" + precio + "'>" + nombre + " (Q" + precio + ")</option>");
                    }
                } catch (Exception e) {
                    out.println("<option disabled>Error cargando productos</option>");
                }
            %>
        </select>

        <label for="cantidad">Cantidad:</label>
        <input type="number" name="cantidad" id="cantidad" min="1" required>

        <label for="precio">Precio Unitario (Q):</label>
        <input type="number" name="precio" id="precio" step="0.01" readonly>

        <div class="total-box">
            Total Venta: Q <span id="total_display">0.00</span>
        </div>
        <input type="hidden" name="total_venta" id="total_venta" value="0.00">

        <button type="submit">Registrar Venta y Generar PDF</button>
    </form>
</div>

<script>
    const productoSelect = document.getElementById("producto");
    const cantidadInput = document.getElementById("cantidad");
    const precioInput = document.getElementById("precio");
    const totalInput = document.getElementById("total_venta");
    const totalDisplay = document.getElementById("total_display");

    function actualizarTotal() {
        const precio = parseFloat(productoSelect.selectedOptions[0]?.dataset.precio || 0);
        const cantidad = parseFloat(cantidadInput.value || 0);
        const total = precio * cantidad;

        precioInput.value = precio.toFixed(2);
        totalInput.value = total.toFixed(2);
        totalDisplay.textContent = total.toFixed(2);
    }

    productoSelect.addEventListener("change", actualizarTotal);
    cantidadInput.addEventListener("input", actualizarTotal);
</script>
</body>
</html>
