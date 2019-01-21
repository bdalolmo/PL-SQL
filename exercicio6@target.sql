--exercicios cursores
/*1. Crie um cursor para recuperar os clientes do Rio Grande do Sul. Utilize um outro cursor para recuperar os contratos dos clientes
que recebe como parâmetro o identificador do cliente. Exiba o total dos contratos dos clientes selecionados.
Salve o exercício em um arquivo chamado e6q1.sql. */

set SERVEROUTPUT ON
declare 
CURSOR clients_RS is
    SELECT *
    FROM tclientes
    where ESTADO = 'RS';
CURSOR contrat (pCliente tclientes.id%type)is
    SELECT *
    FROM tcontratos
    where tclientes_id=pCliente;
  begin
    for clientes_recorde in clients_RS loop
        DBMS_OUTPUT.PUT_LINE ('Cliente '|| clientes_recorde.nome || ' possui os seguintes contratos: ');
        for contratos_record in contrat(clientes_recorde.id)loop
            DBMS_OUTPUT.PUT_LINE ('Contrato '|| contratos_record.id || ' Total  = '||contratos_record.total);
            end loop;    
    end loop;
end;

---------correção
set serveroutput ON
DECLARE
CURSOR   cur_clientes IS
    SELECT   *
     FROM    tclientes
    WHERE   estado = 'RS';
    
CURSOR cur_contratos(pId_Cliente TCLIENTES.ID%type) IS
    SELECT *
     FROM  tcontratos
    WHERE TCLIENTES_ID = pId_Cliente; 

BEGIN
FOR  clientes_record  IN  cur_clientes  LOOP   
     DBMS_OUTPUT.PUT_LINE('Cliente ' || clientes_record.nome || ' possui os seguintes contratos:');
     FOR  contratos_record  IN  cur_contratos(clientes_record.id)  LOOP   
        DBMS_OUTPUT.PUT_LINE('Contrato ' ||  contratos_record.id || ' Total = ' || contratos_record.total);
     END LOOP;
END LOOP;
END;
/




select * from tclientes;

select * from TCONTRATOS;