<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TechStore - Equipamentos Eletrônicos de Alta Qualidade</title>
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

            .banner {
                background: url('https://source.unsplash.com/random/1200x400/?maputo') center/cover;
                height: 400px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                color: white;
                position: relative;
            }

            .banner::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1;
            }

            .banner-content {
                z-index: 2;
                padding: 2rem;
            }

            .banner h1 {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }

            .banner p {
                font-size: 1.2rem;
                margin-bottom: 2rem;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .btn {
                display: inline-block;
                background-color: var(--accent);
                color: white;
                padding: 0.8rem 1.5rem;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: #c0392b;
            }

            .features {
                padding: 3rem 0;
                background-color: white;
            }

            .section-title {
                text-align: center;
                margin-bottom: 2rem;
                color: var(--dark);
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 2rem;
            }

            .feature-card {
                background-color: white;
                border-radius: 8px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s;
            }

            .feature-card:hover {
                transform: translateY(-5px);
            }

            .feature-icon {
                font-size: 2.5rem;
                color: var(--primary);
                margin-bottom: 1rem;
            }

            .feature-card h3 {
                margin-bottom: 0.5rem;
                color: var(--dark);
            }

            .products {
                padding: 3rem 0;
            }

            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 2rem;
            }

            .product-card {
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-img {
                height: 200px;
                width: 100%;
                object-fit: cover;
            }

            .product-info {
                padding: 1.5rem;
            }

            .product-title {
                font-size: 1.2rem;
                margin-bottom: 0.5rem;
                color: var(--dark);
            }

            .product-price {
                font-size: 1.3rem;
                font-weight: 700;
                color: var(--accent);
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .product-price span {
                font-size: 0.9rem;
                color: #666;
                font-weight: normal;
            }

            .product-description {
                color: #666;
                margin-bottom: 1rem;
            }

            .product-name {
                color: #333;
                font-size: 1.1rem;
                margin: 0.5rem 0;
                font-weight: 600;
            }

            .product-brand {
                color: #555;
                font-size: 1rem;
                margin-bottom: 0.3rem;
            }

            .product-details {
                color: #666;
                font-size: 0.9rem;
                margin: 0.5rem 0;
            }

            .testimonials {
                padding: 3rem 0;
                background-color: var(--light);
            }

            .testimonials-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
            }

            .testimonial-card {
                background-color: white;
                border-radius: 8px;
                padding: 1.5rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }

            .testimonial-text {
                font-style: italic;
                margin-bottom: 1rem;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
            }

            .author-img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 1rem;
                object-fit: cover;
            }

            .author-info h4 {
                margin-bottom: 0.2rem;
            }

            .author-info p {
                color: #666;
                font-size: 0.9rem;
            }

            .cta {
                padding: 4rem 0;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                color: white;
                text-align: center;
            }

            .cta h2 {
                margin-bottom: 1rem;
                font-size: 2rem;
            }

            .cta p {
                margin-bottom: 2rem;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            footer {
                background-color: var(--dark);
                color: white;
                padding: 3rem 0 1rem;
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

            .social-icons {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }

            .social-icons a {
                color: white;
                font-size: 1.2rem;
                transition: color 0.3s;
            }

            .social-icons a:hover {
                color: var(--accent);
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
                    content: "🔑";
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

                .banner h1 {
                    font-size: 2rem;
                }

                .banner p {
                    font-size: 1rem;
                }
            }

            /* Estilo específico para Moçambique */
            .flag-colors {
                display: flex;
                height: 5px;
                margin-bottom: 1rem;
            }

            .flag-colors span {
                flex: 1;
            }

            .flag-green {
                background-color: #007a5e;
            }

            .flag-black {
                background-color: #000000;
            }

            .flag-yellow {
                background-color: #fcd116;
            }

            .flag-red {
                background-color: #ce1126;
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
                        <a href="contacto.html">Contato</a>
                    </div>
                    <a href="login.jsp" class="login-btn">
                        <span>Login</span> <i class="fas fa-sign-in-alt"></i>
                    </a>
                </nav>
            </div>
        </header>

        <section class="banner">
            <div class="banner-content">
                <div class="flag-colors">
                    <span class="flag-green"></span>
                    <span class="flag-black"></span>
                    <span class="flag-yellow"></span>
                    <span class="flag-red"></span>
                </div>
                <h1>Tecnologia de Ponta em Moçambique</h1>
                <p>Os melhores equipamentos electrónicos com os preços mais competitivos do mercado. Qualidade e inovação em Maputo e em todo o país.</p>
                <a href="#" class="btn">Ver Ofertas</a>
            </div>
        </section>
        <section class="features">
            <div class="container">
                <h2 class="section-title">Por que escolher a TechStore Moçambique?</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🚚</div>
                        <h3>Entrega em Maputo</h3>
                        <p>Entregamos no mesmo dia para a cidade de Maputo e em 48h para outras províncias.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">⭐</div>
                        <h3>Garantia Local</h3>
                        <p>Todos os produtos com garantia e assistência técnica em Moçambique.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">💰</div>
                        <h3>Preços em Meticais</h3>
                        <p>Todos os preços em MTN sem surpresas com câmbio ou taxas adicionais.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🔧</div>
                        <h3>Suporte em Português</h3>
                        <p>Atendimento personalizado na nossa língua, sem barreiras linguísticas.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="products">
            <div class="container">
                <h2 class="section-title">Produtos em Destaque</h2>
                <div class="products-grid">
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
                    %>
                    <div class="product-card">
                        <img src="uploads/<%= rs.getString("imagem")%>" alt="<%= rs.getString("nome")%>" class="product-img">
                        <div class="product-info">
                            <h3 class="product-brand"><%= rs.getString("marca")%></h3>
                            <h4 class="product-name"><%= rs.getString("nome")%></h4>
                            <p class="product-price">Mts <%= String.format("%.2f", rs.getDouble("preco"))%></p>
                            <p class="product-details">
                                Código: <%= rs.getString("codigo")%> | 
                                Quantidade: <%= rs.getInt("quantidade")%>
                            </p>
                            <a href="compraCliente.jsp?codigo=<%= rs.getString("codigo")%>" class="btn">Comprar agora</a>
                        </div>
                    </div>
                    <%
                            }
                            rs.close();
                            st.close();
                            conecta.close();
                        } catch (Exception e) {
                            out.print("<div class='error'>Erro ao carregar produtos: " + e.getMessage() + "</div>");
                        }
                    %>
                </div>
            </div>
        </section>

        <section class="testimonials">
            <div class="container">
                <h2 class="section-title">O que dizem nossos clientes</h2>
                <div class="testimonials-grid">
                    <div class="testimonial-card">
                        <p class="testimonial-text">"Comprei um smartphone e estou impressionado com a qualidade e o atendimento. Entrega rápida mesmo estando em Nampula!"</p>
                        <div class="testimonial-author">
                            <img src="imagens/foto.jpg" alt="Cliente 1" class="author-img">
                            <div class="author-info">
                                <h4>Joao Langa</h4>
                                <p>Cliente desde 2022</p>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <p class="testimonial-text">"A melhor loja de electrónicos em Maputo. Preços justos e produtos originais com garantia real. Recomendo!"</p>
                        <div class="testimonial-author">
                            <img src="imagens/filomena.jpg" alt="Cliente 2" class="author-img">
                            <div class="author-info">
                                <h4>Filomena Lopes</h4>
                                <p>Cliente desde 2023</p>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <p class="testimonial-text">"O suporte técnico resolveu meu problema rapidamente. Fiquei surpreso com a eficiência aqui em Moçambique."</p>
                        <div class="testimonial-author">
                            <img src="imagens/matato.jpg" alt="Cliente 3" class="author-img">
                            <div class="author-info">
                                <h4>Ussene Matato</h4>
                                <p>Estudante UEM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="cta">
            <div class="container">
                <h2>Junte-se a Nossos Clientes Satisfeitos</h2>
                <p>Cadastre-se agora e receba 10% de desconto na primeira compra, além de frete grátis em Maputo!</p>
                <a href="#" class="btn">Cadastrar Agora</a>
            </div>
        </section>

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
    </body>
</html>