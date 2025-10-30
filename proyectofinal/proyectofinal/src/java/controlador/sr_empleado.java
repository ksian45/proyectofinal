/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import modelo.Empleados;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "sr_empleado", value = "/sr_empleado")
public class sr_empleado extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // (Tu GET original - Sin cambios)
        response.sendRedirect("views/empleados.jsp"); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        
        // --- PREPARAR ---
        HttpSession session = request.getSession();
        String mensajeTipo = "error";
        String mensajeTexto = "Ocurrió un error al intentar registrar.";
        
        Empleados empleado = new Empleados();
        int resultado = 0;

        try {
            // --- LEER ACCIÓN E ID ---
            // Leemos estos primero, porque "eliminar" solo necesita estos dos
            String accion = request.getParameter("accion");
            String idEmpleadoStr = request.getParameter("id_empleado"); 

            // --- DECIDIR ACCIÓN ---
            if ("crear".equals(accion)) {
                
                // --- CREAR ---
                // (Leer todos los campos de crear)
                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String dpi = request.getParameter("dpi");
                String generoStr = request.getParameter("genero");
                String fechaNacimiento = request.getParameter("fechaNacimiento");
                String idPuestoStr = request.getParameter("puesto");
                String fechaInicioLabores = request.getParameter("fechaInicioLabores");

                // (Llenar objeto)
                empleado.setNombres(nombres);
                empleado.setApellidos(apellidos);
                empleado.setDireccion(direccion);
                empleado.setTelefono(telefono);
                empleado.setDpi(dpi);
                empleado.setGenero(Integer.parseInt(generoStr));
                empleado.setFecha_nacimiento(fechaNacimiento);
                empleado.setId_puesto(Integer.parseInt(idPuestoStr));
                empleado.setFecha_inicio_labores(fechaInicioLabores);

                // (Fecha ingreso)
                String fechaIngreso = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                empleado.setFecha_ingreso(fechaIngreso);

                // (Llamar método)
                resultado = empleado.agregar(); 

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Empleado registrado con éxito!";
                } else {
                    mensajeTexto = "Error al guardar en la base de datos.";
                }

            } else if ("modificar".equals(accion)) {
                
                // --- MODIFICAR ---
                // (Leer todos los campos de modificar)
                String nombres = request.getParameter("nombres");
                String apellidos = request.getParameter("apellidos");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String dpi = request.getParameter("dpi");
                String generoStr = request.getParameter("genero");
                String fechaNacimiento = request.getParameter("fechaNacimiento");
                String idPuestoStr = request.getParameter("puesto");
                String fechaInicioLabores = request.getParameter("fechaInicioLabores");

                // (Llenar objeto)
                empleado.setNombres(nombres);
                empleado.setApellidos(apellidos);
                empleado.setDireccion(direccion);
                empleado.setTelefono(telefono);
                empleado.setDpi(dpi);
                empleado.setGenero(Integer.parseInt(generoStr));
                empleado.setFecha_nacimiento(fechaNacimiento);
                empleado.setId_puesto(Integer.parseInt(idPuestoStr));
                empleado.setFecha_inicio_labores(fechaInicioLabores);
                
                // (Asignar ID)
                empleado.setId(Integer.parseInt(idEmpleadoStr)); 

                // (Llamar método)
                resultado = empleado.modificar(); 

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Empleado actualizado con éxito!";
                } else {
                    mensajeTexto = "Error al actualizar en la base de datos.";
                }
                
            } else if ("eliminar".equals(accion)) { // <--- ¡¡AQUÍ ESTÁ LO NUEVO!!
                
                // --- ELIMINAR ---
                
                // (Asignar ID)
                empleado.setId(Integer.parseInt(idEmpleadoStr)); 

                // (Llamar método)
                resultado = empleado.eliminar(); // LLAMA A TU MÉTODO "eliminar"

                if (resultado > 0) {
                    mensajeTipo = "success";
                    mensajeTexto = "¡Empleado eliminado exitosamente!";
                } else {
                    mensajeTexto = "Error al eliminar el empleado.";
                }
                
            } else {
                mensajeTexto = "Acción no reconocida: " + accion;
            }

        } catch (NumberFormatException e) {
            // --- CAPTURAR ERRORES ---
            System.err.println("Error de conversión de número en sr_empleado: " + e.getMessage());
            mensajeTexto = "Error en los datos numéricos.";
        } catch (Exception e) {
            System.err.println("Error inesperado en sr_empleado: " + e.getMessage());
            mensajeTexto = "Ocurrió un error inesperado en el servidor.";
            e.printStackTrace();
        }

        // --- 4. ENVIAR MENSAJES Y REDIRIGIR ---
        session.setAttribute("mensajeTipo", mensajeTipo);
        session.setAttribute("mensajeTexto", mensajeTexto);
        response.sendRedirect("views/empleados.jsp"); // TU RUTA
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet para manejar las operaciones CRUD de Empleados";
    }// </editor-fold>

}