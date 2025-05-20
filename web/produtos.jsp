<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Produtos - TechStore</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            :root {
                --primary: #3498db;
                --secondary: #2c3e50;
                --accent: #e74c3c;
                --light: #ecf0f1;
                --dark: #2c3e50;
            }

            body {
                background-color: #f5f7fa;
                color: #333;
                line-height: 1.6;
            }

            header {
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                color: white;
                padding: 1rem 0;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .container {
                width: 90%;
                max-width: 1200px;
                margin: 0 auto;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.5rem 0;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 700;
                display: flex;
                align-items: center;
            }

            .logo span {
                color: var(--accent);
            }

            .nav-links {
                display: flex;
                gap: 1.5rem;
            }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            .nav-links a:hover {
                color: var(--accent);
            }

            .form-section {
                padding: 3rem 0;
            }

            .form-container {
                background-color: white;
                border-radius: 8px;
                padding: 2rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                max-width: 800px;
                margin: 0 auto;
            }

            .form-title {
                text-align: center;
                margin-bottom: 2rem;
                color: var(--dark);
                font-size: 1.8rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--dark);
            }

            .form-control {
                width: 100%;
                padding: 0.8rem;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 1rem;
                transition: border-color 0.3s;
            }

            .form-control:focus {
                border-color: var(--primary);
                outline: none;
            }

            .form-row {
                display: flex;
                gap: 1.5rem;
            }

            .form-row .form-group {
                flex: 1;
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

            .product-image-cell img {
                max-width: 60px;
                max-height: 60px;
                border-radius: 4px;
            }

            .btn {
                display: inline-block;
                padding: 0.8rem 1.5rem;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s;
                cursor: pointer;
                font-size: 1rem;
            }

            .btn-primary {
                background-color: var(--accent);
                color: white;
            }

            .btn-primary:hover {
                background-color: #c0392b;
            }

            .btn-secondary {
                background-color: var(--primary);
                color: white;
            }

            .btn-secondary:hover {
                background-color: #2980b9;
            }

            .btn-danger {
                background-color: #e74c3c;
                color: white;
            }

            .btn-danger:hover {
                background-color: #c0392b;
            }

            .btn-block {
                display: block;
                width: 100%;
            }

            .products-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 2rem;
                background-color: white;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                border-radius: 8px;
                overflow: hidden;
            }

            .products-table th,
            .products-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            .products-table th {
                background-color: var(--secondary);
                color: white;
                font-weight: 500;
            }

            .products-table tr:hover {
                background-color: #f9f9f9;
            }

            .products-table .actions {
                display: flex;
                gap: 0.5rem;
            }

            .table-container {
                margin-top: 3rem;
                padding: 0 1rem;
            }

            .table-title {
                margin-bottom: 1.5rem;
                color: var(--dark);
                font-size: 1.5rem;
            }

            footer {
                background-color: var(--dark);
                color: white;
                padding: 3rem 0 1rem;
                margin-top: 3rem;
            }

            .footer-content {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 2rem;
                margin-bottom: 2rem;
            }

            .footer-column h3 {
                margin-bottom: 1rem;
                font-size: 1.2rem;
            }

            .footer-links {
                list-style: none;
            }

            .footer-links li {
                margin-bottom: 0.5rem;
            }

            .footer-links a {
                color: #bdc3c7;
                text-decoration: none;
                transition: color 0.3s;
            }

            .footer-links a:hover {
                color: white;
            }

            .footer-bottom {
                text-align: center;
                padding-top: 1rem;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .footer-bottom p {
                color: #bdc3c7;
                font-size: 0.9rem;
            }
            .login-btn {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: white;
                text-decoration: none;
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 4px;
                background-color: rgba(255, 255, 255, 0.2);
                transition: all 0.3s;
            }

            .login-btn:hover {
                background-color: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
            }
            /* Adicione ao seu CSS existente */
            .form-text {
                display: block;
                margin-top: 0.25rem;
                color: #6c757d;
                font-size: 0.875rem;
            }

            /* Estilo para visualização da imagem */
            .image-preview {
                width: 100px;
                height: 100px;
                object-fit: contain;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-top: 0.5rem;
                display: none;
            }

            /* Estilo para a coluna de imagem na tabela */
            .product-image-cell img {
                width: 60px;
                height: 60px;
                object-fit: contain;
                border-radius: 4px;
            }

            @media (max-width: 768px) {
                .login-btn {
                    padding: 0.5rem;
                    font-size: 0;
                }

                .login-btn::after {
                    content: "?";
                    font-size: 1rem;
                }

                .login-btn span {
                    display: none;
                }
            }

            @media (max-width: 768px) {
                .nav-links {
                    display: none;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .products-table {
                    display: block;
                    overflow-x: auto;
                }

                .products-table .actions {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container">
                <nav>
                    <div class="logo">Tech<span>Store</span></div>
                    <div class="nav-links">
                        <a href="homeAdmin.jsp">Início</a>
                        <a href="#">Produtos</a>
                        <a href="vendas.jsp">Vendas</a>
                        <a href="sobreNosAdmin.html">Sobre nós</a>
                        <a href="contactoAdmin.html">Contato</a>
                    </div>
                    <a href="index.jsp" class="login-btn">
                        <span>Log Out</span> <i class="fas fa-sign-in-alt"></i>
                    </a>
                </nav>
            </div>
        </header>                     
        <!---->
        <section class="form-section">
            <div class="container">
                <div class="form-container">
                    <h2 class="form-title">Cadastro de Produtos</h2>

                    <%-- Mensagens --%>
                    <% if (request.getParameter("success") != null) { %>
                    <div class="alert alert-success">
                        Produto cadastrado com sucesso!
                    </div>
                    <% } %>

                    <% if (request.getParameter("error") != null) {%>
                    <div class="alert alert-danger">
                        Erro: <%= request.getParameter("error")%>
                    </div>
                    <% }%>

                    <!--<form action="salvarProduto.jsp" method="post" enctype="multipart/form-data">-->
                    <form id="product-form" action="salvarProduto.jsp" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="product-code">Código do Produto*</label>
                                <input type="text" id="product-code" name="codigo" class="form-control" required 
                                       pattern="[A-Za-z0-9-]+" title="Apenas letras, números e hífens">
                            </div>
                            <div class="form-group">
                                <label for="product-name">Nome do Produto*</label>
                                <input type="text" id="product-name" name="nome" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="product-brand">Marca*</label>
                                <input type="text" id="product-brand" name="marca" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="product-price">Preço (Mts)*</label>
                                <input type="number" id="product-price" name="preco" class="form-control" 
                                       step="0.01" min="0.01" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="product-quantity">Quantidade*</label>
                                <input type="number" id="product-quantity" name="quantidade" class="form-control" 
                                       min="1" required>
                            </div>
                            <div class="form-group">
                                <label for="product-image">Imagem do Produto</label>
                                <input type="file" id="product-image" name="imagem" class="form-control" 
                                       accept="image/jpeg, image/png, image/gif">
                                <small class="form-text">Formatos aceitos: JPG, PNG, GIF (Max 2MB)</small>
                            </div>
                            <div class="image-preview-container">
                                <img id="image-preview" class="image-preview" src="#" alt="Pré-visualização" 
                                     style="max-width: 100px; max-height: 100px; display: none; margin-top: 10px;">
                            </div>
                        </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Cadastrar Produto</button>
                </form>
            </div>

            <%-- Tabela de produtos --%>
            <div class="table-container">
                <h3 class="table-title">Produtos Cadastrados</h3>
                <table class="products-table">
                    <thead>
                        <tr>
                            <th>Imagem</th>
                            <th>Código</th>
                            <th>Nome</th>
                            <th>Marca</th>
                            <th>Preço</th>
                            <th>Quantidade</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%@include file="listarProdutos.jsp"%>
                    </tbody>
                </table>
            </div>
        </div>
    </section>


    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>TechStore</h3>
                    <p>Sua loja de tecnologia com os melhores preços e produtos de alta qualidade.</p>
                </div>
                <div class="footer-column">
                    <h3>Links Rápidos</h3>
                    <ul class="footer-links">
                        <li><a href="index.html">Início</a></li>
                        <li><a href="produtos.jsp">Produtos</a></li>
                        <li><a href="vendas.jsp">Vendas</a></li>
                        <li><a href="#">Sobre nós</a></li>
                        <li><a href="#">Contato</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contacte-nos</h3>
                    <ul class="footer-links">
                        <li><i class="fas fa-phone"></i> +258 84 672 8470</li>
                        <li><i class="fas fa-phone"></i> +258 86 672 8470</li>
                        <li><i class="fas fa-envelope"></i> info@techstore.co.mz</li>
                        <li><i class="fas fa-map-marker-alt"></i> Av. Julius Nyerere, Campus Universitário, UEM, Maputo</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 TechStore Moçambique. Todos os direitos reservados.</p>
            </div>
        </div>
    </footer>
    <script>
// Validação do formulário
        document.getElementById('product-form').addEventListener('submit', function (e) {
            const imageInput = document.getElementById('product-image');

            // Verifica se uma imagem foi selecionada
            if (imageInput.files.length > 0) {
                const file = imageInput.files[0];
                const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
                const maxSize = 2 * 1024 * 1024; // 2MB

                // Verifica o tipo do arquivo
                if (!validTypes.includes(file.type)) {
                    alert('Por favor, selecione uma imagem nos formatos JPG, PNG ou GIF.');
                    e.preventDefault();
                    return false;
                }

                // Verifica o tamanho do arquivo
                if (file.size > maxSize) {
                    alert('A imagem não pode exceder 2MB.');
                    e.preventDefault();
                    return false;
                }
            }

            return true;
        });

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

<!--CREATE TABLE produto (
    codigo VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL
);
Com imagem
CREATE TABLE produto (
    codigo VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL,
    imagem VARCHAR(255)
);-->