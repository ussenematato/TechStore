<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - TechStore</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .auth-container {
                width: 90%;
                max-width: 400px;
                padding: 2rem;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .hidden {
                display: none;
            }

            .auth-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .auth-header h1 {
                font-size: 2rem;
                color: #2c3e50;
            }

            .auth-header span {
                color: #e74c3c;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 0.8rem;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 1rem;
            }

            .form-control:focus {
                outline: none;
                border-color: #3498db;
            }

            .btn {
                display: block;
                width: 100%;
                padding: 0.8rem;
                border: none;
                border-radius: 4px;
                background-color: #3498db;
                color: white;
                font-size: 1rem;
                cursor: pointer;
                margin-top: 1rem;
            }

            .btn:hover {
                background-color: #2980b9;
            }

            .btn-secondary {
                background-color: #7f8c8d;
            }

            .auth-footer {
                text-align: center;
                margin-top: 1.5rem;
            }

            .auth-footer a {
                color: #3498db;
                text-decoration: none;
                cursor: pointer;
            }

            @media (max-width: 480px) {
                .auth-container {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Container de Login -->
        <div class="auth-container" id="login-container">
            <!-- Adicione isto no topo do login-container -->
            <% if (request.getAttribute("erro") != null) {%>
            <div style="color: red; margin-bottom: 1rem; text-align: center;">
                <%= request.getAttribute("erro")%>
            </div>
            <% }%>
            <div class="auth-header">
                <h1>Tech<span>Store</span></h1>
                <p>Sua loja de tecnologia premium</p>
            </div>

            <form id="Sigup-form" action="validarLogin.jsp" method="post">
                <div class="form-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Digite seu e-mail" required>
                </div>

                <div class="form-group">
                    <label for="password">Senha</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Digite sua senha" required>
                </div>

                <button type="submit" class="btn">Entrar</button>
            </form>

            <div class="auth-footer">
                <p>Não tem uma conta? <a id="show-register">Cadastre-se</a></p>
                <p><a id="show-forgot">Esqueceu sua senha?</a></p>
            </div>
        </div>

        <!-- Container de Cadastro -->
        <div class="auth-container hidden" id="register-container">
            <div class="auth-header">
                <h1>Criar <span>Conta</span></h1>
                <p>Junte-se à nossa comunidade</p>
            </div>

            <form id="register-form">
                <div class="form-group">
                    <label for="first-name">Primeiro Nome</label>
                    <input type="text" id="first-name" class="form-control" placeholder="Seu primeiro nome" required>
                </div>

                <div class="form-group">
                    <label for="last-name">Apelido</label>
                    <input type="text" id="last-name" class="form-control" placeholder="Seu sobrenome ou apelido" required>
                </div>

                <div class="form-group">
                    <label for="reg-email">E-mail</label>
                    <input type="email" id="reg-email" class="form-control" placeholder="Seu e-mail" required>
                </div>

                <div class="form-group">
                    <label for="reg-password">Senha</label>
                    <input type="password" id="reg-password" class="form-control" placeholder="Crie uma senha" required>
                </div>

                <button type="submit" class="btn">Cadastrar</button>
                <button type="button" id="back-to-login" class="btn btn-secondary">Voltar para Login</button>
            </form>
        </div>

        <!-- Container de Recuperação de Senha -->
        <div class="auth-container hidden" id="forgot-container">
            <div class="auth-header">
                <h1>Recuperar <span>Senha</span></h1>
                <p>Digite seu e-mail para redefinir sua senha</p>
            </div>

            <!--        <form id="forgot-form">
                        <div class="form-group">
                            <label for="forgot-email">E-mail</label>
                            <input type="email" id="forgot-email" class="form-control" placeholder="Digite seu e-mail cadastrado" required>
                        </div>
                        
                        <button type="submit" class="btn">Enviar Link de Recuperação</button>
                        <button type="button" id="back-to-login-from-forgot" class="btn btn-secondary">Voltar para Login</button>
                    </form>-->

            <form id="login-form" action="validarLogin.jsp" method="post">
                <div class="form-group">
                    <label for="login-email">E-mail</label>
                    <input type="email" id="login-email" name="email" class="form-control" placeholder="Digite seu e-mail" required>
                </div>
                <div class="form-group">
                    <label for="login-password">Senha</label>
                    <input type="password" id="login-password" name="password" class="form-control" placeholder="Digite sua senha" required>
                </div>
                <button type="submit" class="btn">Entrar</button>
            </form>
        </div>

        <script>
            // Alternar entre os containers
            function showContainer(containerId) {
                document.querySelectorAll('.auth-container').forEach(container => {
                    container.classList.add('hidden');
                });
                document.getElementById(containerId).classList.remove('hidden');
            }

            // Redirecionamento para a página principal
            function redirectToMainPage() {
                window.location.href = "techstore-main.html";
            }

            // Configurações iniciais
            document.addEventListener('DOMContentLoaded', function () {
                // Configurar navegação
                document.getElementById('show-register').addEventListener('click', function (e) {
                    e.preventDefault();
                    showContainer('register-container');
                });

                document.getElementById('show-forgot').addEventListener('click', function (e) {
                    e.preventDefault();
                    showContainer('forgot-container');
                });

                document.getElementById('back-to-login').addEventListener('click', function (e) {
                    e.preventDefault();
                    showContainer('login-container');
                });

                document.getElementById('back-to-login-from-forgot').addEventListener('click', function (e) {
                    e.preventDefault();
                    showContainer('login-container');
                });

                // Configurar os formulários
                document.getElementById('login-form').addEventListener('submit', function (e) {
                    e.preventDefault();
                    redirectToMainPage();
                });

                document.getElementById('register-form').addEventListener('submit', function (e) {
                    e.preventDefault();
                    redirectToMainPage();
                });

                document.getElementById('forgot-form').addEventListener('submit', function (e) {
                    e.preventDefault();
                    alert('Um link de recuperação foi enviado para seu e-mail!');
                    showContainer('login-container');
                });
            });

            document.getElementById('login-form').addEventListener('submit', function (e) {
                e.preventDefault();

                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;

                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'validarLogin.jsp', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                xhr.onload = function () {
                    if (this.status === 200) {
                        if (this.responseText.includes('sucesso')) {
                            window.location.href = "homeAdmin.html";
                        } else {
                            alert('Credenciais inválidas!');
                        }
                    }
                };

                xhr.send('email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password));
            });
        </script>
    </body>
</html>