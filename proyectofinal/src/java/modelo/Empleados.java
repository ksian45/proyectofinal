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
public class Empleados extends Persona{
    private String direccion, fecha_nacimiento, fecha_inicio_labores, fecha_ingreso;
    private int id_puesto, dpi;
    private Conexion cn;

    public Empleados(){}

    public Empleados(int id, String nombres, String apellidos, String direccion, String telefono, int dpi, int genero, String fecha_nacimiento, int id_puesto, String fecha_inicio_labores, String fecha_ingreso) {
        super(id, genero, nombres, apellidos, telefono);
        this.direccion = direccion;
        this.fecha_nacimiento = fecha_nacimiento;
        this.fecha_inicio_labores = fecha_inicio_labores;
        this.fecha_ingreso = fecha_ingreso;
        this.id_puesto = id_puesto;
        this.dpi = dpi;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getFecha_inicio_labores() {
        return fecha_inicio_labores;
    }

    public void setFecha_inicio_labores(String fecha_inicio_labores) {
        this.fecha_inicio_labores = fecha_inicio_labores;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public int getDpi() {
        return dpi;
    }

    public void setDpi(int dpi) {
        this.dpi = dpi;
    } 
    
    public String getFecha_ingreso(){
        return fecha_ingreso;
    }
    
    public void setFecha_ingreso(String fecha_ingreso){
        this.fecha_ingreso = fecha_ingreso;
    }
    
    
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT e.id_empleado as id,e.nombres,e.apellidos,e.direccion,e.telefono,e.dpi,CASE WHEN e.genero = 0 THEN 'Masculino' WHEN e.genero = 1 THEN 'Femenino' END as genero,e.fecha_nacimiento,p.puesto, e.id_puesto,e.fecha_inicio_labores,e.fecha_ingreso FROM empleados as e inner join puestos as p on e.id_puesto = p.id_puesto;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id","nombres","apellidos","direccion","telefono","dpi","genero","fecha_nacimiento","puesto","id_puesto","fecha_inicio_labores","fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos [] = new String[12];
            while (consulta.next()){
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                datos[5] = consulta.getString("dpi");
                datos[6] = consulta.getString("genero");
                datos[7] = consulta.getString("fecha_nacimiento");
                datos[8] = consulta.getString("puesto");
                datos[9] = consulta.getString("id_puesto");
                datos[10] = consulta.getString("fecha_inicio_labores");
                datos[11] = consulta.getString("fecha_ingreso");
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
            String query="INSERT INTO db_supermercado.empleados (nombres, apellidos, direccion, telefono, dpi, genero, fecha_nacimiento, id_puesto, fecha_inicio_labores, fecha_ingreso) VALUES (?,?,?,?,?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, getDpi());
            parametro.setInt(6, getGenero());
            parametro.setString(7, getFecha_nacimiento());
            parametro.setInt(8, getId_puesto());
            parametro.setString(9, getFecha_inicio_labores());
            parametro.setString(10, getFecha_ingreso());
            
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
            String query="UPDATE db_supermercado.empleados SET id_empleado = ?, nombres = ?, apellidos = ?, direccion = ?, telefono = ?, dpi = ?, genero = ?, fecha_nacimiento =?, id_puesto = ?, fecha_inicio_labores = ?, fecha_ingreso = ? WHERE id_empleado = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, getDpi());
            parametro.setInt(6, getGenero());
            parametro.setString(7, getFecha_nacimiento());
            parametro.setInt(8, getId_puesto());
            parametro.setString(9, getFecha_inicio_labores());
            parametro.setString(10, getFecha_ingreso());
            parametro.setInt(11, getId());
            
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
            String query="delete from empleados where id_empleado = ?;";
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
