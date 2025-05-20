<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestão de Produtos e Vendas - TechStore</title>
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
                --success: #2ecc71;
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

            .section-title {
                text-align: center;
                margin: 2rem 0;
                color: var(--dark);
                font-size: 1.8rem;
            }

            .form-section {
                padding: 1rem 0;
            }

            .form-container {
                background-color: white;
                border-radius: 8px;
                padding: 2rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                margin-bottom: 2rem;
            }

            .form-title {
                text-align: center;
                margin-bottom: 2rem;
                color: var(--dark);
                font-size: 1.5rem;
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

            .btn-success {
                background-color: var(--success);
                color: white;
            }

            .btn-success:hover {
                background-color: #27ae60;
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

            .products-table, .sales-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                background-color: white;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                border-radius: 8px;
                overflow: hidden;
            }

            .products-table th,
            .products-table td,
            .sales-table th,
            .sales-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            .products-table th,
            .sales-table th {
                background-color: var(--secondary);
                color: white;
                font-weight: 500;
            }

            .products-table tr:hover,
            .sales-table tr:hover {
                background-color: #f9f9f9;
            }

            .products-table .actions,
            .sales-table .actions {
                display: flex;
                gap: 0.5rem;
            }

            .table-container {
                margin-top: 2rem;
                padding: 0 1rem;
            }

            .table-title {
                margin-bottom: 1.5rem;
                color: var(--dark);
                font-size: 1.5rem;
            }

            .total-sales {
                margin-top: 1rem;
                padding: 1rem;
                background-color: var(--success);
                color: white;
                border-radius: 4px;
                font-weight: bold;
                text-align: right;
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

                .products-table,
                .sales-table {
                    display: block;
                    overflow-x: auto;
                }

                .products-table .actions,
                .sales-table .actions {
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
                        <a href="index.jsp">Início</a>
                        <!--<a href="produtos.jsp">Produtos</a>-->
                        <a href="compraCliente.jsp">Compras</a>
                        <a href="sobreNos.html">Sobre nós</a>
                        <a href="contacto.html">Contacto</a>
                    </div>
                    <a href="login.jsp" class="login-btn">
                        <span>Login</span> <i class="fas fa-sign-in-alt"></i>
                    </a>
                </nav>
            </div>
        </header>

        <main class="container">
            <h1 class="section-title">Gestão de Compras</h1>

            <!-- Seção de Cadastro de Vendas -->
            <section class="form-section">
                <div class="form-container">
                    <h2 class="form-title">Registrar Nova Compra</h2>
                    <form action="salvarCompra.jsp" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="sale-product">Produto</label>
                                <select id="sale-product" name="codigo_produto" class="form-control" required onchange="carregarPreco()">
                                    <option value="">Selecione um produto</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            Connection conexao = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/sistema?user=root&pasword=123=");

                                            String sql = "SELECT codigo, marca, preco FROM produto ORDER BY marca";
                                            PreparedStatement stmt = conexao.prepareStatement(sql);
                                            ResultSet rs = stmt.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("codigo")%>" data-preco="<%= rs.getDouble("preco")%>">
                                        <%= rs.getString("marca")%> - Mts <%= String.format("%.2f", rs.getDouble("preco"))%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            stmt.close();
                                            conexao.close();
                                        } catch (Exception e) {
                                            out.print("<option value=''>Erro ao carregar produtos</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="sale-quantity">Quantidade</label>
                                <input type="number" id="sale-quantity" name="quantidade" class="form-control" min="1" required oninput="calcularTotal()">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="sale-price">Preço Unitário (Mts)</label>
                                <input type="number" id="sale-price" name="preco_unitario" class="form-control" step="0.01" min="0" required readonly>
                            </div>
                            <div class="form-group">
                                <label for="sale-total">Total (Mts)</label>
                                <input type="number" id="sale-total" name="total" class="form-control" step="0.01" min="0" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sale-method">Forma de Pagamento</label>
                            <select id="sale-method" name="forma_pagamento" class="form-control" required>
                                <option value="">Selecione</option>
                                <option value="MPESA">MPESA</option>
                                <option value="E-Mola">E-Mola</option>
                                <option value="MKesh">MKesh</option>
                            </select>
                        </div>
                </div>

                <button type="submit" class="btn btn-success btn-block">Efectuar Compra</button>
                </form>
                </div>

            </section>
        </main>

        <footer>
            <div class="container">
                <div class="footer-content">
                    <div class="footer-column">
                        <h3>TechStore Moçambique</h3>
                        <p>Sua loja de tecnologia com os melhores preços em meticais. Qualidade garantida!</p>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-whatsapp"></i></a>
                            <a href="#"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                    <div class="footer-column">
                        <h3>Links Rápidos</h3>
                        <ul class="footer-links">
                            <li><a href="#">Início</a></li>
                            <li><a href="#">Produtos</a></li>
                            <li><a href="#">Ofertas</a></li>
                            <li><a href="#">Sobre nós</a></li>
                            <li><a href="#">Contato</a></li>
                        </ul>
                    </div>
                    <div class="footer-column">
                        <h3>Categorias</h3>
                        <ul class="footer-links">
                            <li><a href="#">Smartphones</a></li>
                            <li><a href="#">Notebooks</a></li>
                            <li><a href="#">Acessórios</a></li>
                            <li><a href="#">Impressoras</a></li>
                            <li><a href="#">TVs</a></li>
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
            // Função para carregar o preço quando selecionar um produto
            function carregarPreco() {
                const select = document.getElementById('sale-product');
                const precoInput = document.getElementById('sale-price');

                if (select.selectedIndex > 0) {
                    // Obter o preço do atributo data-preco da opção selecionada
                    const preco = select.options[select.selectedIndex].getAttribute('data-preco');
                    precoInput.value = parseFloat(preco).toFixed(2);

                    // Calcular o total automaticamente
                    calcularTotal();
                } else {
                    precoInput.value = '';
                    document.getElementById('sale-total').value = '';
                }
            }

            // Função para calcular o total da venda
            function calcularTotal() {
                const quantity = parseFloat(document.getElementById('sale-quantity').value) || 0;
                const price = parseFloat(document.getElementById('sale-price').value) || 0;
                const total = quantity * price;
                document.getElementById('sale-total').value = total.toFixed(2);
            }

            // Função para calcular o total de todas as vendas na tabela
            function calcularTotalVendas() {
                const linhas = document.querySelectorAll('.sales-table tbody tr');
                let totalVendas = 0;

                linhas.forEach(linha => {
                    const celulaTotal = linha.querySelector('td:nth-child(5)');
                    if (celulaTotal) {
                        const texto = celulaTotal.textContent.trim();
                        // Remove "R$" e converte para número (considerando formato brasileiro)
                        const valor = parseFloat(texto.replace('R$', '')
                                .replace(/\./g, '')
                                .replace(',', '.'));
                        if (!isNaN(valor)) {
                            totalVendas += valor;
                        }
                    }
                });

                // Formata o valor para exibição (R$ 0,00)
                const totalVendasElement = document.getElementById('total-vendas');
                if (totalVendasElement) {
                    totalVendasElement.textContent =
                            totalVendas.toLocaleString('pt-BR', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2
                            });
                }
            }

            // Configura os eventos quando a página carrega
            document.addEventListener('DOMContentLoaded', function () {
                // Configura os eventos para o formulário
                const productSelect = document.getElementById('sale-product');
                if (productSelect) {
                    productSelect.addEventListener('change', carregarPreco);
                }

                const quantityInput = document.getElementById('sale-quantity');
                if (quantityInput) {
                    quantityInput.addEventListener('input', calcularTotal);
                }

                // Calcula o total das vendas na tabela
                calcularTotalVendas();
            });
            // Adicione esta função ao script existente em vendas.jsp
            function verificarEstoque() {
                const select = document.getElementById('sale-product');
                const quantidade = parseInt(document.getElementById('sale-quantity').value) || 0;

                if (select.selectedIndex > 0 && quantidade > 0) {
                    // Fazer uma requisição AJAX para verificar o estoque
                    const codigoProduto = select.value;
                    const xhr = new XMLHttpRequest();
                    xhr.open('GET', 'verificarEstoque.jsp?codigo=' + codigoProduto + '&quantidade=' + quantidade, true);

                    xhr.onload = function () {
                        if (this.status === 200) {
                            const resposta = JSON.parse(this.responseText);
                            if (resposta.estoque < quantidade) {
                                alert('Atenção! Estoque insuficiente. Quantidade disponível: ' + resposta.estoque);
                            }
                        }
                    };

                    xhr.send();
                }
            }

            // Adicione este evento ao carregar a página
            document.getElementById('sale-quantity').addEventListener('input', verificarEstoque);
            xhr.onload = function () {
                if (this.status === 200) {
                    const resposta = JSON.parse(this.responseText);
                    if (resposta.erro) {
                        alert('Erro: ' + resposta.erro);
                    } else if (!resposta.suficiente) {
                        alert('Atenção! Estoque insuficiente. Quantidade disponível: ' + resposta.estoque);
                    }
                }
            };
        </script>
    </body>
</html>

<!--CREATE TABLE venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_produto VARCHAR(20) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)
);-->