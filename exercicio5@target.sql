/*1. Crie uma variável record para armazenar todos os dados de um contrato a partir da estrutura da tabela de contratos (tcontratos).
Receba o id do contrato e exiba as informações do contrato informado. Salve o exercício em um arquivo chamado e5q1.sql.*/


set SERVEROUTPUT ON
accept pId number prompt 'Informe id do contrato: '

declare
    contrato_record tcontratos%ROWTYPE;
begin
    SELECT *
    into contrato_record
    FROM tcontratos
    where id= &pId;
    DBMS_OUTPUT.put_line('Contrato: '||contrato_record.id);
    DBMS_OUTPUT.put_line('Data de Compra: '||contrato_record.dt_compra);
    DBMS_OUTPUT.put_line('Contrato: '||contrato_record.desconto);
    DBMS_OUTPUT.put_line('Contrato: '||contrato_record.total);
    
end;
/

SELECT * FROM tcontratos;
    