/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import javax.swing.table.DefaultTableModel;

/**
 *
 * @author UMG
 */
public class main {
	public static void main(String[] args) {
            
            Clientes test = new Clientes();
        DefaultTableModel modelo = test.leer();

        for (int i = 0; i < modelo.getRowCount(); i++) {
            for (int j = 0; j < modelo.getColumnCount(); j++) {
                System.out.print(modelo.getValueAt(i, j) + "\t");
            }
            System.out.println();
        }
                
	}
}
