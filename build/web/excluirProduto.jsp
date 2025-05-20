<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Receber o código do produto a ser excluído
    String codigo = request.getParameter("codigo");
    
    // Fazer a conexão com o banco de dados
    try {
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");
        
        // Excluir o produto da tabela
        String sql = "DELETE FROM produto WHERE codigo = ?";
        st = conecta.prepareStatement(sql);
        st.setString(1, codigo);
        
        st.executeUpdate();
        response.sendRedirect("produtos.jsp");
        
        st.close();
        conecta.close();
    } catch (Exception e) {
        out.print("Erro ao excluir: " + e.getMessage());
    }
%>