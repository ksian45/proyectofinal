/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author UMG
 */
public class Puestos {
    private int id_puesto;
    private String puesto, imagen;
    private Conexion cn;

    public Puestos(){}
    public Puestos(int id_puesto, String puesto, String imagen) {
        this.id_puesto = id_puesto;
        this.puesto = puesto;
        this.imagen = imagen;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT Puestos.id_puesto as id, puestos.puesto, puestos.imagen FROM db_supermercado.puestos;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id","puesto", "imagen"};
            tabla.setColumnIdentifiers(encabezado);
            String datos [] = new String[3];
            while (consulta.next()){
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("puesto");
                datos[2] = consulta.getString("imagen");
                tabla.addRow(datos);
                
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
    
    public HashMap leer_puesto(){
     HashMap<String,String> drop  = new HashMap(); // llave, valor
     try{
         cn  = new Conexion();
         cn.abrir_conexion();
         String query = "select id_puesto ,puesto from puestos;";
         ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
                
            while(consulta.next()){
                drop.put(consulta.getString("id_puesto"), consulta.getString("puesto"));
            }
         cn.cerrar_conexion();
     }catch(SQLException ex){
       System.out.println("Error: " + ex.getMessage());
     }
     return drop;
    }
    
    public int agregar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="INSERT INTO db_supermercado.puestos (id_puesto, puesto) VALUES (?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, getId_puesto());
            parametro.setString(2, getPuesto());
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }
    
    public int modificar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="UPDATE db_supermercado.puestos SET id_puesto = ?, puesto = ? WHERE id_puesto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, getId_puesto());
            parametro.setString(2, getPuesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }
    
    public int eliminar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="delete from puestos where id_puesto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);            
            parametro.setInt(1, getId_puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }

}