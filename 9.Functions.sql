CREATE OR REPLACE FUNCTION consulta_preco
(pId IN tcursos.id%TYPE)
RETURN NUMBER 
IS
  vPreco   tcursos.preco%TYPE := 0;
BEGIN
  SELECT preco
  INTO   vPreco
  FROM   tcursos
  WHERE  id = pId;
  RETURN(vPreco);
  -- Comandos

EXCEPTION
WHEN  no_data_found THEN 
      raise_application_error(-20001, 'Curso inexistente');
WHEN  others THEN 
      raise_application_error(-20002, 'Erro Oracle ' || SQLCODE ||
      SQLERRM);
END consulta_preco;


select * from tcursos;

SELECT tcontratos_id, seq, qtde, total, consulta_preco(tcursos_id) preco
FROM   titens;

------------TYTYP
create or replace function seleciona
(pId in tcursos.id%TYPE)
RETURN VARCHAR2
IS
    vNome tcursos.nome%type :='';
    vPreco tcursos.preco%type :=0;
begin
  SELECT nome , preco
  INTO   vNome, vPreco
  FROM   tcursos
  WHERE  id = pId;
  return (vNome);
end seleciona;

select * from titens;

select * from tcursos;

select * from tclientes;



SELECT nome,cidade,estado,seleciona(id)
FROM   tclientes;

SELECT seleciona(10)nome
FROM  dual;

---------------------------

CREATE or replace FUNCTION existe_cliente( pId IN tclientes.id%TYPE) RETURN BOOLEAN
IS
  vvar   NUMBER(1);
BEGIN
  SELECT 1
  INTO   vvar
  FROM   tclientes
  WHERE  id = pId;
  RETURN( TRUE );

EXCEPTION
  WHEN others THEN
    RETURN( FALSE );
end existe_cliente;


 
create or replace PROCEDURE cadastra_cliente (pid        IN tclientes.id%TYPE,
                            pnome      IN tclientes.nome%TYPE,
                            pcidade    IN tclientes.cidade%TYPE,
                            pestado    IN tclientes.estado%TYPE)
IS
BEGIN
  IF( NOT existe_cliente(pid) )THEN
      INSERT INTO tclientes (id, nome, cidade, estado)
      VALUES ( pid, pnome, pcidade, pestado);
  END IF;
END;


exec cadastra_cliente (pid  => 240, pnome  => 'Breno',  pcidade => 'São Paulo', pestado => 'SP');

select * from tclientes where id = 240;

select * from tclientes;

/*Quando uma função é apropriada, e quando um procedimento é apropriado? 
Depende da quantidade de valores que o subprograma irá retornar e como serão utilizados esses valores. 
A regra de convenção é que se for retornado mais de um valor, utilize um procedimento. Se somente um valor for retornado,
uma função pode ser utilizada. Embora seja possível uma função conter parâmetros de saída (OUT), assim retornando mais de um valor, 
é considerado uma forma de programação não aconselhável.*/



