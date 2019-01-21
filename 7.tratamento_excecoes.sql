--Exemplo 2: Usando RAISE_APPLICATION_ERROR para tratar uma exceção NO_DATA_FOUND.
set serveroutput on
ACCEPT  pid PROMPT 'Digite o codigo do Cliente: '
DECLARE
  vnome  tclientes.nome%TYPE;
BEGIN
  SELECT nome
  INTO   vnome
  FROM   tclientes
  WHERE  id = &pid;
  -- Comandos
  DBMS_OUTPUT.PUT_LINE('Cliente = ' || vnome);
  
EXCEPTION
 WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR(-20001, 'Cliente não encontrado, id = ' ||  TO_CHAR(&pid));
  WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
END; -- Exceções Pré-definidas Oracle



select * from tclientes;
--SQLCODE e SQLERRM
set SERVEROUTPUT ON
DECLARE
   vNome     tclientes.nome%TYPE := 'Carlos Magno';
   vCidade   tclientes.cidade%TYPE;
BEGIN
   SELECT cidade
   INTO   vCidade
   FROM   tclientes
   WHERE  nome = vNome;
   -- Comandos

EXCEPTION
  WHEN no_data_found THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cliente Inexistente!');
  WHEN too_many_rows THEN
    RAISE_APPLICATION_ERROR(-20002, 'Cliente Duplicado! ');
  WHEN others THEN
    RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida!'||SQLCODE||' '
                                     ||SQLERRM);
END;


--Exceções Disparadas pelo Desenvolvedor

set SERVEROUTPUT ON
DECLARE
   vDt_vencimento DATE;
   vValor         NUMBER;
   vJuros         NUMBER;
   vConta         NUMBER := 100;
   eConta_vencida EXCEPTION;
BEGIN
   SELECT data_vencimento, valor, juros
   INTO   vDt_vencimento, vValor, vJuros
   FROM   contas
   WHERE  codigo = vConta;

      
   IF   vDt_vencimento < TRUNC(SYSDATE) THEN
        RAISE eConta_vencida;  
        
   END IF;

  
EXCEPTION
   WHEN eConta_vencida THEN
        UPDATE contas
        SET    valor = valor + juros
        WHERE  conta = vConta;
        DBMS_OUTPUT.PUT_LINE('EsseValor - '||vvalor);
        
        
DBMS_OUTPUT.PUT_LINE('Data: '||vdt_vencimento);
DBMS_OUTPUT.PUT_LINE('Valor - '||vvalor);   
DBMS_OUTPUT.PUT_LINE('Juros - '||vjuros);
    
END;

rollback;

--Tratamento de Erros Oracle utilizando Pragma
DECLARE
   vid             tcontratos.id%TYPE := 2000;
   vtotal          tcontratos.total%TYPE := 1500;
   vcliente        tcontratos.tclientes_id%TYPE := 777;
   efk_inexistente EXCEPTION;
   PRAGMA EXCEPTION_INIT(efk_inexistente, -2291);

BEGIN
   INSERT INTO tcontratos (id, dt_compra, tclientes_id, desconto, total)
   VALUES (vid, SYSDATE, vcliente, vtotal*.3, vtotal);
   -- Comandos
EXCEPTION
   WHEN  efk_inexistente THEN
         RAISE_APPLICATION_ERROR(-20200, 'Cliente inexistente!');
END;


select* from contas;



create table contas(
id number(10),
codigo number(10),
conta number(10),
data_vencimento date,
valor number(10),
juros float(10));


delete contas;

insert into contas(id,codigo,conta, data_vencimento ,valor, juros)
        values(1,100,123,'18/08/18',200,2);

drop table contas; 


