/*Exemplos de Consultas
Consultando o nome de todas as procedures e fun��es do usu�rio conectado.*/

SELECT object_name, object_type
FROM   user_objects
WHERE  object_type IN ('PROCEDURE', 'FUNCTION')
ORDER  BY object_name;


--Consultando o c�digo fonte da procedure

SELECT text
FROM   user_source
WHERE  type = 'PROCEDURE'  AND 
       name = 'CADASTRA_CLIENTE'
order by line;

--Consultando a Lista de Par�metros -Consultando a lista de par�metros do procedimento CADASTRA_CLIENTE.
 DESCRIBE cadastra_cliente;


--Consultando a lista de par�metros da fun��o CONSULTA_CURSO.

 DESCRIBE consulta_preco
 
 --Consultando os erros de sintaxe do procedimento CADASTRA_CLIENTE.
 COLUMN pos FORMAT a4
 COLUMN text FORMAT a60

 SELECT line||'/'||position pos, text
    FROM   user_errors
    WHERE  name = 'CADASTRA_CLIENTE'
    ORDER BY line;
 
 
 --Consultando os erros de sintaxe da procedure CADASTRA_CLIENTE.
 SHOW ERRORS PROCEDURE CADASTRA_CLIENTE
 
 --Exemplo: Consultando depend�ncias diretas sobre a tabela TCLIENTES.
SELECT name, type, referenced_name, referenced_type
FROM   user_dependencies
WHERE  referenced_name IN ('TCLIENTES');

--Re-compilando Procedures e Fun��es

ALTER PROCEDURE aumenta_desconto COMPILE;

--Compilando uma Fun��o
ALTER FUNCTION consulta_preco COMPILE;



/*Verificando o Status de Procedimentos e Fun��es
Consulte o status de seus objetos (procedimentos, fun��es, pacotes, vis�es, gatilhos)
pela coluna STATUS da vis�o do dicion�rio de dados USER_OBJECTS.*/

SELECT    object_name, object_type, status
FROM      user_objects
ORDER BY  object_type;


--#################################################-----

select * from utldtree;

create sequence DEPTREE;


create sequence IDEPTREE;


exec DEPTREE_FILL( 'object_type', 'object_owner', 'object_name' );--ver ordem

exec DEPTREE_FILL( 'object_owner','object_type', 'object_name' );

EXEC deptree_fill('BRENO','TABLE','TCLIENTES'); --nao encontrado BRENO TABLE.TCLIENTES 

SELECT nested_level, type, name
FROM   deptree
ORDER BY seq#;

-- Ou

SELECT  rpad(' ', nested_level * 10 ) || type || ' ' || name
FROM    deptree
ORDER BY seq#;

---Consultando a vis�o IDEPTREE.
SELECT *
FROM   ideptree;


------------------------------
--
Select * from USER_OBJECTS where OBJECT_TYPE in ('PROCEDURE','FUNCTION');
--
Select line, text from USER_SOURCE where name like 'CONSULTA_PRECO_HORA';
--
show ERRORS CONSULTA_PRECO_HORA;

--
select  object_name, status from USER_OBJECTS;

-- 
EXEC deptree_fill('TABLE', 'CASSIO', 'TCURSOS');

-- DEPTREE.
SELECT  *
FROM    deptree
ORDER BY seq#;

-- IDEPTREE.
SELECT * FROM   ideptree;