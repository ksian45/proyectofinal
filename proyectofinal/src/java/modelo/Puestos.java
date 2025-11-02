/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
            // Tu query de leer está bien
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
       HashMap<String,String> drop  = new HashMap();
       try{
           cn  = new Conexion();
           cn.abrir_conexion();
           // Asumimos que no hay 'estado' en puestos, si lo hay, añade WHERE estado = 1
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
            // CORREGIDO: Asumimos id_puesto es AUTO_INCREMENT. Se añade la columna 'imagen'.
            String query="INSERT INTO db_supermercado.puestos (puesto, imagen) VALUES (?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            // Los parámetros ahora son 1 y 2
            parametro.setString(1, getPuesto());
            parametro.setString(2, getImagen());
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("Error agregar() puestos: " + ex.getMessage());
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

            // Lógica dinámica para modificar la imagen solo si se envía una nueva
            List<String> setClauses = new ArrayList<>();
            List<Object> params = new ArrayList<>();

            setClauses.add("puesto = ?"); params.add(getPuesto());
            
            // Solo añade 'imagen' al UPDATE si el servlet le pasó un nuevo nombre
            if (getImagen() != null && !getImagen().isEmpty()) {
                setClauses.add("imagen = ?");
                params.add(getImagen());
            }

            // Construye la query
            String query = "UPDATE db_supermercado.puestos SET " + String.join(", ", setClauses) + " WHERE id_puesto = ?;";
            
            parametro = cn.conexionBD.prepareStatement(query);

            // Asigna los parámetros dinámicamente
            int i = 1;
            for (Object p : params) {
                parametro.setObject(i++, p);
            }
            // Asigna el ID para el WHERE
            parametro.setInt(i, getId_puesto()); 
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println("Error modificar() puestos: " + ex.getMessage());
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
             System.out.println("Error eliminar() puestos: " + ex.getMessage());
             retorno = 0;
        }
        return retorno;
    }
}