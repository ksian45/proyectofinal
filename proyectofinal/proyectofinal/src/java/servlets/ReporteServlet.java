/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Jruiz
 */

@WebServlet("/reporte")
public class ReporteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipoReporte");
        List<List<String>> filas = new ArrayList<>();
        List<String> columnas = new ArrayList<>();

        // Obtener conexión
        try (Connection con = Conexion.getConexion()) {

            String sql = switch (tipo) {
                case "ventas" -> "SELECT id_venta, no_factura, serie, fecha_factura, id_cliente, id_empleado, fecha_ingreso FROM ventas";
                case "compras" -> "SELECT id_compra, no_orden_compra, id_proveedor, fecha_orden, fecha_ingreso FROM compras";
                case "producto" -> "SELECT id_producto, id_marca, descripcion, existencia, fecha_ingreso, estado FROM productos";
                default -> null;
            };

            if (sql != null) {
                try (PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    ResultSetMetaData meta = rs.getMetaData();

                    // Obtener nombres de columnas
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        columnas.add(meta.getColumnName(i));
                    }

                    // Obtener filas gey el que lo leea
                    while (rs.next()) {
                        List<String> fila = new ArrayList<>();
                        for (int i = 1; i <= meta.getColumnCount(); i++) {
                            fila.add(rs.getString(i));
                        }
                        filas.add(fila);
                    }
                }

                request.setAttribute("columnas", columnas);
                request.setAttribute("filas", filas);
            } else {
                request.setAttribute("error", "Tipo de reporte no válido");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al generar el reporte: " + e.getMessage());
        }

        request.getRequestDispatcher("/views/reportes.jsp").forward(request, response);
    }
}

