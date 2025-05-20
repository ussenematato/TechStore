<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if ("POST".equals(request.getMethod())) {
        try {
            // Processa campos do formulário
            String codigoOriginal = request.getParameter("codigo_original");
            String codigo = request.getParameter("codigo");
            String nome = request.getParameter("nome");
            String marca = request.getParameter("marca");
            String preco = request.getParameter("preco");
            String quantidade = request.getParameter("quantidade");

            // Validação dos campos obrigatórios
            if (codigo == null || nome == null || marca == null
                    || preco == null || quantidade == null
                    || codigo.trim().isEmpty() || nome.trim().isEmpty()
                    || marca.trim().isEmpty() || preco.trim().isEmpty()
                    || quantidade.trim().isEmpty()) {

                response.sendRedirect("produtos.jsp?error=Todos+os+campos+obrigatórios+são+necessários");
                return;
            }

            // Conexão com banco e atualização
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123="); PreparedStatement st = con.prepareStatement(
                            "UPDATE produto SET codigo = ?, nome = ?, marca = ?, preco = ?, quantidade = ? WHERE codigo = ?")) {

                st.setString(1, codigo.trim());
                st.setString(2, nome.trim());
                st.setString(3, marca.trim());
                st.setDouble(4, Double.parseDouble(preco.trim()));
                st.setInt(5, Integer.parseInt(quantidade.trim()));
                st.setString(6, codigoOriginal.trim());

                int rowsAffected = st.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("produtos.jsp?success=1");
                } else {
                    response.sendRedirect("produtos.jsp?error=Nenhum+registro+foi+atualizado");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("produtos.jsp?error=" + e.getMessage());
            e.printStackTrace();
        }
    }
%>