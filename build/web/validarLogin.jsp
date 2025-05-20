<%@page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String senha = request.getParameter("password");

    // Debug: Verificar par�metros recebidos
    System.out.println("Tentativa de login - Email: " + email + ", Senha: " + senha);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        // CORRE��O: String de conex�o corrigida (removi o '=' no final da senha)
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema?user=root&pasword=123");

        String sql = "SELECT * FROM administrador WHERE email=? AND senha=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, senha);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Debug: Login bem-sucedido
            System.out.println("Login bem-sucedido para: " + email);
            session.setAttribute("email", email);
            response.sendRedirect("homeAdmin.jsp");
        } else {
            // Debug: Credenciais inv�lidas
            System.out.println("Credenciais inv�lidas para: " + email);
            request.setAttribute("erro", "Credenciais inv�lidas!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        // Debug: Erro na conex�o/consulta
        System.out.println("Erro durante o login: " + e.getMessage());
        request.setAttribute("erro", "Erro no sistema. Por favor, tente novamente.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>