 select * from tclientes;
 
 select * from tcontratos;
 
 
 SET SERVEROUTPUT ON
 declare
    Cursor c1 is
     select * 
     from tclientes;
     
     
    Cursor c2 (xxx tclientes.id%type) is
    select * 
    from tcontratos
    where tclientes_id=xxx;
    
 begin
 
    for recor_cli in c1 loop
        SYS.dbms_output.put_line(recor_cli.nome);
        for recor_contr in c2(recor_cli.id)loop
            DBMS_OUTPUT.PUT_line(' Total:  '||recor_contr.total);
        end loop;
    end loop;
  end;
  

select * from tcursos;

select * from titens;

select cur.nome,cur.preco,tit.total 
from tcursos cur 
join titens tit
on (cur.id = tit.tcursos_id);

