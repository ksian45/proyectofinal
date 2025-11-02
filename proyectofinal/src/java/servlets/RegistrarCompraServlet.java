/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;



import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.Conexion;
/**
 *
 * @author Jruiz
 */



@WebServlet("/registrarCompra")
public class RegistrarCompraServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;

        try {
            conn = Conexion.getConexion();
            conn.setAutoCommit(false);

            // ====== DATOS DEL MAESTRO ======
            String noOrdenStr = request.getParameter("no_orden_compra");
            int noOrden;

            if (noOrdenStr == null || noOrdenStr.isEmpty()) {
                // genera automáticamente el siguiente número
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT IFNULL(MAX(no_orden_compra),0)+1 FROM compras");
                rs.next();
                noOrden = rs.getInt(1);
            } else {
                noOrden = Integer.parseInt(noOrdenStr);
            }

            int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));
            String fechaOrden = request.getParameter("fecha_orden");
            int estado = Integer.parseInt(request.getParameter("estado"));

            // ====== INSERTAR COMPRA (MAESTRO) ======
            String sqlCompra = "INSERT INTO compras (no_orden_compra, id_proveedor, fecha_orden, fecha_ingreso, estado) "
                    + "VALUES (?, ?, ?, NOW(), ?)";
            PreparedStatement psCompra = conn.prepareStatement(sqlCompra, Statement.RETURN_GENERATED_KEYS);
            psCompra.setInt(1, noOrden);
            psCompra.setInt(2, idProveedor);
            psCompra.setString(3, fechaOrden);
            psCompra.setInt(4, estado);
            psCompra.executeUpdate();

            ResultSet rsCompra = psCompra.getGeneratedKeys();
            rsCompra.next();
            int idCompra = rsCompra.getInt(1);

            // ====== DETALLE (ARRAYS) ======
            String[] productos = request.getParameterValues("id_producto[]");
            String[] cantidades = request.getParameterValues("cantidad[]");
            String[] precios = request.getParameterValues("precio_costo_unitario[]");

            String sqlDetalle = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_costo_unitario) "
                    + "VALUES (?, ?, ?, ?)";
            PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);

            String sqlUpdateProd = "UPDATE productos SET existencia = existencia + ?, "
                    + "precio_costo = ?, precio_venta = (? * 1.25) WHERE id_producto = ?";
            PreparedStatement psUpdateProd = conn.prepareStatement(sqlUpdateProd);

            for (int i = 0; i < productos.length; i++) {
                int idProd = Integer.parseInt(productos[i]);
                int cant = Integer.parseInt(cantidades[i]);
                double costo = Double.parseDouble(precios[i]);

                // Insert detalle
                psDetalle.setInt(1, idCompra);
                psDetalle.setInt(2, idProd);
                psDetalle.setInt(3, cant);
                psDetalle.setDouble(4, costo);
                psDetalle.executeUpdate();

                // Actualizar producto
                psUpdateProd.setInt(1, cant);
                psUpdateProd.setDouble(2, costo);
                psUpdateProd.setDouble(3, costo);
                psUpdateProd.setInt(4, idProd);
                psUpdateProd.executeUpdate();
            }

            conn.commit();

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('Compra registrada correctamente');"
                    + "window.location='" + request.getContextPath() + "/views/compras.jsp';</script>");

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignored) {}

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<p style='color:red;'>Error al registrar la compra: "
                    + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
                if (conn != null) conn.close();
            } catch (SQLException ignored) {}
        }
    }
}
