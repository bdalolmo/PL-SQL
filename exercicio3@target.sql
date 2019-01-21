variable gMax_contrato NUMBER
DECLARE
    vMax_contrato NUMBER;
BEGIN
    SELECT MAX(id)
    into vMax_contrato 
    FROM tcontratos;
    : gMax_contrato := vmax_contrato;
END;
/
PRINT gMax_contrato


declare
begin
    INSERT into tclientes (id,nome, dt_nascimento)
        values(210, 'Breno Dalolmo', '18/08/78');
    
  EXCEPTION
    WHEN OTHERS THEN
            ROLLBACK;
end;

ROLLBACK;
select * from tclientes;

select * from tcontratos;

declare
    vId tcontratos.id%TYPE;
begin
    select SCONTRATOS_ID.nextval
    into vId
    from dual;
    INSERT into tcontratos (id,dt_compra,tclientes_id,desconto,total)
        values(vId,sysdate,150,null,1000);
    EXCEPTION
      WHEN OTHERS THEN
            ROLLBACK;
end;

SET SERVEROUTPUT on
--ACCEPT pId number PROMPT 'Inform id do contrato: ';
ACCEPT pDt_compra date FORMAT 'DD/MM/YY' PROMPT 'Informe data da compra: ';
ACCEPT pTclientes_id number PROMPT 'Informe id do cliente: ';
ACCEPT pTotal number PROMPT 'Informe Total do contrato: ';
declare
    vId tcontratos.id%TYPE;
BEGIN
    select SCONTRATOS_ID.nextval
    into vid
    from dual;
    insert into tcontratos(id,dt_compra,tclientes_id,desconto, total)
    values(vId,'&pDt_compra','&pTclientes_id', null, '&pTotal');
    
end;

ROLLBACK;


ROLLBACK;

--resolução
set SERVEROUTPUT ON
ACCEPT pId number prompt 'Informe o id do cliente: ' ;
ACCEPT pNome prompt 'Informe o nome do cliente: ' ;
ACCEPT pDt_nasc date FORMAT 'DD/MM/YY' prompt 'Informe a data de nascimento do cliente: ' ;
Begin
    insert into tclientes (id, nome, dt_nascimento)
                            values(&pId, '&pNome','&pDt_nasc');
End;
/




set SERVEROUTPUT on
ACCEPT pId NUMBER PROMPT 'Informe o id do cliente: '
ACCEPT pCidade PROMPT 'Informe a nova cidade do cliente: '
begin
    update tclientes 
    set cidade = '&pCidade'
    where id=&pId;
end;
/


rollback;

select * from tclientes;


set SERVEROUTPUT on
ACCEPT pId number PROMPT 'Informe o id do cliente: '
ACCEPT pCidade PROMPT 'Informe a cidade do cliente: '
begin
    UPDATE tclientes 
    set cidade = '&pCidade'
    where id = &pId;
end;
/


