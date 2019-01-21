--Exercicios

--1. Liste o nome e o status de todos os procedimentos e funções que você possui. Salve o exercício em um arquivo chamado e10q1.sql.
SELECT    object_name, object_type, status
FROM      user_objects
where object_type IN ('PROCEDURE','FUNCTION')
ORDER BY  object_type;

--2. Liste o código fonte completo da função CONSULTA_PRECO_HORA. Salve o exercício em um arquivo chamado e10q2.sql.
 SELECT line||'/'||position pos, text
    FROM   user_errors
    WHERE  name = 'CONSULTA_PRECO_HORA'
    ORDER BY line;
 
 

/*3. Altere a função CONSULTA_PRECO_HORA de modo a deliberadamente provocar um erro, por exemplo, retire o ponto-e-vírgula do comando
SELECT. Tente recriar a função.*/

 

--4. Liste os erros de compilação da função CONSULTA_PRECO_HORA.

 

--5. Corrija a função CONSULTA_PRECO_HORA e re-compile.

 

--6. Liste o nome e o status de todos os seus procedimentos e funções. Salve o comando SQL para um arquivo chamado status_objetos.sql.

 

--7. Liste o nome e o tipo de todos os objetos com dependências diretas da tabela TCURSOS.

 

/*8. Liste todas as dependências diretas e indiretas da tabela TCURSOS. Execute o script "utldtree.sql" para criar as 
tabelas DEPTREE e IDEPTREE e o procedimento DEPTREE_FILL para o seu usuário. Preencha os dados das visões DEPTREE e IDEPTREE 
executando o procedimento DEPTREE_FILL para a tabela TCURSOS do seu usuário.

--Consulte a visão DEPTREE.
--Consulte a visão IDEPTREE.*/
 

--9. Invalide o procedimento CADASTRA_CLIENTE, adicionando uma coluna chamada PAIS, do tipo VARCHAR2(30), na tabela TCLIENTES.

 

--10. Consulte novamente o nome e o status dos procedimentos e funções.

 

--11. Tente executar o procedimento CADASTRA_CLIENTE. O que acontece?

 

--12. Consulte novamente o nome e o status dos procedimentos e funções.

