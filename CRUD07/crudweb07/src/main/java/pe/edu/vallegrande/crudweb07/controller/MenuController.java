package pe.edu.vallegrande.crudweb07.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.edu.vallegrande.crudweb07.dto.MenuDto;
import pe.edu.vallegrande.crudweb07.service.MenuService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet({"/ContMenuGetAll", "/ContMenuProcesar", "/ContMenuEliminar"})
public class MenuController extends HttpServlet {

    private final MenuService menuService = new MenuService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String path = request.getServletPath();
        switch (path) {
            case "/ContMenuGetAll":
                contGetAll(request, response);
                break;
            case "/ContMenuProcesar":
                contProcesar(request, response);
                break;
            case "/ContMenuEliminar":
                contEliminar(request, response);
                break;
        }
    }

    private void contProcesar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int accion = Integer.parseInt(request.getParameter("accion"));
        switch (accion) {
            case 1:
            case 2:
                agregarOActualizar(request, response);
                break;
        }
    }

    private void agregarOActualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // Obtener parámetros del formulario
        String idParam = request.getParameter("id");
        int id = idParam != null && !idParam.isEmpty() ? Integer.parseInt(idParam) : 0;
        String nombrePlato = request.getParameter("nombrePlato");
        String descripcion = request.getParameter("descripcion");
        BigDecimal precio = null;

        // Validar y convertir el precio
        String precioParam = request.getParameter("precio");
        if (precioParam != null && !precioParam.isEmpty()) {
            precio = new BigDecimal(precioParam);
        } else {
            // Manejar el caso en que el precio esté vacío
            // Podrías mostrar un mensaje de error o establecer un valor predeterminado
            precio = BigDecimal.ZERO;
        }

        // Crear objeto MenuDto con los datos del formulario
        MenuDto menuDto = new MenuDto(id, nombrePlato, descripcion, precio);

        // Verificar si el ID es igual a 0
        // Si es 0, significa que se está agregando un nuevo plato
        // Si no es 0, significa que se está actualizando un plato existente
        if (id == 0) {
            // Llamar al servicio para agregar el plato
            menuService.agregar(menuDto);
        } else {
            // Llamar al servicio para actualizar el plato
            menuService.actualizar(menuDto);
        }

        // Redireccionar a la página de lista de platos
        response.sendRedirect(request.getContextPath() + "/ContMenuGetAll");
    }

    private void contGetAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener lista de platos
        List<MenuDto> lista = menuService.listar();

        // Setear lista en el request
        request.setAttribute("lista", lista);

        // Redireccionar a la página de lista de platos
        RequestDispatcher rd = request.getRequestDispatcher("Menu.jsp");
        rd.forward(request, response);
    }

    private void contEliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Obtener ID del plato a eliminar
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);

            // Llamar al servicio para eliminar el plato
            menuService.eliminar(id);

            // Redireccionar a la página de lista de platos
            response.sendRedirect(request.getContextPath() + "/ContMenuGetAll");
        }
    }
}
