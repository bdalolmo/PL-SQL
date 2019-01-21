/*Exercícios - Capítulo 07
1. Crie um script para exibir o total de um contrato a partir do seu número 
(id), trate os erros possíveis fornecendo as mensagens adequadas. 
Salve o exercício em um arquivo chamado e7q1.sql.


Informe o id do contrato: 1001
Total = 4500

Procedimento PL/SQL concluído com sucesso.


Informe o id do contrato: 1100
DECLARE
*
ERRO na linha 1:
ORA-20001: Contrato inexistente! 
ORA-06512: at line 10*/


set SERVEROUTPUT ON
accept pId number prompt 'Informe o numero do contrato: ';
declare
    vTotal tcontratos.total%type;
begin
    select Total
    into    vTotal
    FROM tcontratos
    where id = &pId;

    DBMS_OUTPUT.put_line('Total: '||vtotal);
    
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cliente Inexistente!'||SQLCODE||' '
                                     ||SQLERRM);
    WHEN others THEN
        RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida!'||SQLCODE||' '
                                     ||SQLERRM);
     
end;

select * from tcontratos;