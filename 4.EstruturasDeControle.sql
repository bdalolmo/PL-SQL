-- capitulo 4 Escrevendo Estruturas de controle
-- CASE / IF

SET SERVEROUTPUT on
declare 
vResultado varchar2(30); 
vPreco tcursos.preco%type;
vNome tcursos.nome%TYPE;


begin

select nome, preco
into vNome,vPreco
from tcursos
where id=1;

CASE
    WHEN vPreco > 2000
        then vResultado := 'Preco Alto';
    when vPreco BETWEEN 1500 and 2000
        then vResultado := 'Preço Medio';
    when vPreco <1500
        then vResultado := 'Preco baixo';
end case;

DBMS_OUTPUT.PUT_LINE('O preco do curso *** '||vnome||' *** Eh R$:' ||vpreco 
||' e esta com:' ||vresultado);

end;
/

select * from tcursos;

select * from titens;

desc titens;

--LOOP BASICO 

DECLARE -- com erro
    vContrato titens.tcontratos_id%TYPE:=1001;
    --vTotal titens.total%TYPE;
    vContador NUMBER(10) :=1;
begin

    LOOP
        insert into titens(tcontratos_id, seq)
                   values(vContrato, vContador);
        vContador :=vcontador + 1;
        EXIT WHEN vcontador > 10;
    end loop;
end;


--FOR LOOP
declare
    vInicio number :=1;
    vFinal number :=20;
begin
    for i in vInicio..vFinal loop
        dbms_output.put_line(i);
    end loop;
end;



dECLARE -- com erro restrição
    vContrato titens.tcontratos_id%TYPE:=1001;
begin
    for i in 1..10 loop
        insert into titens(tcontratos_id, seq)
                   values(vContrato, i);
    end loop;
end;


--while loop

ACCEPT pPreco PROMPT 'Informe preco do curso: ';
ACCEPT pQtde PROMPT 'Informe quantidade maxima de itens: '
declare
    vQtde       number(8) :=1;
    vTotal      NUMBER(7,2):=0;
begin
    while vQtde < &pQtde loop
        vQtde := vQtde +1;
        vTotal := vQtde * &pPreco;
    end loop;
    DBMS_OUTPUT.PUT_LINE(vTotal);

end;





ROLLBACK
