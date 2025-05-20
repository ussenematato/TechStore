<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");

        String sql = "SELECT * FROM produto ORDER BY marca";
        st = conecta.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            String imagem = rs.getString("imagem");
            String imgPath = (imagem != null && !imagem.isEmpty())
                    ? "uploads/" + imagem
                    : "https://via.placeholder.com/60";
%>
<tr>
    <td class="product-image-cell">
        <% if (rs.getString("imagem") != null && !rs.getString("imagem").isEmpty()) {%>
        <img src="uploads/<%= rs.getString("imagem")%>" alt="<%= rs.getString("nome")%>">
        <% } else { %>
        <span>Sem imagem</span>
        <% }%>
    </td>
    <td><%= rs.getString("codigo")%></td>
    <td><%= rs.getString("nome")%></td>
    <td><%= rs.getString("marca")%></td>
    <td>Mts <%= String.format("%.2f", rs.getDouble("preco"))%></td>
    <td><%= rs.getInt("quantidade")%></td>
    <td class="actions">
        <a href="editarProduto.jsp?codigo=<%= rs.getString("codigo")%>" class="btn btn-secondary">Editar</a>
        <a href="excluirProduto.jsp?codigo=<%= rs.getString("codigo")%>" class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir este produto?')">Excluir</a>
    </td>
</tr>
<%
        }
        rs.close();
        st.close();
        conecta.close();
    } catch (Exception e) {
        out.print("<tr><td colspan='7'>Erro ao carregar produtos: " + e.getMessage() + "</td></tr>");
    }
%>