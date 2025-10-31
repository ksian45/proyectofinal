/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Jruiz
 */

public class Usuario {
    private int id;
    private String username;
    private String rol;
    private boolean activo;

    public Usuario(int id, String username, String rol, boolean activo) {
        this.id = id;
        this.username = username;
        this.rol = rol;
        this.activo = activo;
    }

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getRol() { return rol; }
    public boolean isActivo() { return activo; }
}
