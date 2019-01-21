select * from tclientes;


set SERVEROUTPUT ON

declare
    vId         tclientes.id%type;
    vNome       tclientes.nome%TYPE;
    
    cursor c1 is
    SELECT
        id,nome
    FROM tclientes;
begin
    open c1;
    for i in 1..10 loop
        fetch c1 into vId, vNome;
        DBMS_OUTPUT.put_line(vNome);
    end loop;

end;