set SERVEROUTPUT ON

declare
    vId         tclientes.id%type;
    vNome       tclientes.nome%TYPE;
    
    cursor c1 is
    SELECT
        id,nome
    FROM tclientes;
begin
    IF NOT c1%ISOPEN THEN
        open c1;
    END IF;
    for i in 1..10 loop
        fetch c1 into vId, vNome;
        DBMS_OUTPUT.put_line(vNome);
    end loop;
    CLOSE c1;
end;



declare
    vId         tclientes.id%type;
    vNome       tclientes.nome%TYPE;
    
    cursor c1 is
    SELECT
        id,nome
    FROM tclientes;
begin
    IF NOT c1%ISOPEN THEN
        open c1;
    END IF;
    loop
        fetch c1 into vId, vNome;
        EXIT WHEN C1%ROWCOUNT>10 or c1%notfound;
        DBMS_OUTPUT.put_line(vId||' - '||vnome);
    end loop;
    CLOSE c1;
end;



--Cursores e Registros
set SERVEROUTPUT ON 
declare
      
    cursor c1 is
    SELECT
        id,nome
    FROM tclientes;
    
    cliente_record c1%ROWTYPE;
    

begin
    open c1;
    LOOP
        fetch c1 into cliente_record;
        DBMS_OUTPUT.put_line(cliente_record.nome);
        EXIT WHEN C1%ROWCOUNT>10 or c1%notfound;
        
    END LOOP;
    CLOSE c1;
end;

--CURSOR FOR LOOP


set SERVEROUTPUT ON 
declare
      --erro
    cursor c2 is
        SELECT 
            id,nome
    FROM tclientes;
    
   --client_record c2%ROWTYPE; 
begin
  --open c2;
    FOR client_record in c2 loop
        DBMS_OUTPUT.put_line(client_record.nome);
        exit when c2%rowcount=3;
    end loop;
  --CLOSE c2;
end;




declare 
CURSOR c1(vCarga_horaria number, vPre_requisito number)is
    SELECT *
    FROM tcursos
    where
    carga_horaria = vCarga_horaria and
    pre_requisito = vPre_requisito;
    
begin
    for curso_record in c1(30,1) loop
        select * into curso_record from tcursos
        where id=1;
        --EXIT WHEN C1%ROWCOUNT>10 or c1%notfound;
    end loop;

end;


-- FOR UPDATE
declare
    CURSOR c1 is
    SELECT nome
    FROM tclientes
    for UPDATE;
    
begin
    for cliente_record in c1 loop
        UPDATE tclientes
        set nome = UPPER(cliente_record.nome)
        where CURRENT OF c1;
    end loop;
   
end;

select * from tclientes;

ROLLBACK;

-----exemplo site target
set serveroutput on
DECLARE
  CURSOR  tcursos_cursor  IS
  SELECT  nome, preco
  FROM    tcursos;
  tcursos_record  tcursos_cursor%rowtype;
BEGIN
  /* Inicializa */
  OPEN  tcursos_cursor;
  FETCH  tcursos_cursor  
    INTO  tcursos_record;
  /* Loop */
  WHILE  tcursos_cursor%found  LOOP
    DBMS_OUTPUT.PUT_LINE(tcursos_record.nome || ' - ' || 
    LTRIM(TO_CHAR(tcursos_record.preco, 'L99G999G999D99')));
    FETCH  tcursos_cursor  
    INTO  tcursos_record;
  END LOOP;
  
  CLOSE tcursos_cursor;
END;



--Exemplo 1: Listando os 3 cursos com preços mais caros.
set serveroutput ON
DECLARE
CURSOR   tcursos_cursor IS
SELECT   nome, preco
FROM     tcursos
ORDER BY preco DESC;
BEGIN
FOR  tcursos_record  IN  tcursos_cursor  LOOP   
     DBMS_OUTPUT.PUT_LINE(tcursos_record.nome || ' - ' || 
     trim(to_char(tcursos_record.preco, 'L99G999G999D99')));
     EXIT  WHEN  tcursos_cursor%rowcount  = 3;
END LOOP;
END;


--Exemplo 2: Listando os 3 cursos com preços mais caros (otimizando o select).
set serveroutput ON
DECLARE
CURSOR   tcursos_cursor IS
SELECT   nome, preco, rownum
FROM     (SELECT   nome, preco
          FROM     tcursos
          ORDER BY preco DESC)
where    rownum < 4;
BEGIN
FOR  tcursos_record  IN  tcursos_cursor  LOOP   
     DBMS_OUTPUT.PUT_LINE(tcursos_record.nome || ' - ' || 
     trim(to_char(tcursos_record.preco, 'L99G999G999D99')));
END LOOP;
END;

