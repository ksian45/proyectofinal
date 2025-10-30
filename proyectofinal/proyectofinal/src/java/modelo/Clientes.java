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
 * @author UMG
 */
public class Clientes extends Persona{
    private String nit, correo_electronico, fecha_ingreso;
    private Conexion cn;

    public Clientes(){}

    public Clientes(int id, String nombres, String apellidos, String nit, int genero, String telefono, String correo_electronico, String fecha_ingreso) {
        super(id, genero, nombres, apellidos, telefono);
        this.nit = nit;
        this.correo_electronico = correo_electronico;
        this.fecha_ingreso = fecha_ingreso;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getCorreo_electronico() {
        return correo_electronico;
    }

    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT clientes.id_cliente as id, clientes.nombres, clientes.apellidos, clientes.nit, CASE WHEN clientes.genero = 0 THEN 'Masculino' WHEN clientes.genero = 1 THEN 'Femenino' END as genero, clientes.telefono, clientes.correo_electronico, clientes.fecha_ingreso FROM db_supermercado.clientes;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id","nombres","apellidos","nit","genero","telefono","correo_electronico","fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos [] = new String[8];
            while (consulta.next()){
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("nit");
                datos[4] = consulta.getString("genero");
                datos[5] = consulta.getString("telefono");
                datos[6] = consulta.getString("correo_electronico");
                datos[7] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
                
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
        @Override
    public int agregar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="INSERT INTO db_supermercado.clientes (nombres, apellidos, nit, genero, telefono, correo_electronico, fecha_ingreso) VALUES (?,?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNit());
            parametro.setInt(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo_electronico());
            parametro.setString(7, getFecha_ingreso());
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }
    @Override
    public int modificar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="UPDATE db_supermercado.clientes SET nombres = ?, apellidos = ?, nit = ?, genero = ?, telefono = ?, correo_electronico = ?, fecha_ingreso = ? WHERE id_cliente = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNit());
            parametro.setInt(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo_electronico());
            parametro.setString(7, getFecha_ingreso());
            parametro.setInt(8, getId());
            
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }
    
    @Override
    public int eliminar(){
        int retorno = 0;
        try{
            cn = new Conexion();
            PreparedStatement parametro;
            String query="delete from clientes where id_cliente = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);            
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
                }
        return retorno;
    }
    
}
