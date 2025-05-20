<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    // Receber parâmetros do formulário
    String codigoProduto = request.getParameter("codigo_produto");
    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
    double precoUnitario = Double.parseDouble(request.getParameter("preco_unitario"));
    double total = Double.parseDouble(request.getParameter("total"));
    
    // Data atual
    String dataVenda = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    
    try {
        // 1. Estabelecer conexão
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123");
        
        // Verificar estoque antes de processar a venda
        String sqlEstoque = "SELECT quantidade FROM produto WHERE codigo = ?";
        PreparedStatement stmtEstoque = conexao.prepareStatement(sqlEstoque);
        stmtEstoque.setString(1, codigoProduto);
        ResultSet rsEstoque = stmtEstoque.executeQuery();
        
        if(rsEstoque.next()) {
            int estoqueAtual = rsEstoque.getInt("quantidade");
            
            if(estoqueAtual < quantidade) {
                // Não há estoque suficiente
                out.print("<script>alert('Quantidade insuficiente em estoque! Estoque atual: " + estoqueAtual + "'); history.back();</script>");
                return;
            }
            
            // Atualizar estoque
            String sqlAtualizaEstoque = "UPDATE produto SET quantidade = quantidade - ? WHERE codigo = ?";
            PreparedStatement stmtAtualizaEstoque = conexao.prepareStatement(sqlAtualizaEstoque);
            stmtAtualizaEstoque.setInt(1, quantidade);
            stmtAtualizaEstoque.setString(2, codigoProduto);
            stmtAtualizaEstoque.executeUpdate();
            stmtAtualizaEstoque.close();
            
            // Registrar a venda
            String sqlVenda = "INSERT INTO venda (codigo_produto, quantidade, preco_unitario, total, data_venda) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmtVenda = conexao.prepareStatement(sqlVenda);
            stmtVenda.setString(1, codigoProduto);
            stmtVenda.setInt(2, quantidade);
            stmtVenda.setDouble(3, precoUnitario);
            stmtVenda.setDouble(4, total);
            stmtVenda.setString(5, dataVenda);
            stmtVenda.executeUpdate();
            
            response.sendRedirect("vendas.jsp");
        } else {
            out.print("<script>alert('Produto não encontrado!'); history.back();</script>");
        }
        
        // Fechar recursos
        rsEstoque.close();
        stmtEstoque.close();
        conexao.close();
        
    } catch(Exception e) {
        out.print("<script>alert('Erro ao salvar venda: " + e.getMessage() + "'); history.back();</script>");
    }
%>