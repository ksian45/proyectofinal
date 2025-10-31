/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author UMG
 */
public class Productos {
    private int id_producto, id_marca, existencia, estado; // Estado 1=Activo, 0=Inactivo
    private float precio_costo, precio_venta;
    private String producto, descripcion, imagen, fecha_ingreso;
    private Conexion cn;

    public Productos(){}
    public Productos(int id_producto, int id_marca, int existencia, int estado, float precio_costo, float precio_venta, String producto, String descripcion, String imagen, String fecha_ingreso) {
        this.id_producto = id_producto;
        this.id_marca = id_marca;
        this.existencia = existencia;
        this.estado = estado;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.producto = producto;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.fecha_ingreso = fecha_ingreso;
    }

    // --- Getters y Setters ---
    public int getId_producto() { return id_producto; }
    public void setId_producto(int id_producto) { this.id_producto = id_producto; }
    public int getId_marca() { return id_marca; }
    public void setId_marca(int id_marca) { this.id_marca = id_marca; }
    public int getExistencia() { return existencia; }
    public void setExistencia(int existencia) { this.existencia = existencia; }
    public int getEstado() { return estado; }
    public void setEstado(int estado) { this.estado = estado; }
    public float getPrecio_costo() { return precio_costo; }
    public void setPrecio_costo(float precio_costo) { this.precio_costo = precio_costo; }
    public float getPrecio_venta() { return precio_venta; }
    public void setPrecio_venta(float precio_venta) { this.precio_venta = precio_venta; }
    public String getProducto() { return producto; }
    public void setProducto(String producto) { this.producto = producto; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }
    public String getFecha_ingreso() { return fecha_ingreso; }
    public void setFecha_ingreso(String fecha_ingreso) { this.fecha_ingreso = fecha_ingreso; }


    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            // --- CORREGIDO: Quitado WHERE estado=1, añadido p.estado al SELECT ---
            String query = "SELECT p.id_producto, p.producto, m.marca, p.descripcion, p.imagen, p.precio_costo, p.precio_venta, p.existencia, p.fecha_ingreso, p.id_marca, p.estado " + // Se añade p.estado
                           "FROM productos as p inner join marcas as m on p.id_marca = m.id_marca;"; // Sin WHERE
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

            // --- CORREGIDO: Añadido "estado" al encabezado ---
            String encabezado[] = {"id","producto","marca","descripcion","imagen","precio_costo","precio_venta","existencia","fecha_ingreso", "id_marca", "estado"};
            tabla.setColumnIdentifiers(encabezado);

            // --- CORREGIDO: Array de 11 datos ---
            String datos [] = new String[11];

            while (consulta.next()){
                datos[0] = consulta.getString("id_producto");
                datos[1] = consulta.getString("producto");
                datos[2] = consulta.getString("marca");
                datos[3] = consulta.getString("descripcion");
                datos[4] = consulta.getString("imagen");
                datos[5] = consulta.getString("precio_costo");
                datos[6] = consulta.getString("precio_venta");
                datos[7] = consulta.getString("existencia");
                datos[8] = consulta.getString("fecha_ingreso");
                datos[9] = consulta.getString("id_marca");
                // --- CORREGIDO: Leer estado ---
                datos[10] = consulta.getString("estado"); // Índice 10
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("(leer productos): " + ex.getMessage());
        }
        return tabla;
    }


    public int agregar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            // Asumiendo id_producto es AUTO_INCREMENT, estado se añade al final
            String query="INSERT INTO db_supermercado.productos (producto, id_marca, descripcion, imagen, precio_costo, precio_venta, existencia, fecha_ingreso, estado) VALUES (?,?,?,?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);

            parametro.setString(1, getProducto());
            parametro.setInt(2, getId_marca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setFloat(5, getPrecio_costo());
            parametro.setFloat(6, getPrecio_venta());
            parametro.setInt(7, getExistencia());
            parametro.setString(8, getFecha_ingreso());
            parametro.setInt(9, 1); // Estado por defecto 1 (Activo)

            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("(agregar productos): " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }


    public int modificar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            PreparedStatement parametro;

            List<String> setClauses = new ArrayList<>();
            List<Object> params = new ArrayList<>();

            setClauses.add("producto = ?"); params.add(getProducto());
            setClauses.add("id_marca = ?"); params.add(getId_marca());
            setClauses.add("descripcion = ?"); params.add(getDescripcion());
            setClauses.add("precio_costo = ?"); params.add(getPrecio_costo());
            setClauses.add("precio_venta = ?"); params.add(getPrecio_venta());
            setClauses.add("existencia = ?"); params.add(getExistencia());
            // No actualizamos fecha_ingreso, id_producto ni estado aquí

            if (getImagen() != null && !getImagen().isEmpty()) {
                setClauses.add("imagen = ?");
                params.add(getImagen());
            }

            String query = "UPDATE db_supermercado.productos SET " + String.join(", ", setClauses) + " WHERE id_producto = ?;";

            parametro = cn.conexionBD.prepareStatement(query);

            int i = 1;
            for (Object p : params) {
                parametro.setObject(i++, p);
            }
            parametro.setInt(i, getId_producto()); // ID para el WHERE

            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch(SQLException ex) {
            System.out.println("(modificar productos): " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }


    // --- CORREGIDO: Renombrado a cambiarEstado y lógica de UPDATE NOT estado ---
    public int cambiarEstado(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            // Invierte el estado actual (1 a 0, 0 a 1)
            String query="UPDATE db_supermercado.productos SET estado = NOT estado WHERE id_producto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, getId_producto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("(cambiarEstado productos): " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }

}