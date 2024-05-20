package pe.edu.vallegrande.crudweb07.prueba;

import pe.edu.vallegrande.crudweb07.dto.MenuDto;
import pe.edu.vallegrande.crudweb07.service.MenuService;

import java.math.BigDecimal;

public class prueba4 {
    public static void main(String[] args) {
        try {
            // Datos del plato
            String nombrePlato = "Lomo Saltado";
            String descripcion = "Plato tradicional peruano";
            BigDecimal precio = new BigDecimal("15.99");

            // Crear el objeto del plato
            MenuDto plato = new MenuDto(nombrePlato, descripcion, precio);

            // Proceso: Crear el plato en el servicio
            MenuService service = new MenuService();
            plato = service.agregar(plato);

            // Reporte: Mostrar la información del plato creado
            System.out.println("Plato creado exitosamente:");
            System.out.println("ID: " + plato.getId());
            System.out.println("Nombre del plato: " + plato.getNombrePlato());
            System.out.println("Descripción: " + plato.getDescripcion());
            System.out.println("Precio: " + plato.getPrecio());
        } catch (RuntimeException e) {
            System.err.println("Error al crear el plato: " + e.getMessage());
        }
    }
}

