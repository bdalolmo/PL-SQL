/*1. Crie e execute uma função CONSULTA_PRECO_HORA que retorne o preço de um curso por hora a partir de um código informado 
como parâmetro de entrada
*/

create or replace function CONSULTA_PRECO_HORA
(pId tcursos.id%TYPE)
RETURN number
is
    vPreco tcursos.preco%type;
begin
SELECT round(tcs.preco/tcs.carga_horaria)
into vPreco
from tcursos tcs
where tcs.id = pId;
return(vPreco);
end CONSULTA_PRECO_HORA;


--RESPOSTA
SELECT  consulta_preco_hora(c.ID) "Valor Hora", SUBSTR(c.nome,1 ,20) nome,c.preco, c.CARGA_HORARIA 
FROM tcursos c;



select *
from tcursos
where id=1;

select consulta_preco_hora(1) 
from dual;


select id, nome,COD_TRG,preco,consulta_preco_hora(1) carga ,DT_CRIACAO
from tcursos;

select consulta_preco_hora(3) as "Preço por hora"
from dual;

