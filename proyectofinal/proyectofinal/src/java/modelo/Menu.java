/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Jruiz
 */
import java.util.ArrayList;
import java.util.List;

public class Menu {
    private int id;
    private String nombre;
    private String url;
    private Integer idPadre;
    private List<Menu> hijos = new ArrayList<>();

    // Constructor vacío
    public Menu() {}

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public Integer getIdPadre() { return idPadre; }
    public void setIdPadre(Integer idPadre) { this.idPadre = idPadre; }

    public List<Menu> getHijos() { return hijos; }
    public void setHijos(List<Menu> hijos) { this.hijos = hijos; }
}
