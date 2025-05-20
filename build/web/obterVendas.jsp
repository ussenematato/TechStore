<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="application/json" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    JSONObject json = new JSONObject();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");
        
        String sql = "SELECT * FROM venda WHERE id = ?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            json.put("id", rs.getInt("id"));
            json.put("codigo_produto", rs.getString("codigo_produto"));
            json.put("quantidade", rs.getInt("quantidade"));
            json.put("preco_unitario", rs.getDouble("preco_unitario"));
            json.put("data_venda", rs.getDate("data_venda").toString());
        }
        
        rs.close();
        stmt.close();
        conexao.close();
    } catch(Exception e) {
        json.put("erro", e.getMessage());
    }
    
    out.print(json.toString());
%>