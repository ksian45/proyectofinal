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
import modelo.Usuario;
import modelo.UsuarioDAO;
import modelo.JWTUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener datos del formulario
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarCredenciales(username, password);

        // Validar credenciales gey el que lo lea 
        if (usuario != null && usuario.isActivo()) {

            // Generar el token JWT
            String token = JWTUtil.generarToken(usuario);

            // Crear sesión
            HttpSession session = request.getSession(true);
            session.setAttribute("token", token);
            session.setAttribute("rol", usuario.getRol());
            session.setAttribute("usuario", usuario.getUsername());
            

            // Redirección según nuestro rol  
            
            switch (usuario.getRol()) {
                case "super_admin":
                    response.sendRedirect("views/superAdminDashboard.jsp");
                    break;
                case "admin":
                case "empleado":
                    response.sendRedirect("index.jsp");
                    break;
                default:
                    response.sendRedirect("views/login.jsp?error=rolDesconocido");
                    break;
            }
        } else {
            response.sendRedirect("views/login.jsp?error=credenciales");
        }
    }
}

    
