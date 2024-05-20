package pe.edu.vallegrande.crudweb07.service;

import pe.edu.vallegrande.crudweb07.dto.MenuDto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class DB {
    private DB(){}

    static List<MenuDto> menuItems;
    static int contador;

    static {
        menuItems = new ArrayList<>();
        // Agregar los datos de la tabla MENU
        menuItems.add(new MenuDto(1, "Lomo Saltado", "Plato tradicional peruano", new BigDecimal("15.99")));
        menuItems.add(new MenuDto(2, "Ceviche", "Plato de pescado marinado en limón", new BigDecimal("12.50")));
        menuItems.add(new MenuDto(3, "Aji de Gallina", "Plato de pollo en una salsa de ají amarillo", new BigDecimal("10.75")));
        menuItems.add(new MenuDto(4, "Arroz con Pollo", "Plato de arroz cocido con pollo", new BigDecimal("9.99")));
        menuItems.add(new MenuDto(5, "Tallarines Verdes", "Plato de tallarines con salsa verde", new BigDecimal("8.95")));
        contador = 5; // Este valor se debe actualizar con el número de registros en la tabla MENU
    }
}
