 /*1. Crie um bloco PL/SQL que calcule o desconto de um contrato baseado no seu total. Salve o bloco PL/SQL para um arquivo chamado e4q1.sql.

a)      Utilize a tabela chamada TCONTRATOS.

b)     Utilizando o comando ACCEPT Receba o número do contrato.

c)      Se o total do contrato for menor que R$1000, atribua para o desconto o valor de 10% do total.

d)     Se o total do contrato está entre R$1000 e R$3000, atribua para o desconto o valor de 15% do total.

e)      Se o total do contrato for maior que R$3000, atribua para o desconto o valor de 20% do total.

f)       Efetue o COMMIT das modificações.*/


set SERVEROUTPUT on
ACCEPT pId number prompt 'Informe numero do contrato: ';
declare
    vtotal tcontratos.total%type;
    vDesconto tcontratos.desconto%type;
BEGIN
    select total
    into vTotal
    from TCONTRATOS
    where id=&pId;
    
CASE 
    WHEN vtotal > 1000
        then vTotal := vdesconto * 0.1;
    WHEN vtotal BETWEEN 1000 and 3000
        then vTotal := vdesconto * 0.15;
     WHEN vtotal > 3000
        then vTotal := vdesconto * 0.20;
end CASE;
DBMS_OUTPUT.PUT_LINE('Valor do desconto do contrato '|| 'pid' ||' eh ' || vTotal);
END;

--RESOLUÇÃO

set SERVEROUTPUT on
ACCEPT pId number prompt 'Informe numero do contrato: ';
declare
    vtotal tcontratos.total%type;
    vDesconto tcontratos.desconto%type;
BEGIN
    select total
    into vTotal
    from TCONTRATOS
    where id=&pId;
    
CASE 
    WHEN vtotal > 1000 then
        vdesconto := vTotal * 0.1;
    WHEN vtotal BETWEEN 1000 and 3000 then
        vdesconto := vTotal * 0.15;
     WHEN vtotal > 3000 then
        vdesconto := vTotal * 0.2;
end CASE;
UPDATE tcontratos
SET DESCONTO = vdesconto
WHERE id = &PID;
DBMS_OUTPUT.PUT_LINE('Valor do desconto do contrato '|| &PID ||' eh ' || vTotal);
END;


ROLLBACK;

select * from TCONTRATOS;

/* 2. Escreva um bloco PL/SQL para inserir números na tabela MENSAGENS. Salve o exercício para um arquivo chamado e4q2.sql.

a)      Insira os números de 1 a 10 excluindo o 6 e 8.

b)     Execute um COMMIT antes do final do bloco.

c)      Execute o seu bloco anônimo. Verifique se a execução foi correta selecionando os dados da tabela MENSAGENS.*/


create table numeros(
num number);

begin
    FOR i IN 1..10 LOOP
    if i <> 6 and i <>8 then
          insert into numeros(num)
          values(i);
     end if;   
        END LOOP;
end;

delete numeros;

select * from numeros;

