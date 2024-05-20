package pe.edu.vallegrande.crudweb07.prueba;

import pe.edu.vallegrande.crudweb07.dto.MenuDto;
import pe.edu.vallegrande.crudweb07.service.MenuService;

import java.util.List;
public class prueba1 {
    public static void main(String[] args) {
        // Proceso
        MenuService service = new MenuService();
        List<MenuDto> lista = service.listar();
        // Reporte
        for(MenuDto bean: lista){
            System.out.println(bean);
        }
    }
}
