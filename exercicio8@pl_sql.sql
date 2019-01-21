/*1. Crie uma tabela chamada DESCONTOS_PADROES a partir da seleção de todos os registros da tabela TCONTRATOS a partir das 
colunas ID, DESCONTO e TOTAL. Salve o exercício em um arquivo chamado e8q1.sql.*/

create table DESCONTOS_PADROES as select id,desconto, total from tcontratos;

select id,desconto, total from DESCONTOS_PADROES;

/*SQL> DESC descontos_padroes
 Nome                                         Nulo?    Tipo
 ------------ ------------------------------- -------- ------------
 ID                                           NOT NULL NUMBER(4)
 DESCONTO                                              NUMBER(7,2)
 TOTAL                                                 NUMBER(10,2)*/


/*Crie um procedimento de banco de dados chamado MODIFICA_DESCONTO que atualiza o desconto dos contratos conforme a porcentagem 
passada por parâmetro (por exemplo 25, para 25%) em relação ao total do contrato da tabela DESCONTOS_PADROES. 
Não esqueça que todos os contratos devem possuir descontos de acordo com esta regra. Forneça os tratamentos de erros adequados.
Salve o exercício em um arquivo chamado e8q2.sql.*/


select id,desconto, total from DESCONTOS_PADROES;

rollback;

create or replace procedure MODIFICA_DESCONTO(
pDesc DESCONTOS_PADROES.desconto%type)
is
begin
    update DESCONTOS_PADROES 
    set desconto = desconto * ((pDesc/100)+1);
    
EXCEPTION 
    WHEN  no_data_found  THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cliente inexistente');
    WHEN  others  THEN
      RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle' || SQLCODE || SQLERRM);
END MODIFICA_DESCONTO;


EXECUTE modifica_desconto(30);



/*SQL> EXECUTE modifica_desconto(30)

Procedimento PL/SQL concluído com sucesso.

SQL> EXECUTE modifica_desconto(25)

Procedimento PL/SQL concluído com sucesso.*/