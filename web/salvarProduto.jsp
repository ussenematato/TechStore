<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if ("POST".equals(request.getMethod())) {
        try {
            // Processa campos do formulário
            String codigo = request.getParameter("codigo");
            String nome = request.getParameter("nome");
            String marca = request.getParameter("marca");
            String preco = request.getParameter("preco");
            String quantidade = request.getParameter("quantidade");

            // Validação
            if (codigo == null || nome == null || marca == null
                    || preco == null || quantidade == null
                    || codigo.trim().isEmpty() || nome.trim().isEmpty()
                    || marca.trim().isEmpty() || preco.trim().isEmpty()
                    || quantidade.trim().isEmpty()) {

                response.sendRedirect("produtos.jsp?error=Todos+os+campos+são+obrigatórios");
                return;
            }

            // Conexão com banco e inserção
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123="); PreparedStatement st = con.prepareStatement(
                            "INSERT INTO produto (codigo, nome, marca, preco, quantidade) VALUES (?,?,?,?,?)")) {

                st.setString(1, codigo.trim());
                st.setString(2, nome.trim());
                st.setString(3, marca.trim());
                st.setDouble(4, Double.parseDouble(preco.trim()));
                st.setInt(5, Integer.parseInt(quantidade.trim()));

                st.executeUpdate();
                response.sendRedirect("produtos.jsp?success=1");
            }
        } catch (Exception e) {
            response.sendRedirect("produtos.jsp?error=" + e.getMessage());
            e.printStackTrace();
        }
    }
%>