
--A segunda declaração cria um registro com os mesmos nomes de campos e tipos de dados que uma linha da tabela TCONTRATOS

set serveroutput on
ACCEPT pid PROMPT 'Digite o Id do cliente: '
DECLARE
cliente_record   tclientes%rowtype;
BEGIN
SELECT  * 
INTO    cliente_record
FROM    tclientes
WHERE   id = &pid;
DBMS_OUTPUT.PUT_LINE(cliente_record.id || ' ' || cliente_record.nome || ' ' || 
cliente_record.cidade || ' ' || cliente_record.estado);
END;

/*Utilizando um Associative Array
Exemplo: Criando um associative array de numeros de 1 a 10.*/
Set Serveroutput On
set verify off
Declare
  Type  Numero_Table_Type  Is Table Of  Integer(2)
  Index By Binary_Integer;
  numero_table  numero_table_type;
Begin
  For  I In  1..10  Loop
     Numero_Table(I) := I;
  End Loop;
  -- Processa outras coisas
  For  I In  1..10  Loop
     Dbms_Output.Put_Line('Associative Array: Indice = ' || To_Char(I) 
     || ', Valor = ' || TO_CHAR(Numero_Table(I)));
  End Loop;
End;

/*Utilizando Nested Tables
Exemplo: Criando um nested table de numeros de 1 a 10.*/
Set Serveroutput On
set verify off
Declare
  Type  Numero_Table_Type  Is Table Of  Integer(2);

  numero_table  numero_table_type := numero_table_type();
Begin
  For  I In  1..10  Loop
     numero_table.extend;
     Numero_Table(I) := I;
  End Loop;
  -- Processa outras coisas
  For  I In  1..10  Loop
     Dbms_Output.Put_Line('Nested Table: Indice = ' || To_Char(I) 
     || ', Valor = ' || TO_CHAR(Numero_Table(I)));
  End Loop;
End;


--Utilizando Varrays
--Exemplo: Criando um Varray de numeros de 1 a 10.
Set Serveroutput On
set verify off
Declare
  Type  Numero_Table_Type  Is VARRAY (10)  Of  Integer(2);

  numero_table  numero_table_type := numero_table_type();
Begin
  For  I In  1..10  Loop
     numero_table.extend;
     Numero_Table(I) := I;
  End Loop;
  -- Processa outras coisas
  For  I In  1..10  Loop
     Dbms_Output.Put_Line('Varyng Array: Indice = ' || To_Char(I) 
     || ', Valor = ' || TO_CHAR(Numero_Table(I)));
  End Loop;
End;



--Exemplo de utilização dos métodos de Collections
set serveroutput on
DECLARE
  TYPE numero_table_type IS TABLE OF INTEGER(3);
  numero_table  numero_table_type := numero_table_type();
BEGIN
  numero_table.extend(100);
  FOR i IN 1..100  LOOP
      numero_table(i) := i;
  END LOOP;
  numero_table.delete(7);
  FOR i IN numero_table.first..numero_table.last  LOOP
      IF  numero_table.exists(i)  THEN  
          DBMS_OUTPUT.PUT_LINE('Numero =  ' || TO_CHAR(numero_table(i)));
      END IF;
  END LOOP;
END;
/

--exemplo
declare
    type algumaCoisa is table of integer(2);
    n_table algumaCoisa:=algumaCoisa();
begin
    n_table.extend(10);
    for i in 1..10 loop
        n_table(i) :=i;
    end loop;
    for i IN n_table.first..n_table.last LOOP
        DBMS_OUTPUT.PUT_LINE ('n-'||n_table(i));
      END LOOP;
end;


/*Exemplo de utilização dos métodos de Collections
Exemplo:*/

set serveroutput on
DECLARE
  TYPE numero_table_type IS TABLE OF INTEGER(2);
  numero_table  numero_table_type := numero_table_type();
BEGIN
  numero_table.extend(10);
  FOR i IN 1..10  LOOP
      numero_table(i) := i;
  END LOOP;
  numero_table.delete(7);
  FOR i IN numero_table.first..numero_table.last  LOOP
      IF  numero_table.exists(i)  THEN  
          DBMS_OUTPUT.PUT_LINE('Numero =  ' || TO_CHAR(numero_table(i)));
      END IF;
  END LOOP;
END;
/

select * from tclientes;






-- Exemplo utilização dos metodos de collections -- com erro
Declare
  Type  nome_table_type  Is Table Of tclientes%ROWTYPE
    Index By Binary_Integer;
  nome_table  nome_table_type;
  CURSOR tclCursor IS
  select *
  from tclientes;
  i number;
Begin
    i := -5;
  For tcl_record In  tclCursor  Loop
     nome_table(i) := tcl_record;
     i :=i+10;
  End Loop;
   Dbms_Output.Put_Line('Quantidade de elementos = ' || nome_table.count);
   Dbms_Output.Put_Line('Nome do primeiro elemento = ' || nome_table(nome_table.first).nome);
   Dbms_Output.Put_Line('Data de nascimento do ultimo elemento = ' || nome_table(nome_table.last).dt_nascimento);
   nome_table.delete(10,30);
   Dbms_Output.Put_Line('Quantidade de elementos = ' || nome_table.count);
   nome_table.delete;
   Dbms_Output.Put_Line('Quantidade de elementos = ' || nome_table.count);
End;
/


