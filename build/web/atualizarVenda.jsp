<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
    // Receber parâmetros
    int id = Integer.parseInt(request.getParameter("id"));
    String codigoProduto = request.getParameter("codigo_produto");
    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
    double precoUnitario = Double.parseDouble(request.getParameter("preco_unitario"));
    String dataVenda = request.getParameter("data_venda");
    double total = quantidade * precoUnitario;
    
    try {
        // 1. Estabelecer conexão
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");
        
        // 2. Preparar SQL de atualização
        String sql = "UPDATE venda SET codigo_produto=?, quantidade=?, preco_unitario=?, total=?, data_venda=? WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, codigoProduto);
        stmt.setInt(2, quantidade);
        stmt.setDouble(3, precoUnitario);
        stmt.setDouble(4, total);
        stmt.setString(5, dataVenda);
        stmt.setInt(6, id);
        
        // 3. Executar e redirecionar
        stmt.executeUpdate();
        response.sendRedirect("vendas.jsp");
        
        // 4. Fechar recursos
        stmt.close();
        conexao.close();
        
    } catch(Exception e) {
        out.print("Erro ao atualizar: " + e.getMessage());
    }
%>