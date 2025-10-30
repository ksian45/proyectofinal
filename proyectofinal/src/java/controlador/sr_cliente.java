/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import modelo.Clientes;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "sr_cliente", value = "/sr_cliente")
public class sr_cliente extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // (Tu GET original - Sin cambios)
        response.sendRedirect("views/clientes.jsp"); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        
        // --- PREPARAR ---
        HttpSession session = request.getSession();
        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al intentar registrar.";
        
        Clientes cliente = new Clientes();
        int resultado = 0;

        try {
            // --- LEER ACCIÓN E ID ---
            // Leemos estos primero, porque "eliminar" solo necesita estos dos
            String accion = request.getParameter("accion");
            String idClienteStr = request.getParameter("id_cliente"); 

            // --- DECIDIR ACCIÓN ---
            if ("crear".equals(accion)) {
                
                // --- CREAR ---
                // (Leer todos los campos de crear)
                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String nit = request.getParameter("nit");
                String generoStr = request.getParameter("genero");
                String telefono = request.getParameter("telefono");
                String correo_electronico = request.getParameter("correo_electronico");

                // (Llenar objeto)
                cliente.setNombres(nombres);
                cliente.setApellidos(apellidos);
                cliente.setNit(nit);
                cliente.setGenero(Integer.parseInt(generoStr));
                cliente.setTelefono(telefono);
                cliente.setCorreo_electronico(correo_electronico);

                // (Fecha ingreso)
                String fechaIngreso = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                cliente.setFecha_ingreso(fechaIngreso);

                // (Llamar método)
                resultado = cliente.agregar(); 

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Cliente registrado con éxito!";
                } else {
                    mensajeTexto = "Error al guardar en la base de datos.";
                }

            } else if ("modificar".equals(accion)) {
                
                // --- MODIFICAR ---
                // (Leer todos los campos de modificar)
                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String nit = request.getParameter("nit");
                String generoStr = request.getParameter("genero");
                String telefono = request.getParameter("telefono");
                String correo_electronico = request.getParameter("correo_electronico");

                // (Llenar objeto)
                cliente.setNombres(nombres);
                cliente.setApellidos(apellidos);
                cliente.setNit(nit);
                cliente.setGenero(Integer.parseInt(generoStr));
                cliente.setTelefono(telefono);
                cliente.setCorreo_electronico(correo_electronico);
                
                // (Asignar ID)
                cliente.setId(Integer.parseInt(idClienteStr)); 

                // (Llamar método)
                resultado = cliente.modificar(); 

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Cliente actualizado con éxito!";
                } else {
                    mensajeTexto = "Error al actualizar en la base de datos.";
                }
                
            } else if ("eliminar".equals(accion)) { // <--- ¡¡AQUÍ ESTÁ LO NUEVO!!
                
                // --- ELIMINAR ---
                
                // (Asignar ID)
                cliente.setId(Integer.parseInt(idClienteStr)); 

                // (Llamar método)
                resultado = cliente.eliminar(); // LLAMA A TU MÉTODO "eliminar"

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Cliente eliminado exitosamente!";
                } else {
                    mensajeTexto = "Error al eliminar el cliente.";
                }
                
            } else {
                mensajeTexto = "Acción no reconocida: " + accion;
            }

        } catch (NumberFormatException e) {
            // --- CAPTURAR ERRORES ---
            System.err.println("Error de conversión de número en sr_cliente: " + e.getMessage());
            mensajeTexto = "Error en los datos numéricos.";
        } catch (Exception e) {
            System.err.println("Error inesperado en sr_cliente: " + e.getMessage());
            mensajeTexto = "Ocurrió un error inesperado en el servidor.";
            e.printStackTrace();
        }

        // --- 4. ENVIAR MENSAJES Y REDIRIGIR ---
        session.setAttribute("mensajeTipo", mensajeTipo);
        session.setAttribute("mensajeTexto", mensajeTexto);
        response.sendRedirect("views/clientes.jsp"); // TU RUTA
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet para manejar las operaciones CRUD de Clientes";
    }// </editor-fold>

}
