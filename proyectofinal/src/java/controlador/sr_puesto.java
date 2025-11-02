/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

// --- IMPORTS ---
import modelo.Puestos; 
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "sr_puesto", urlPatterns = {"/sr_puesto"})
@MultipartConfig // Habilita la subida de archivos
public class sr_puesto extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige GET a la tabla
        response.sendRedirect("views/puestos.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Puestos puesto = new Puestos();

        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al procesar la solicitud.";

        try {
            // Leemos acción e ID
            String accion = request.getParameter("accion");
            String idPuestoStr = request.getParameter("id_puesto");

            if ("eliminar".equals(accion)) {
                // --- LÓGICA ELIMINAR (FÍSICO) ---
                puesto.setId_puesto(Integer.parseInt(idPuestoStr));
                if (puesto.eliminar() > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Puesto eliminado exitosamente!";
                } else {
                    mensajeTipo = "error";
                    mensajeTexto = "Error al eliminar el puesto. Es posible que esté en uso en la tabla 'Empleados'.";
                }

            } else if ("crear".equals(accion) || "modificar".equals(accion)) {
                // --- LÓGICA CREAR / MODIFICAR ---

                String nombre = request.getParameter("puesto");
                puesto.setPuesto(nombre);

                // Manejo de la imagen
                Part filePart = request.getPart("imagenPuesto"); // Asumo que el 'name' en el modal es "imagenPuesto"
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String nombreImagenDB = null;

                if (fileName != null && !fileName.isEmpty()) {
                    // SI SE SUBIÓ UNA NUEVA IMAGEN
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    nombreImagenDB = "puesto_" + System.currentTimeMillis() + extension;
                    
                    String uploadPath = getServletContext().getRealPath("/public/images/");
                    Path uploadDir = Paths.get(uploadPath);
                    if (!Files.exists(uploadDir)) { Files.createDirectories(uploadDir); }
                    
                    try (InputStream input = filePart.getInputStream()) {
                        Path filePath = uploadDir.resolve(nombreImagenDB);
                        Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                    }
                    puesto.setImagen(nombreImagenDB);
                }

                // Ejecutar la acción
                if ("crear".equals(accion)) {
                    if (puesto.agregar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Puesto creado exitosamente!";
                    } else {
                        mensajeTexto = "Error al crear el puesto.";
                    }
                } else { // "modificar"
                    puesto.setId_puesto(Integer.parseInt(idPuestoStr));
                    if (puesto.modificar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Puesto actualizado exitosamente!";
                    } else {
                        mensajeTexto = "Error al actualizar el puesto.";
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
        response.sendRedirect("views/puestos.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet para CRUD de Puestos";
    }
}
