<%@ page import="pe.edu.vallegrande.crudweb07.dto.MenuDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    List<MenuDto> lista;
    lista = (List<MenuDto>) request.getAttribute("lista");
    String titulo = null;
    if(request.getAttribute("titulo") != null){
        titulo = request.getAttribute("titulo").toString();
    };
    MenuDto bean2 = null;
    if(titulo!=null){
        bean2 = (MenuDto) request.getAttribute("bean");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <title>CRUD DE MENU</title>
</head>
<body>

<div class="container">

    <h1>CRUD DE MENU</h1>

    <div class="card" id="divListado">
        <div class="card-header">
            LISTADO DE PLATOS
            <button type="button" class="btn btn-primary float-right" id="btnNuevo">Nuevo</button>
        </div>
        <div class="card-body">

            <table class="table">
                <thead class="thead-light">
                <tr>
                    <th>ID</th>
                    <th>NOMBRE DEL PLATO</th>
                    <th>DESCRIPCIÓN</th>
                    <th>PRECIO</th>
                    <th>ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <% if(lista != null) { %>
                <% for(MenuDto bean: lista) { %>

                <tr>
                    <td><%=bean.getId()%></td>
                    <td><%=bean.getNombrePlato()%></td>
                    <td><%=bean.getDescripcion()%></td>
                    <td><%=bean.getPrecio()%></td>
                    <td>
                        <a href="#" class="btn btn-warning btn-sm" onclick="editarPlato(<%=bean.getId()%>, '<%=bean.getNombrePlato()%>', '<%=bean.getDescripcion()%>', <%=bean.getPrecio()%>)">Editar</a>
                        <a href="#" class="btn btn-danger btn-sm" onclick="eliminarPlato(<%=bean.getId()%>)">Eliminar</a>
                    </td>
                </tr>
                <% } %>
                <% } %>

                </tbody>
            </table>
        </div>

    </div>


    <div class="card" id="divEditRecord" style="display: none;">
        <div class="card-header" id="tituloFormulario">
            {accion} PLATO
        </div>
        <div class="card-body">
            <form method="post" action="ContProcesar" id="formularioPlato">
                <div class="form-group row">
                    <div class="col-sm-10">
                        <label>ID</label>
                        <input type="hidden" id="id" name="id" value="0">
                        <input type="hidden" id="accion" name="accion" value="0">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="nombrePlato" class="col-sm-2 col-form-label">Nombre del Plato</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="nombrePlato" name="nombrePlato" placeholder="Nombre del plato">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="descripcion" class="col-sm-2 col-form-label">Descripción</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Descripción del plato">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="precio" class="col-sm-2 col-form-label">Precio</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="precio" name="precio" placeholder="Precio del plato">
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-10 offset-sm-2">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <button type="button" class="btn btn-secondary" onclick="fnBtnCancelar()">Cancelar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <% if(titulo != null) { %>
    <h2><%=titulo%></h2>
    <p>ID: <%=bean2.getId()%></p>
    <p>NOMBRE DEL PLATO: <%=bean2.getNombrePlato()%></p>
    <p>DESCRIPCIÓN: <%=bean2.getDescripcion()%></p>
    <p>PRECIO: <%=bean2.getPrecio()%></p>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>

<script>
    // Definiendo cosas
    /*
      Acciones
        accion=1: Crear plato
        accion=2: Actualizar plato
        accion=3: Eliminar plato
     */
    // Variables
    var accion = "";

    // Ready function
    $(function() {
        $("#btnNuevo").click(fnBtnNuevo);
        $("#btnCancelar").click(fnBtnCancelar);
    });

    // Funciones para los botones

    function fnBtnNuevo(){
        $("#divListado").hide();
        $("#divEditRecord").show();
        initFormulario(1);
    }

    function fnBtnCancelar(){
        $("#divListado").show();
        $("#divEditRecord").hide();
    }

    function editarPlato(id, nombrePlato, descripcion, precio){
        $("#divListado").hide();
        $("#divEditRecord").show();
        initFormulario(2);
        $("#id").val(id);
        $("#nombrePlato").val(nombrePlato);
        $("#descripcion").val(descripcion);
        $("#precio").val(precio);
    }

    function eliminarPlato(id){
        if(confirm("¿Está seguro de eliminar este plato?")){
            window.location.href = "ContEliminar?id=" + id;
        }
    }




    // Otras funciones

    function initFormulario(accion){
        switch(accion){
            case 1:
                $("#tituloFormulario").html("NUEVO PLATO");
                $("#accion").val(1)
                break;
            case 2:
                $("#tituloFormulario").html("EDITAR PLATO");
                $("#accion").val(2)
                break;
            case 3:
                $("#tituloFormulario").html("ELIMINAR PLATO");
                $("#accion").val(3)
                break;
        }
        // Controles
        $("#nombrePlato").prop("disabled", accion==3 );
        $("#descripcion").prop("disabled", accion==3 );
        $("#precio").prop("disabled", accion==3 );
    }

</script>

</body>
</html>
