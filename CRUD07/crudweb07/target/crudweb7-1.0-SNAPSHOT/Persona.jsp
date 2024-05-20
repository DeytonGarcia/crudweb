<%@ page import="pe.edu.vallegrande.crudweb07.dto.PersonaDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    List<PersonaDto> lista;
    lista = (List<PersonaDto>) request.getAttribute("lista");
    String titulo = null;
    if(request.getAttribute("titulo") != null){
        titulo = request.getAttribute("titulo").toString();
    };
    PersonaDto bean2 = null;
    if(titulo!=null){
        bean2 = (PersonaDto) request.getAttribute("bean");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <title>CRUD DE PERSONAS</title>
</head>
<body>

<div class="container">

    <h1>CRUD DE PERSONAS</h1>

    <div class="card" id="divListado">
        <div class="card-header">
            LISTADO DE PERSONAS
            <button type="button" class="btn btn-primary float-right" id="btnNuevo">Nuevo</button>
        </div>
        <div class="card-body">

            <table class="table">
                <thead class="thead-light">
                <tr>
                    <th>ID</th>
                    <th>TIPO PERSONA</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>DIRECCIÓN</th>
                    <th>CORREO</th>
                    <th>CELULAR</th>
                    <th>FECHA DE NACIMIENTO</th>
                    <th>TIPO DE DOCUMENTO</th>
                    <th>NÚMERO DE DOCUMENTO</th>
                    <th>ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <% if(lista != null) { %>
                <% for(PersonaDto bean: lista) { %>

                <tr>
                    <td><%=bean.getId()%></td>
                    <td><%=bean.getTipoPersona()%></td>
                    <td><%=bean.getNombres()%></td>
                    <td><%=bean.getApellidos()%></td>
                    <td><%=bean.getDireccion()%></td>
                    <td><%=bean.getGmail()%></td>
                    <td><%=bean.getCelular()%></td>
                    <td><%=bean.getFechaNacimiento()%></td>
                    <td><%=bean.getTipoDocumento()%></td>
                    <td><%=bean.getNumeroDocumento()%></td>
                    <td>
                        <a href="#" class="btn btn-warning btn-sm" onclick="editarPersona(<%=bean.getId()%>, '<%=bean.getNombres()%>', '<%=bean.getTipoPersona()%>', '<%=bean.getApellidos()%>', '<%=bean.getDireccion()%>', '<%=bean.getGmail()%>', '<%=bean.getCelular()%>', '<%=bean.getFechaNacimiento()%>', '<%=bean.getTipoDocumento()%>', '<%=bean.getNumeroDocumento()%>')">Editar</a>
                        <a href="#" class="btn btn-danger btn-sm" onclick="eliminarPersona(<%=bean.getId()%>)">Eliminar</a>
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
            {accion} PERSONA
        </div>
        <div class="card-body">
            <form method="post" action="ContProcesar" id="formularioPersona">
                <div class="form-group row">
                    <div class="col-sm-10">
                        <label>ID</label>
                        <input type="hidden" id="id" name="id" value="0">
                        <input type="hidden" id="accion" name="accion" value="0">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="tipoPersona" class="col-sm-2 col-form-label">Tipo de Persona</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="tipoPersona" name="tipoPersona">
                            <option value="CLIENTE">Cliente</option>
                            <option value="EMPLEADO">Empleado</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="nombres" class="col-sm-2 col-form-label">Nombres</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="nombres" name="nombres" placeholder="Nombres de la persona">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="apellidos" class="col-sm-2 col-form-label">Apellidos</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos de la persona">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="direccion" class="col-sm-2 col-form-label">Dirección</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección de la persona">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="correo" class="col-sm-2 col-form-label">Correo</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo de la persona">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="celular" class="col-sm-2 col-form-label">Celular</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="celular" name="celular" placeholder="Celular de la persona">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="fechaNacimiento" class="col-sm-2 col-form-label">Fecha de Nacimiento</label>
                    <div class="col-sm-10">
                        <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" placeholder="Fecha de Nacimiento de la persona">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="tipoDocumento" class="col-sm-2 col-form-label">Tipo de Documento</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="tipoDocumento" name="tipoDocumento">
                            <option value="DNI">DNI</option>
                            <option value="CNE">CNE</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="numeroDocumento" class="col-sm-2 col-form-label">Número de Documento</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" placeholder="Número de Documento de la persona">
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
    <p>NOMBRES: <%=bean2.getNombres()%></p>
    <p>APELLIDOS: <%=bean2.getApellidos()%></p>
    <p>DIRECCIÓN: <%=bean2.getDireccion()%></p>
    <p>CORREO: <%=bean2.getGmail()%></p>
    <p>CELULAR: <%=bean2.getCelular()%></p>
    <p>FECHA DE NACIMIENTO: <%=bean2.getFechaNacimiento()%></p>
    <p>TIPO DE DOCUMENTO: <%=bean2.getTipoDocumento()%></p>
    <p>NÚMERO DE DOCUMENTO: <%=bean2.getNumeroDocumento()%></p>
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
        accion=1: Crear contacto
        accion=2: Actualizar contacto
        accion=3: Eliminar contacto
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

    function editarPersona(id, tipoPersona, nombres, apellidos ,direccion, correo, celular, fechaNacimiento, tipoDocumento, numeroDocumento){
        $("#divListado").hide();
        $("#divEditRecord").show();
        initFormulario(2);
        $("#id").val(id);
        $("#tipoPersona").val(tipoPersona);
        $("#nombres").val(nombres);
        $("#apellidos").val(apellidos);
        $("#direccion").val(direccion);
        $("#correo").val(correo);
        $("#celular").val(celular);
        $("#fechaNacimiento").val(fechaNacimiento);
        $("#tipoDocumento").val(tipoDocumento);
        $("#numeroDocumento").val(numeroDocumento);
    }

    function eliminarPersona(id){
        if(confirm("¿Está seguro de eliminar esta persona?")){
            window.location.href = "ContEliminar?id=" + id;
        }
    }




    // Otras funciones

    function initFormulario(accion){
        switch(accion){
            case 1:
                $("#tituloFormulario").html("NUEVA PERSONA");
                $("#accion").val(1)
                break;
            case 2:
                $("#tituloFormulario").html("EDITAR PERSONA");
                $("#accion").val(2)
                break;
            case 3:
                $("#tituloFormulario").html("ELIMINAR PERSONA");
                $("#accion").val(3)
                break;
        }
        // Controles
        $("#tipoPersona").prop("disabled", accion==3 );
        $("#nombres").prop("disabled", accion==3 );
        $("#apellidos").prop("disabled", accion==3 );
        $("#direccion").prop("disabled", accion==3 );
        $("#correo").prop("disabled", accion==3 );
        $("#celular").prop("disabled", accion==3 );
        $("#fechaNacimiento").prop("disabled", accion==3 );
        $("#tipoDocumento").prop("disabled", accion==3 );
        $("#numeroDocumento").prop("disabled", accion==3 );
    }

</script>

</body>
</html>
