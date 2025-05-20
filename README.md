# TechStore
Sistema para Vendas Online de Equipamentos Electónicos ref. ao trabalho semestral da disciplina de Programação Web.
Desenvolvido pelos estudantes: 
Filomena Lopes Gaspar -GitHub: filomena2002
João Langa - GitHub: LangaJoao
Ussene Carlos Matato -GitHub: ussenematato

# Requisitos Funcionais
* Produtos 
- Cadastro de produtos
- Actualização de produtos
- Edição do dados dos produtos
- Eliminação de produtos cadastrados

* Vendas/Compras
- Gestão de vendas efectuadas permitindo visualizar o total de vendas
- Listagem de compras efectuadas por clientes

# Gestão de dados
Os dados são armazenadas atraves do SGBD mysql

# Perfis de Acesso
- Cliente (apenas efectua compras de produtos)
- Administrador (Faz a gestão de produtos e visualiza as compras efectuadas pelos clientes)

# Acesso ao Sistema
1. Adicionar o servidor Apache-TomCat-9.0.104
2. Criar um schema com o nome: sistema e fazer importação da base de dados no SGBD mysql
3. importar bibliotecas (mysql conector) "encontrado na pasta lib"
4. Para LogIn como administrador:
email: techstore@gmail.com
senha: 123
