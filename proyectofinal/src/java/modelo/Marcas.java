/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Marcas {
    private int id_marca;
    private String marca, imagen;
    private Conexion cn;

    public Marcas() {}

    public Marcas(int id_marca, String marca, String imagen) {
        this.id_marca = id_marca;
        this.marca = marca;
        this.imagen = imagen;
    }

    // Getters y Setters
    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    // =============================
    // MÉTODOS CRUD
    // =============================

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();

            String query = "SELECT id_marca AS id, marca, imagen FROM db_supermercado.marcas;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

            String encabezado[] = {"id", "marca", "imagen"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[3];

            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("marca");
                datos[2] = consulta.getString("imagen");
                tabla.addRow(datos);
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al leer marcas: " + ex.getMessage());
        }
        return tabla;
    }

    public int agregar() {
        int retorno = 0;
        try {
            cn = new Conexion();
            cn.abrir_conexion();

            String query = "INSERT INTO db_supermercado.marcas (marca, imagen) VALUES (?, ?);";
            PreparedStatement parametro = cn.conexionBD.prepareStatement(query);

            parametro.setString(1, getMarca());
            parametro.setString(2, getImagen());

            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al agregar marca: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    public int modificar() {
    int retorno = 0;
    try {
        cn = new Conexion();
        cn.abrir_conexion();

        String query;
        PreparedStatement parametro;

        // Si la imagen no es nula ni vacía, actualizamos también la columna imagen
        if (getImagen() != null && !getImagen().isEmpty()) {
            query = "UPDATE db_supermercado.marcas SET marca = ?, imagen = ? WHERE id_marca = ?;";
            parametro = cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getMarca());
            parametro.setString(2, getImagen());
            parametro.setInt(3, getId_marca());
        } else {
            // Si la imagen es nula o vacía, solo actualizamos la marca
            query = "UPDATE db_supermercado.marcas SET marca = ? WHERE id_marca = ?;";
            parametro = cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getMarca());
            parametro.setInt(2, getId_marca());
        }

        retorno = parametro.executeUpdate();
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error al modificar marca: " + ex.getMessage());
        retorno = 0;
    }
    return retorno;
}


    public int eliminar() {
        int retorno = 0;
        try {
            cn = new Conexion();
            cn.abrir_conexion();

            String query = "DELETE FROM db_supermercado.marcas WHERE id_marca = ?;";
            PreparedStatement parametro = cn.conexionBD.prepareStatement(query);

            parametro.setInt(1, getId_marca());
            retorno = parametro.executeUpdate();

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar marca: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    public String obtener_imagen(int idMarca) {
        String imagenActual = null;
        try {
            cn = new Conexion();
            cn.abrir_conexion();

            String query = "SELECT imagen FROM db_supermercado.marcas WHERE id_marca = ?;";
            PreparedStatement parametro = cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, idMarca);
            ResultSet rs = parametro.executeQuery();

            if (rs.next()) {
                imagenActual = rs.getString("imagen");
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al obtener imagen actual: " + ex.getMessage());
        }
        return imagenActual;
    }
}

