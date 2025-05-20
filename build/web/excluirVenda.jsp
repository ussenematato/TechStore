<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
    // Receber ID da venda a excluir
    int id = Integer.parseInt(request.getParameter("id"));
    
    try {
        // 1. Estabelecer conexão
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");
        
        // 2. Preparar SQL de exclusão
        String sql = "DELETE FROM venda WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, id);
        
        // 3. Executar e redirecionar
        stmt.executeUpdate();
        response.sendRedirect("vendas.jsp");
        
        // 4. Fechar recursos
        stmt.close();
        conexao.close();
        
    } catch(Exception e) {
        out.print("Erro ao excluir: " + e.getMessage());
    }
%>