--Exercicios

--1. Liste o nome e o status de todos os procedimentos e fun��es que voc� possui. Salve o exerc�cio em um arquivo chamado e10q1.sql.
SELECT    object_name, object_type, status
FROM      user_objects
where object_type IN ('PROCEDURE','FUNCTION')
ORDER BY  object_type;

--2. Liste o c�digo fonte completo da fun��o CONSULTA_PRECO_HORA. Salve o exerc�cio em um arquivo chamado e10q2.sql.
 SELECT line||'/'||position pos, text
    FROM   user_errors
    WHERE  name = 'CONSULTA_PRECO_HORA'
    ORDER BY line;
 
 

/*3. Altere a fun��o CONSULTA_PRECO_HORA de modo a deliberadamente provocar um erro, por exemplo, retire o ponto-e-v�rgula do comando
SELECT. Tente recriar a fun��o.*/

 

--4. Liste os erros de compila��o da fun��o CONSULTA_PRECO_HORA.

 

--5. Corrija a fun��o CONSULTA_PRECO_HORA e re-compile.

 

--6. Liste o nome e o status de todos os seus procedimentos e fun��es. Salve o comando SQL para um arquivo chamado status_objetos.sql.

 

--7. Liste o nome e o tipo de todos os objetos com depend�ncias diretas da tabela TCURSOS.

 

/*8. Liste todas as depend�ncias diretas e indiretas da tabela TCURSOS. Execute o script "utldtree.sql" para criar as 
tabelas DEPTREE e IDEPTREE e o procedimento DEPTREE_FILL para o seu usu�rio. Preencha os dados das vis�es DEPTREE e IDEPTREE 
executando o procedimento DEPTREE_FILL para a tabela TCURSOS do seu usu�rio.

--Consulte a vis�o DEPTREE.
--Consulte a vis�o IDEPTREE.*/
 

--9. Invalide o procedimento CADASTRA_CLIENTE, adicionando uma coluna chamada PAIS, do tipo VARCHAR2(30), na tabela TCLIENTES.

 

--10. Consulte novamente o nome e o status dos procedimentos e fun��es.

 

--11. Tente executar o procedimento CADASTRA_CLIENTE. O que acontece?

 

--12. Consulte novamente o nome e o status dos procedimentos e fun��es.

