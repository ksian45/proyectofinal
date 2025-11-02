/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Proveedores;

/**
 *
 * @author guich
 */
@WebServlet(name = "sr_proveedor", urlPatterns = {"/sr_proveedor"})
public class sr_proveedor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige GET a la tabla
        response.sendRedirect("views/proveedores.jsp"); // Asegúrate que la ruta sea correcta
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Proveedores proveedor = new Proveedores();

        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al procesar la solicitud.";

        try {
            // Leemos acción e ID
            String accion = request.getParameter("accion");
            String idProveedorStr = request.getParameter("id_proveedor");

            if ("eliminar".equals(accion)) { // "eliminar" ahora significa cambiar estado
                // --- LÓGICA CAMBIAR ESTADO ---
                proveedor.setId_proveedor(Integer.parseInt(idProveedorStr));

                // Llama al método corregido
                if (proveedor.cambiarEstado() > 0) {
                    mensajeTipo = "success";
                    // Mensaje actualizado
                    mensajeTexto = "¡Estado del proveedor cambiado exitosamente!";
                } else {
                    mensajeTexto = "Error al cambiar el estado del proveedor.";
                }

            } else if ("crear".equals(accion) || "modificar".equals(accion)) {
                // --- LÓGICA CREAR / MODIFICAR ---

                // Leer datos
                String nombre = request.getParameter("proveedor");
                String nit = request.getParameter("nit");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

                // Asignar datos
                proveedor.setProveedor(nombre);
                proveedor.setNit(nit);
                proveedor.setDireccion(direccion);
                proveedor.setTelefono(telefono);

                // Ejecutar
                if ("crear".equals(accion)) {
                    if (proveedor.agregar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Proveedor creado exitosamente!";
                    } else {
                        mensajeTexto = "Error al crear el proveedor.";
                    }
                } else { // "modificar"
                    proveedor.setId_proveedor(Integer.parseInt(idProveedorStr));
                    if (proveedor.modificar() > 0) {
                        mensajeTipo = "success";
                        mensajeTexto = "¡Proveedor actualizado exitosamente!";
                    } else {
                        mensajeTexto = "Error al actualizar el proveedor.";
                    }
                }
            } else {
                 mensajeTexto = "Acción no reconocida: " + accion;
            }

        } catch (NumberFormatException e){
             mensajeTexto = "Error: El ID del proveedor no es un número válido.";
             System.err.println("Error NumberFormatException en sr_proveedor: " + e.getMessage());
        }
        catch (Exception e) {
            mensajeTexto = "Error inesperado: " + e.getMessage();
            e.printStackTrace();
        }

        session.setAttribute("mensajeTipo", mensajeTipo);
        session.setAttribute("mensajeTexto", mensajeTexto);
        response.sendRedirect("views/proveedores.jsp"); // Redirige de vuelta
    }

    @Override
    public String getServletInfo() {
        return "Servlet para CRUD de Proveedores con borrado lógico";
    }

}

