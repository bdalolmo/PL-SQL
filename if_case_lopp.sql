--if case loop


DECLARE
    vDesconto varchar2(10);
    vCidade tclientes.cidade%TYPE;
begin
SELECT cidade
into vcidade
FROM tclientes
where id = 210;

if tclientes.cidade = 'Curitiba' then
    vDesconto := 100;   
ELSIF tclientes.cidade = 'Porot Alegre' then
    vDesconto := 150;
else
    vDesconto := 50;
end if;

end;


set SERVEROUTPUT on
declare
vResultado VARCHAR2(30);
vPreco tcursos.preco%TYPE;

begin
select preco
into vpreco
from tcursos
where id=1;

CASE
    WHEN vPreco < 1500
        then  vResultado := 'Preço baixo';
    WHEN vPreco BETWEEN 1500 and 2000
        then  vResultado := 'Preço médio';
    WHEN vPreco > 2000
        then  vResultado := 'Preço alto';
end case; 

DBMS_OUTPUT.PUT_LINE('Resultado: ' || vResultado);

end;


SELECT * FROM tcursos where id=1;
desc tcontratos;
desc tcursos;

select * from titens;

DESC titens;


--loop violated.. duplicate key
declare
    vContrato titens.tcontratos_id%TYPE := 1001;
    vContador NUMBER(10) :=1;
begin
    LOOP
        INSERT INTO titens(tcontratos_id, seq)
            values(vContrato, vContador);
        vcontador := vcontador + 1;
        exit when vcontador > 10;
    end loop;
end;


declare
    vContrato titens.tcontratos_id%TYPE := 1001;
begin
    for i in 1..10 loop
            INSERT INTO titens(tcontratos_id, seq)
                values(vContrato, i);
    end loop;
end;

declare
    vLower number :=1;
    vUpper number :=100;
begin
    for i in vLower..vupper loop
        DBMS_OUTPUT.PUT_LINE (i);
    end loop;
end;


ACCEPT pPreco PROMPT 'Informe o preço do curso: '
ACCEPT pQtde PROMPT 'Informe a quantidade maxima d itens: '
declare
    vQtde number(8) :=1;
    vTotal number(7,2):=0;
begin
    WHILE vQtde < &pQtde loop
        vQtde :=vqtde + 1;
        vtotal := vQtde * &pPreco;
        DBMS_OUTPUT.PUT_LINE('Qtde: '|| vqtde ||' Total: '||vtotal);
    end loop;
end;


-- EXERCICO 4



