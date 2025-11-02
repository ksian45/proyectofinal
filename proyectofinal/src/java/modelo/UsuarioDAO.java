/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Jruiz
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    private final Connection conn;

    public UsuarioDAO() {
        // ✅ Usa la conexión centralizada desde modelo.Conexion
        conn = Conexion.getConexion();
    }

    // 🔐 Validar credenciales del usuario
    public Usuario validarCredenciales(String username, String password) {
        String sql = "SELECT id_usuario, username, id_rol, activo FROM usuarios WHERE username = ? AND password_hash = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password); // ⚠️ Si usas hash, aquí debes comparar el hash

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id_usuario");
                String rol = rs.getString("id_rol");
                boolean activo = rs.getBoolean("activo");

                return new Usuario(id, username, rol, activo);
            }
        } catch (SQLException e) {
            System.out.println("❌ Error al validar credenciales:");
            e.printStackTrace();
        }
        return null;
    }

    // 👤 Crear nuevo usuario
    public boolean crearUsuario(String username, String password, String rol) {
        String sql = "INSERT INTO usuarios (username, password_hash, id_rol, activo, fecha_creacion) VALUES (?, ?, ?, 1, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password); // ⚠️ Aquí puedes cifrar con BCrypt si lo deseas
            stmt.setString(3, rol);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("❌ Error al crear usuario:");
            e.printStackTrace();
        }
        return false;
    }
}
