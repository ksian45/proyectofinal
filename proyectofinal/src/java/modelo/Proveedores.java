/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author guich
 */
public class Proveedores {
    // Añadimos el campo estado
    private int id_proveedor, estado;
    private String proveedor, nit, direccion, telefono;
    private Conexion cn;

    public Proveedores(){}
    public Proveedores(int id_proveedor, int estado, String proveedor, String nit, String direccion, String telefono) {
        this.id_proveedor = id_proveedor;
        this.estado = estado;
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    public int getId_proveedor() { return id_proveedor; }
    public void setId_proveedor(int id_proveedor) { this.id_proveedor = id_proveedor; }
    public int getEstado() { return estado; }
    public void setEstado(int estado) { this.estado = estado; }
    public String getProveedor() { return proveedor; }
    public void setProveedor(String proveedor) { this.proveedor = proveedor; }
    public String getNit() { return nit; }
    public void setNit(String nit) { this.nit = nit; }
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT p.id_proveedor as id, p.proveedor, p.nit, p.direccion, p.telefono, p.estado " +
                           "FROM db_supermercado.proveedores as p;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            
            String encabezado[] = {"id","proveedor","nit","direccion","telefono", "estado"};
            tabla.setColumnIdentifiers(encabezado);
            
            
            String datos [] = new String[6];
            while (consulta.next()){
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("proveedor");
                datos[2] = consulta.getString("nit");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                datos[5] = consulta.getString("estado"); 
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error leer() proveedores: " + ex.getMessage());
        }
        return tabla;
    }
    
    public int agregar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            
            String query="INSERT INTO proveedores (proveedor,nit,direccion,telefono,estado) VALUES (?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, 1); 
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("Error agregar() proveedores: " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }
    
    public int modificar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
          
            String query="UPDATE proveedores SET proveedor = ?, nit = ?, direccion = ?, telefono = ? WHERE id_proveedor = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, getId_proveedor()); 
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("Error modificar() proveedores: " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }
    
    //  cambiarEstado() 
    public int cambiarEstado(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            // Invierte el estado actual (1 a 0, 0 a 1)
            String query="UPDATE proveedores SET estado = NOT estado WHERE id_proveedor = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, getId_proveedor());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("Error cambiarEstado() proveedores: " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }
    
  
}