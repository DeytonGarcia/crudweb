package pe.edu.vallegrande.crudweb07.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data @AllArgsConstructor @NoArgsConstructor @ToString
public class MenuDto {

    private int id;
    private String nombrePlato;
    private String descripcion;
    private BigDecimal precio;

    public MenuDto(String nombrePlato, String descripcion, BigDecimal precio) {
        this.nombrePlato = nombrePlato;
        this.descripcion = descripcion;
        this.precio = precio;


    }

}