/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

// --- IMPORTS ---
import modelo.Productos;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "sr_producto", urlPatterns = {"/sr_producto"})
@MultipartConfig
public class sr_producto extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("views/productos.jsp"); // Asegúrate que esta ruta sea correcta
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Productos producto = new Productos();

        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al procesar la solicitud.";

        try {
            String accion = request.getParameter("accion");
            String idProductoStr = request.getParameter("id_producto");

            if ("eliminar".equals(accion)) {
                // --- LÓGICA DE CAMBIAR ESTADO ---
                producto.setId_producto(Integer.parseInt(idProductoStr));

                // --- CORREGIDO AQUÍ ---
                // Se llama al nuevo método cambiarEstado()
                if (producto.cambiarEstado() > 0) { 
                    mensajeTipo = "success";
                    // Mensaje actualizado
                    mensajeTexto = "¡Estado del producto cambiado exitosamente!";
                } else {
                    mensajeTexto = "Error al cambiar el estado del producto.";
                }

            } else if ("crear".equals(accion) || "modificar".equals(accion)) {

                // --- LÓGICA DE CREAR Y MODIFICAR ---

                String nombre = request.getParameter("producto");
                String idMarcaStr = request.getParameter("marca");
                String descripcion = request.getParameter("descripcion");
                String costoStr = request.getParameter("precio_costo");
                String ventaStr = request.getParameter("precio_venta");
                String stockStr = request.getParameter("stock");

                producto.setProducto(nombre);
                producto.setId_marca(Integer.parseInt(idMarcaStr));
                producto.setDescripcion(descripcion);
                producto.setPrecio_costo(Float.parseFloat(costoStr));
                producto.setPrecio_venta(Float.parseFloat(ventaStr));
                producto.setExistencia(Integer.parseInt(stockStr));

                // Manejo de la imagen
                Part filePart = request.getPart("imagen");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String nombreImagenDB = null;

                if (fileName != null && !fileName.isEmpty()) {
                    // SI SE SUBIÓ UNA NUEVA IMAGEN
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    nombreImagenDB = "producto_" + System.currentTimeMillis() + extension;
                    String uploadPath = getServletContext().getRealPath("/public/images/");
                    Path uploadDir = Paths.get(uploadPath);
                    if (!Files.exists(uploadDir)) { Files.createDirectories(uploadDir); }
                    try (InputStream input = filePart.getInputStream()) {
                        Path filePath = uploadDir.resolve(nombreImagenDB);
                        Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                    }
                    producto.setImagen(nombreImagenDB);

                } else if ("modificar".equals(accion)) {
                    // SI ES MODIFICAR y NO se subió imagen nueva
                    producto.setImagen(null); // La clase Productos.java sabrá no actualizarla
                }

                // Ejecutar la acción
                if ("crear".equals(accion)) {
                    String fechaIngreso = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    producto.setFecha_ingreso(fechaIngreso);

                    if (producto.agregar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Producto creado exitosamente!";
                    } else {
                        mensajeTexto = "Error al crear el producto.";
                    }

                } else { // "modificar"
                    producto.setId_producto(Integer.parseInt(idProductoStr));

                    if (producto.modificar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Producto actualizado exitosamente!";
                    } else {
                        mensajeTexto = "Error al actualizar el producto.";
                    }
                }
            } else {
                 mensajeTexto = "Acción no reconocida: " + accion;
            }

        } catch (Exception e) {
            mensajeTexto = "Error inesperado: " + e.getMessage();
            e.printStackTrace();
        }

        session.setAttribute("mensajeTipo", mensajeTipo);
        session.setAttribute("mensajeTexto", mensajeTexto);
        response.sendRedirect("views/productos.jsp"); // Redirige de vuelta
    }

    @Override
    public String getServletInfo() {
        // Descripción actualizada
        return "Servlet para CRUD de Productos";
    }

}