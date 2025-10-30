/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Jruiz
 */



import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import java.util.Date;

public class JWTUtil {
    private static final String SECRET_KEY = "clave_secreta_segura";

    public static String generarToken(Usuario usuario) {
        Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
        return JWT.create()
            .withSubject(usuario.getUsername())
            .withClaim("rol", usuario.getRol())
            .withClaim("id_usuario", usuario.getId())
            .withIssuedAt(new Date())
            .withExpiresAt(new Date(System.currentTimeMillis() + 3600000)) // 1 hora
            .sign(algorithm);
    }

    public static DecodedJWT validarToken(String token) {
        Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
        return JWT.require(algorithm).build().verify(token);
    }
}


