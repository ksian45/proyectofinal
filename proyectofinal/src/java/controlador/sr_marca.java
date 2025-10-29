/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import modelo.Marcas;

@WebServlet(name = "sr_marca", value = "/sr_marca")
@MultipartConfig
public class sr_marca extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("views/marcas.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al procesar la solicitud.";

        Marcas brand = new Marcas();
        int resultado = 0;

        try {
            String accion = request.getParameter("accion");
            String idMarcaStr = request.getParameter("id_marca");
            String marca = request.getParameter("marca");

            // 📁 Directorio dinámico donde se guardarán las imágenes
            String uploadDir = getServletContext().getRealPath("/public/images");

            // Asegurarse de que el directorio exista
            File directorio = new File(uploadDir);
            if (!directorio.exists()) {
                directorio.mkdirs();
            }

            // Ruta relativa que se guardará en BD
            String rutaRelativa = null;

            // 📸 Obtener la imagen subida (si existe)
            Part filePart = null;
            try {
                filePart = request.getPart("imagenMarca");
            } catch (Exception e) {
                System.err.println("No se recibió archivo de imagen: " + e.getMessage());
            }

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Validar extensión PNG
                if (!fileName.toLowerCase().endsWith(".png")) {
                    session.setAttribute("mensajeTipo", "error");
                    session.setAttribute("mensajeTexto", "Solo se permiten archivos PNG.");
                    response.sendRedirect("views/marcas.jsp");
                    return;
                }

                // Guardar archivo con nombre único
                String nuevoNombre = System.currentTimeMillis() + "_" + fileName;
                File archivoDestino = new File(directorio, nuevoNombre);
                filePart.write(archivoDestino.getAbsolutePath());

                // Ruta que se guarda en la base de datos
                rutaRelativa = "public/images/" + nuevoNombre;
            }

            // --- CRUD ---
            if ("crear".equals(accion)) {
                brand.setMarca(marca);
                brand.setImagen(rutaRelativa != null ? rutaRelativa : "public/images/default.png");
                resultado = brand.agregar();

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Marca registrada con éxito!";
                } else {
                    mensajeTexto = "Error al guardar la marca en la base de datos.";
                }

            } else if ("modificar".equals(accion)) {
                brand.setId_marca(Integer.parseInt(idMarcaStr));
                brand.setMarca(marca);

                if (rutaRelativa != null) {
                    // Se subió una nueva imagen → actualizar ruta
                    brand.setImagen(rutaRelativa);
                } else {
                    // No se subió nueva imagen → mantener la actual
                    String imagenActual = brand.obtener_imagen(Integer.parseInt(idMarcaStr));
                    brand.setImagen(imagenActual);
                }

                resultado = brand.modificar();

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Marca actualizada correctamente!";
                } else {
                    mensajeTexto = "Error al actualizar la marca.";
                }

            } else if ("eliminar".equals(accion)) {
                brand.setId_marca(Integer.parseInt(idMarcaStr));
                resultado = brand.eliminar();

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Marca eliminada correctamente!";
                } else {
                    mensajeTexto = "Error al eliminar la marca.";
                }

            } else {
                mensajeTexto = "Acción no reconocida: " + accion;
            }

        } catch (NumberFormatException e) {
            System.err.println("Error de número: " + e.getMessage());
            mensajeTexto = "ID inválido.";
        } catch (Exception e) {
            e.printStackTrace();
            mensajeTexto = "Error interno: " + e.getMessage();
        }

        // 📩 Mensajes y redirección
        session.setAttribute("mensajeTipo", mensajeTipo);
        session.setAttribute("mensajeTexto", mensajeTexto);
        response.sendRedirect("views/marcas.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejar las operaciones CRUD de Marcas con carga de imágenes (ruta dinámica)";
    }
}


