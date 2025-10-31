/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filters;

/**
 *
 * @author Jruiz
 */

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.exceptions.JWTVerificationException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*") // Intercepta todas las rutas
public class AuthFilter implements Filter {

    private static final String SECRET_KEY = "clave_secreta_segura";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();

        // Permitir acceso libre a login.jsp y LoginServlet
        if (path.contains("login.jsp") || path.contains("LoginServlet")) {
            chain.doFilter(request, response);
            return;
        }

        if (session != null && session.getAttribute("token") != null) {
            String token = (String) session.getAttribute("token");

            try {
                Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
                DecodedJWT jwt = JWT.require(algorithm).build().verify(token);

                String rol = jwt.getClaim("rol").asString();
                req.setAttribute("rol", rol); // Puedes usar esto en tus JSPs

                chain.doFilter(request, response); // Token válido, continúa
            } catch (JWTVerificationException e) {
                res.sendRedirect("views/login.jsp?error=token_invalido");
            }
        } else {
            res.sendRedirect("views/login.jsp?error=no_autenticado");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void destroy() {}
}
