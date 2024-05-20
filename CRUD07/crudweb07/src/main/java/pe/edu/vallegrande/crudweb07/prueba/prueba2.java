package pe.edu.vallegrande.crudweb07.prueba;

import pe.edu.vallegrande.crudweb07.dto.MenuDto;
import pe.edu.vallegrande.crudweb07.service.MenuService;

public class prueba2 {

        public static void main(String[] args) {
            // Proceso
            MenuService service = new MenuService();
            MenuDto bean = service.agregar(new MenuDto());
            // Reporte
            System.out.println(bean);
        }
    }
