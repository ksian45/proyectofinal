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

public class ReporteDTO {
    private List<String> columnas;
    private List<List<String>> filas;

    public ReporteDTO() {
        this.columnas = new ArrayList<>();
        this.filas = new ArrayList<>();
    }

    // Getters y Setters
    public List<String> getColumnas() {
        return columnas;
    }

    public void setColumnas(List<String> columnas) {
        this.columnas = columnas;
    }

    public List<List<String>> getFilas() {
        return filas;
    }

    public void setFilas(List<List<String>> filas) {
        this.filas = filas;
    }

    // Método para agregar una fila
    public void agregarFila(List<String> fila) {
        this.filas.add(fila);
    }

    // Método opcional para verificar si hay datos
    public boolean tieneDatos() {
        return !filas.isEmpty();
    }

    // Método opcional para limpiar el contenido
    public void limpiar() {
        columnas.clear();
        filas.clear();
    }
}
