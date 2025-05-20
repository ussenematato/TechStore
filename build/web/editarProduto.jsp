<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Produto</title>
        <style>
            /* Estilo base mantendo consistência com o design principal */
            :root {
                --primary: #3498db;
                --secondary: #2c3e50;
                --accent: #e74c3c;
                --light: #ecf0f1;
                --dark: #2c3e50;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: rgba(0, 0, 0, 0.7);
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
                padding-top: 50px;
            }

            .form-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
                width: 90%;
                max-width: 600px;
                padding: 30px;
                animation: slideDown 0.4s ease-out;
                position: relative;
            }

            @keyframes slideDown {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .form-title {
                color: var(--dark);
                margin-bottom: 25px;
                text-align: center;
                font-size: 1.8rem;
                position: relative;
                padding-bottom: 10px;
            }

            .form-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background-color: var(--accent);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: var(--dark);
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                transition: border 0.3s;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            }

            .btn {
                display: inline-block;
                padding: 12px 25px;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                border: none;
                text-decoration: none;
                text-align: center;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
            }

            .btn-secondary {
                background-color: #95a5a6;
                color: white;
            }

            .btn-secondary:hover {
                background-color: #7f8c8d;
                transform: translateY(-2px);
            }

            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .image-preview-container {
                margin-top: 10px;
            }

            .image-preview {
                max-width: 150px;
                max-height: 150px;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 5px;
                display: none;
            }

            .form-text {
                display: block;
                margin-top: 0.25rem;
                color: #6c757d;
                font-size: 0.875rem;
            }

            /* Responsividade */
            @media (max-width: 768px) {
                .form-container {
                    padding: 20px;
                    width: 95%;
                }

                .btn-group {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2 class="form-title">Editar Produto</h2>
            <%
                String codigo = request.getParameter("codigo");

                try {
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");

                    String sql = "SELECT * FROM produto WHERE codigo = ?";
                    st = conecta.prepareStatement(sql);
                    st.setString(1, codigo);
                    ResultSet rs = st.executeQuery();

                    if (rs.next()) {
            %>
            <!--<form action="atualizarProduto.jsp" method="post" enctype="multipart/form-data">-->
            <form action="atualizarProduto.jsp" method="post">
                <input type="hidden" name="codigo_original" value="<%= rs.getString("codigo")%>">

                <div class="form-group">
                    <label for="product-code">Código do Produto*</label>
                    <input type="text" id="product-code" name="codigo" class="form-control" 
                           value="<%= rs.getString("codigo")%>" required 
                           pattern="[A-Za-z0-9-]+" title="Apenas letras, números e hífens">
                </div>

                <div class="form-group">
                    <label for="product-name">Nome do Produto*</label>
                    <input type="text" id="product-name" name="nome" class="form-control" 
                           value="<%= rs.getString("nome")%>" required>
                </div>

                <div class="form-group">
                    <label for="product-brand">Marca*</label>
                    <input type="text" id="product-brand" name="marca" class="form-control" 
                           value="<%= rs.getString("marca")%>" required>
                </div>

                <div class="form-group">
                    <label for="product-price">Preço (MT)*</label>
                    <input type="number" id="product-price" name="preco" class="form-control" 
                           step="0.01" min="0" value="<%= rs.getDouble("preco")%>" required>
                </div>

                <div class="form-group">
                    <label for="product-quantity">Quantidade*</label>
                    <input type="number" id="product-quantity" name="quantidade" class="form-control" 
                           min="0" value="<%= rs.getInt("quantidade")%>" required>
                </div>

                <div class="form-group">
                    <label for="product-image">Imagem do Produto</label>
                    <input type="file" id="product-image" name="imagem" class="form-control" 
                           accept="image/jpeg, image/png, image/gif">
                    <small class="form-text">Formatos aceitos: JPG, PNG, GIF</small>
                    <div class="image-preview-container">
                        <% if (rs.getString("imagem") != null && !rs.getString("imagem").isEmpty()) {%>
                        <p>Imagem atual: <%= rs.getString("imagem")%></p>
                        <% } %>
                        <img id="image-preview" class="image-preview" src="#" alt="Pré-visualização">
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                    <a href="produtos.jsp" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
            <%
                    }
                    rs.close();
                    st.close();
                    conecta.close();
                } catch (Exception e) {
                    out.print("<div class='alert' style='color:red;margin-bottom:20px;'>Erro ao carregar produto: " + e.getMessage() + "</div>");
                }
            %>
        </div>

        <script>
            // Pré-visualização da imagem
            document.getElementById('product-image').addEventListener('change', function (e) {
                const preview = document.getElementById('image-preview');
                const file = e.target.files[0];

                if (file) {
                    const reader = new FileReader();

                    reader.onload = function (event) {
                        preview.src = event.target.result;
                        preview.style.display = 'block';
                    }

                    reader.readAsDataURL(file);
                } else {
                    preview.style.display = 'none';
                    preview.src = '#';
                }
            });
        </script>
    </body>
</html>