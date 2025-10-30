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
import java.util.*;

public class MenuDAO {
    private final Connection conn;

    public MenuDAO() {
        // ✅ Usa la conexión centralizada
        conn = Conexion.getConexion();
    }

    // 🌳 Obtener menú completo en forma de árbol
    public List<Menu> obtenerMenuCompleto() {
        List<Menu> modulosRaiz = new ArrayList<>();
        Map<Integer, Menu> mapa = new HashMap<>();

        String sql = "SELECT id, nombre, url, id_padre FROM menu";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            // Cargar todos los registros en el mapa
            while (rs.next()) {
                Menu m = new Menu();
                m.setId(rs.getInt("id"));
                m.setNombre(rs.getString("nombre"));
                m.setUrl(rs.getString("url"));
                int padre = rs.getInt("id_padre");
                m.setIdPadre(rs.wasNull() ? null : padre);

                mapa.put(m.getId(), m);
            }

            // Construir jerarquía
            for (Menu m : mapa.values()) {
                if (m.getIdPadre() == null) {
                    modulosRaiz.add(m);
                } else {
                    Menu padre = mapa.get(m.getIdPadre());
                    if (padre != null) {
                        padre.getHijos().add(m);
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al obtener menú:");
            e.printStackTrace();
        }

        return modulosRaiz;
    }
}
