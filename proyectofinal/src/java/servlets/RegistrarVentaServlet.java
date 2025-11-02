/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Conexion;



/**
 *
 * @author Jruiz
 */


@WebServlet("/registrarVenta")
public class RegistrarVentaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        ByteArrayOutputStream pdfBytes = null;
        boolean generarPDF = false;

        try {
            conn = Conexion.getConexion();
            conn.setAutoCommit(false);

            //  Leer parámetros del formulario
            int idCliente = Integer.parseInt(request.getParameter("id_cliente"));
            int idEmpleado = Integer.parseInt(request.getParameter("id_empleado"));
            int idProducto = Integer.parseInt(request.getParameter("id_producto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            double precioUnitario = Double.parseDouble(request.getParameter("precio"));
            double totalVenta = cantidad * precioUnitario;

            //  Generar número de factura y serie automática
            int noFactura = 0;
            String serie = "A";

            String sqlMaxFactura = "SELECT COALESCE(MAX(no_factura), 999) + 1 AS siguiente FROM ventas";
            PreparedStatement psMax = conn.prepareStatement(sqlMaxFactura);
            ResultSet rsMax = psMax.executeQuery();
            if (rsMax.next()) {
                noFactura = rsMax.getInt("siguiente");
            }

            // Insertar venta
            String sqlVenta = """
                INSERT INTO ventas (no_factura, serie, id_cliente, id_empleado, fecha_factura, fecha_ingreso, estado)
                VALUES (?, ?, ?, ?, CURDATE(), NOW(), 1)
            """;
            PreparedStatement psVenta = conn.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS);
            psVenta.setInt(1, noFactura);
            psVenta.setString(2, serie);
            psVenta.setInt(3, idCliente);
            psVenta.setInt(4, idEmpleado);
            psVenta.executeUpdate();

            ResultSet rs = psVenta.getGeneratedKeys();
            int idVenta = 0;
            if (rs.next()) {
                idVenta = rs.getInt(1);
            } else {
                throw new SQLException("No se pudo obtener el ID de la venta generada.");
            }

            //  Insertar detalle
            String sqlDetalle = """
    INSERT INTO ventas_detalle (
        id_venta,         -- ID de la venta principal
        id_producto,      -- ID del producto vendido
        cantidad,         -- Cantidad vendida
        precio_unitario,  -- Precio por unidad en el momento de la venta
        total_venta       -- Subtotal (cantidad × precio_unitario)
    )
    VALUES (?, ?, ?, ?, ?)
""";

            PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);
            psDetalle.setInt(1, idVenta);
            psDetalle.setInt(2, idProducto);
            psDetalle.setInt(3, cantidad);
            psDetalle.setDouble(4, precioUnitario);
            psDetalle.setDouble(5, totalVenta);
            psDetalle.executeUpdate();

            // 🔹 Actualizar existencias
            String sqlStock = "UPDATE productos SET existencia = existencia - ? WHERE id_producto = ?";
            PreparedStatement psStock = conn.prepareStatement(sqlStock);
            psStock.setInt(1, cantidad);
            psStock.setInt(2, idProducto);
            psStock.executeUpdate();

            //  Obtener nombres del cliente y empleado (JOIN)
  String sqlInfo = """
    SELECT 
        c.nombres AS cliente_nombre,
        c.apellidos AS cliente_apellido,
        e.nombres AS empleado_nombre,
        e.apellidos AS empleado_apellido,
        p.producto AS nombre_producto,
        m.marca AS nombre_marca
    FROM ventas v
    JOIN clientes c ON v.id_cliente = c.id_cliente
    JOIN empleados e ON v.id_empleado = e.id_empleado
    JOIN ventas_detalle dv ON v.id_venta = dv.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    JOIN marcas m ON p.id_marca = m.id_marca
    WHERE v.id_venta = ?
""";


            PreparedStatement psInfo = conn.prepareStatement(sqlInfo);
            psInfo.setInt(1, idVenta);
            ResultSet rsInfo = psInfo.executeQuery();
            

            String nombreCliente = "Desconocido";
            String nombreEmpleado = "Desconocido";
            String nombreProducto = "Producto"; // Valor por defecto

          if (rsInfo.next()) {
           nombreCliente = rsInfo.getString("cliente_nombre") + " " + rsInfo.getString("cliente_apellido");
           nombreEmpleado = rsInfo.getString("empleado_nombre") + " " + rsInfo.getString("empleado_apellido");
           nombreProducto = rsInfo.getString("nombre_producto"); // ✅ Solo aquí puedes acceder al dato
           }


            conn.commit();

            //  Generar PDF
            pdfBytes = new ByteArrayOutputStream();
            Document documento = new Document();
            PdfWriter.getInstance(documento, pdfBytes);
            documento.open();

            // Encabezado bonito
            documento.add(new Paragraph("FACTURA DE VENTA", new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD)));
            documento.add(new Paragraph("Serie: " + serie + " | Factura No.: " + noFactura));
            documento.add(new Paragraph("Fecha: " + new java.util.Date()));
            documento.add(new Paragraph("Cliente: " + nombreCliente));
            documento.add(new Paragraph("Empleado: " + nombreEmpleado));
            documento.add(new Paragraph(" "));
            
            // Tabla con detalle
            PdfPTable tabla = new PdfPTable(4);
            tabla.setWidthPercentage(100);
            // Encabezados
            tabla.addCell("Producto");
            tabla.addCell("Cantidad");
            tabla.addCell("Precio Unitario");
            tabla.addCell("Subtotal");

            // Datos
          tabla.addCell(nombreProducto);
          tabla.addCell(String.valueOf(cantidad));
          tabla.addCell("Q " + String.format("%.2f", precioUnitario));
          tabla.addCell("Q " + String.format("%.2f", totalVenta));
            documento.add(tabla);
            documento.add(new Paragraph(" "));
            documento.add(new Paragraph("TOTAL: Q " + String.format("%.2f", totalVenta),
                    new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD)));

            documento.close();
            generarPDF = true;

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignored) {}

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<p style='color:red;'>Error al registrar la venta: " + e.getMessage() + "</p>");
            return;
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
                if (conn != null) conn.close();
            } catch (SQLException ignored) {}
        }

        //  Enviar el PDF al navegador
        if (generarPDF && pdfBytes != null) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=factura.pdf");
            OutputStream os = response.getOutputStream();
            pdfBytes.writeTo(os);
            os.flush();
            os.close();
        }
    }
}