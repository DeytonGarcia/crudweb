package pe.edu.vallegrande.crudweb07.service;

import pe.edu.vallegrande.crudweb07.bd.AccesoDB;
import pe.edu.vallegrande.crudweb07.dto.MenuDto;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class MenuService {

    public List<MenuDto> listar() {
        List<MenuDto> lista = new ArrayList<>();
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT id_plato, Nombre_plato, Descripcion, Precio FROM MENU";
        try {
            cn = AccesoDB.getConnection();
            pstm = cn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MenuDto bean = new MenuDto();
                bean.setId(rs.getInt("id_plato"));
                bean.setNombrePlato(rs.getString("Nombre_plato"));
                bean.setDescripcion(rs.getString("Descripcion"));
                bean.setPrecio(rs.getBigDecimal("Precio"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            closeResources(cn, pstm, rs);
        }
        return lista;
    }

    public MenuDto agregar(MenuDto bean) {
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO MENU(Nombre_plato, Descripcion, Precio) VALUES(?, ?, ?)";
        try {
            cn = AccesoDB.getConnection();
            pstm = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            pstm.setString(1, bean.getNombrePlato());
            pstm.setString(2, bean.getDescripcion());
            pstm.setBigDecimal(3, bean.getPrecio());
            pstm.executeUpdate();
            rs = pstm.getGeneratedKeys();
            if (rs.next()) {
                bean.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            closeResources(cn, pstm, rs);
        }
        return bean;
    }

    public void actualizar(MenuDto bean) {
        Connection cn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE MENU SET Nombre_plato=?, Descripcion=?, Precio=? WHERE id_plato=?";
        try {
            cn = AccesoDB.getConnection();
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, bean.getNombrePlato());
            pstm.setString(2, bean.getDescripcion());
            pstm.setBigDecimal(3, bean.getPrecio());
            pstm.setInt(4, bean.getId());
            pstm.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            closeResources(cn, pstm, null);
        }
    }

    public void eliminar(int id) {
        Connection cn = null;
        PreparedStatement pstm = null;
        String sql = "DELETE FROM MENU WHERE id_plato=?";
        try {
            cn = AccesoDB.getConnection();
            pstm = cn.prepareStatement(sql);
            pstm.setInt(1, id);
            pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            closeResources(cn, pstm, null);
        }

    }

    // Método utilitario para cerrar recursos JDBC
    private void closeResources(Connection cn, PreparedStatement pstm, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstm != null) pstm.close();
            if (cn != null) cn.close();
        } catch (SQLException e) {
            // Manejo de errores al cerrar recursos
        }
    }
}
