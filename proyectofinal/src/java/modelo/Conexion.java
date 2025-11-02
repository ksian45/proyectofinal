/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de conexión a base de datos MySQL en Azure.
 * Proporciona métodos para obtener, abrir, cerrar y probar la conexión.
 * 
 * @author UMG
 */
public class Conexion {

    // Parámetros de conexión
    private final String puerto = "3306";
    private final String bd = "db_supermercado";
    private final String urlConexion = String.format(
        "jdbc:mysql://server-university.mysql.database.azure.com:%s/%s?serverTimezone=UTC",
        puerto, bd
    );
    private final String usuario = "conexionbd";
    private final String contra = "c0nect0r123***";
    private final String jdbc = "com.mysql.cj.jdbc.Driver";

    // Conexión persistente
    public Connection conexionBD;

    /**
     * Método estático para obtener una conexión directa.
     * Útil para DAOs y Servlets.
     */
    public static Connection getConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String puerto = "3306";
            String bd = "db_supermercado";
            String url = String.format(
                "jdbc:mysql://server-university.mysql.database.azure.com:%s/%s?serverTimezone=UTC",
                puerto, bd
            );
            String usuario = "conexionbd";
            String contra = "c0nect0r123***";
            return DriverManager.getConnection(url, usuario, contra);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error en getConexion(): " + ex.getMessage());
            return null;
        }
    }

    /**
     * Abre una conexión persistente y la guarda en el atributo conexionBD.
     */
    public void abrir_conexion() {
        try {
            Class.forName(jdbc);
            conexionBD = DriverManager.getConnection(urlConexion, usuario, contra);
            System.out.println("Conexión exitosa...");
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error al abrir conexión: " + ex.getMessage());
        }
    }

    /**
     * Cierra la conexión persistente si está abierta.
     */
    public void cerrar_conexion() {
        try {
            if (conexionBD != null && !conexionBD.isClosed()) {
                conexionBD.close();
                System.out.println("Conexión cerrada.");
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar conexión: " + ex.getMessage());
        }
    }

    /**
     * Método de prueba para verificar si la conexión funciona correctamente.
     */
    public void prueba_conexion() {
        abrir_conexion();
        try {
            if (conexionBD != null && !conexionBD.isClosed()) {
                System.out.println("Prueba: conexión exitosa.");
            } else {
                System.out.println("Prueba: conexión fallida.");
            }
        } catch (SQLException ex) {
            System.out.println("Error en prueba_conexion(): " + ex.getMessage());
        }
        cerrar_conexion();
    }
}

