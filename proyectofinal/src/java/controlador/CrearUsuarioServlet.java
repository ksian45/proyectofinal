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
import modelo.UsuarioDAO;

@WebServlet("/CrearUsuarioServlet")
public class CrearUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validar que el usuario actual tenga rol de super_admin
        String rol = (String) request.getSession().getAttribute("rol");
        if (rol == null || !"super_admin".equals(rol)) {
            response.sendRedirect("views/login.jsp?error=permiso");
            return;
        }

        // Obtener datos del formulario
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nuevoRol = request.getParameter("rol");

        // Validar campos básicos
        if (username == null || password == null || nuevoRol == null ||
            username.isEmpty() || password.isEmpty() || nuevoRol.isEmpty()) {
            response.sendRedirect("views/crearUsuario.jsp?error=campos");
            return;
        }

        // Crear usuario en la base de datos
        UsuarioDAO dao = new UsuarioDAO();
        dao.crearUsuario(username, password, nuevoRol);

        // Redirigir al dashboard con mensaje de éxito
        response.sendRedirect("views/login.jsp?mensaje=creado");
    }
}
