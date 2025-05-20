<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
    response.setContentType("application/json");
    String codigoProduto = request.getParameter("codigo");
    int quantidade = Integer.parseInt(request.getParameter("quantidade"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/sistema?user=root&password=123");

        String sql = "SELECT quantidade FROM produto WHERE codigo = ?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, codigoProduto);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int estoque = rs.getInt("quantidade");
%>
{
"estoque": <%= estoque%>,
"suficiente": <%= estoque >= quantidade%>
}
<%
} else {
%>
{
"erro": "Produto não encontrado"
}
<%
    }
} catch (Exception e) {
%>
{
"erro": "<%= e.getMessage()%>"
}
<%
    }
%>