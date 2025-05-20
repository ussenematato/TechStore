<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");

        String sql = "SELECT v.*, p.marca FROM venda v JOIN produto p ON v.codigo_produto = p.codigo ORDER BY v.data_venda DESC";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("pt", "BR"));
        double totalVendas = 0;

        while (rs.next()) {
            double precoUnitario = rs.getDouble("preco_unitario");
            int quantidade = rs.getInt("quantidade");
            double total = precoUnitario * quantidade;
            totalVendas += total;
%>

<tr>
    <td><%= dateFormat.format(rs.getDate("data_venda"))%></td>
    <td><%= rs.getString("marca") %></td>
    <td><%= rs.getInt("quantidade") %></td>
    <td><%= String.format("%,.2f MT", rs.getDouble("preco_unitario")) %></td>
    <td><%= String.format("%,.2f MT", total) %></td>
    <td class="actions">
        <a href="editarVenda.jsp?id=<%= rs.getInt("id") %>" class="btn btn-secondary">Editar</a>
        <a href="excluirVenda.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger">Excluir</a>
    </td>
</tr>
<%
        }

        // Fecha recursos
        rs.close();
        stmt.close();
        conexao.close();

        // Atualiza o total de vendas via JavaScript
        out.print("<script>document.getElementById('total-vendas').textContent = '"
                + String.format("%,.2f", totalVendas) + " MT';</script>");


    } catch (Exception e) {
        out.print("<tr><td colspan='6' style='color:red'>Erro ao carregar vendas: " + e.getMessage() + "</td></tr>");
    }
%>
