<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Editar Venda</title>
        <style>
            /* Estilo base mantendo consistência com o design principal */
            :root {
                --primary: #3498db;
                --secondary: #2c3e50;
                --accent: #2ecc71; /* Verde para ações de venda */
                --danger: #e74c3c;
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
                max-width: 700px;
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

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1;
                margin-bottom: 15px;
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
                transition: all 0.3s;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            }

            select.form-control {
                appearance: none;
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 1em;
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

            .btn-success {
                background-color: var(--accent);
                color: white;
            }

            .btn-success:hover {
                background-color: #27ae60;
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
                justify-content: flex-end;
            }

            /* Total da venda */
            .total-container {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 6px;
                margin-top: 20px;
                text-align: right;
                font-size: 1.1rem;
            }

            .total-label {
                font-weight: 600;
                color: var(--dark);
            }

            .total-value {
                font-weight: 700;
                color: var(--accent);
                font-size: 1.3rem;
            }

            /* Responsividade */
            @media (max-width: 768px) {
                .form-container {
                    padding: 20px;
                    width: 95%;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .btn-group {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2 class="form-title">Editar Venda</h2>
            <%
                int idVenda = Integer.parseInt(request.getParameter("id"));
                double total = 0;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conexao = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/sistema?user=root&password=123");

                    // Buscar a venda específica
                    String sqlVenda = "SELECT * FROM venda WHERE id = ?";
                    PreparedStatement stmtVenda = conexao.prepareStatement(sqlVenda);
                    stmtVenda.setInt(1, idVenda);
                    ResultSet rsVenda = stmtVenda.executeQuery();

                    if (rsVenda.next()) {
                        total = rsVenda.getInt("quantidade") * rsVenda.getDouble("preco_unitario");
            %>
            <form action="atualizarVenda.jsp" method="post">
                <input type="hidden" name="id" value="<%= rsVenda.getInt("id")%>">

                <div class="form-row">
                    <div class="form-group">
                        <label>Produto</label>
                        <select name="codigo_produto" class="form-control" required>
                            <%
                                String sqlProdutos = "SELECT codigo, marca FROM produto ORDER BY marca";
                                PreparedStatement stmtProdutos = conexao.prepareStatement(sqlProdutos);
                                ResultSet rsProdutos = stmtProdutos.executeQuery();

                                while (rsProdutos.next()) {
                                    String selected = rsProdutos.getString("codigo").equals(rsVenda.getString("codigo_produto")) ? "selected" : "";
                            %>
                            <option value="<%= rsProdutos.getString("codigo")%>" <%= selected%>>
                                <%= rsProdutos.getString("marca")%>
                            </option>
                            <%
                                }
                                rsProdutos.close();
                                stmtProdutos.close();
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Quantidade</label>
                        <input type="number" name="quantidade" class="form-control"
                               value="<%= rsVenda.getInt("quantidade")%>" min="1" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Preço Unitário (MT)</label>
                        <input type="number" name="preco_unitario" class="form-control" step="0.01"
                               value="<%= rsVenda.getDouble("preco_unitario")%>" min="0" required>
                    </div>
                    <div class="form-group">
                        <label>Data</label>
                        <input type="date" name="data_venda" class="form-control"
                               value="<%= new SimpleDateFormat("yyyy-MM-dd").format(rsVenda.getDate("data_venda"))%>" required>
                    </div>
                </div>

                <div class="total-container">
                    <span class="total-label">Total:</span>
                    <span class="total-value" id="total-venda">
                        <%= String.format("%,.2f", total).replace(",", "X").replace(".", ",").replace("X", ".")%> MT
                    </span>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-success">Salvar Alterações</button>
                    <a href="vendas.jsp" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
            <%
                    }
                    rsVenda.close();
                    stmtVenda.close();
                    conexao.close();
                } catch (Exception e) {
                    out.print("<script>alert('Erro ao carregar dados da venda: " + e.getMessage() + "');</script>");
                }
            %>
        </div>

        <script>
            // Cálculo automático do total da venda
            document.querySelector('input[name="quantidade"]').addEventListener('input', calculateTotal);
            document.querySelector('input[name="preco_unitario"]').addEventListener('input', calculateTotal);

            function calculateTotal() {
                const quantity = parseFloat(document.querySelector('input[name="quantidade"]').value) || 0;
                const price = parseFloat(document.querySelector('input[name="preco_unitario"]').value) || 0;
                const total = quantity * price;
                document.getElementById('total-venda').textContent = total.toLocaleString('pt-BR', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }) + ' MT';
            }
        </script>
    </body>
</html>