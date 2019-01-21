/*1. Crie uma package chamada PCK_CLIENTE. Essa package deve possuir:

Procedimentos para inserir um cliente (INSERE_CLIENTE), remover um cliente (REMOVE_CLIENTE) e exibir as informações de um cliente (EXIBE_CLIENTE).
Uma função para verificar se um cliente já existe (EXISTE_CLIENTE).
Defina todas as rotinas para acesso público.*/

select * from tclientes;

create or replace package PCK_CLIENTE
is
FUNCTION existe_cliente(pId in tclientes.id%TYPE)
return boolean;

procedure INSERE_CLIENTE(pId IN tclientes.id%TYPE,
               pNome IN tclientes.nome%TYPE,
               pEndereco IN tclientes.endereco%TYPE,
               pCidade IN tclientes.cidade%TYPE,
               pEstado IN tclientes.id%TYPE);

procedure remove_cliente(pId in tclientes.id%TYPE);

PROCEDURE exibe_cliente  (pid     IN OUT tclientes.id%TYPE,
                            pnome      OUT tclientes.nome%TYPE,
                            pendereco  OUT tclientes.endereco%TYPE,
                            pcidade    OUT tclientes.cidade%TYPE,
                            pestado    OUT tclientes.estado%TYPE);

END pck_cliente;

CREATE OR REPLACE PACKAGE BODY PCK_CLIENTE
IS
    FUNCTION existe_cliente( pId IN tclientes.id%TYPE) RETURN BOOLEAN
    IS
        vId  tclientes.id%TYPE;
    BEGIN
        SELECT id
        INTO   vId
        FROM   tclientes
        WHERE  id = pId;
        RETURN( TRUE );

    EXCEPTION
    WHEN others THEN
        RETURN( FALSE );
    end existe_cliente;
    
    PROCEDURE INSERE_CLIENTE (pId IN tclientes.id%TYPE,
                       pNome IN tclientes.nome%TYPE,
                       pEndereco IN tclientes.endereco%TYPE,
                       pCidade IN tclientes.cidade%TYPE,
                       pEstado IN tclientes.id%TYPE)
    IS
    BEGIN
    if (not existe_cliente(pId)) then
       INSERT INTO tclientes(id, nome, endereco,cidade, estado)
       VALUES (pId,pNome,pEndereco,pCidade,pEstado);
    ELSE
         RAISE too_many_rows;
    END IF;
   EXCEPTION
     WHEN no_data_found THEN
       RAISE_APPLICATION_ERROR(-20001, 'Cliente Inexistente! ');
     WHEN too_many_rows THEN
       RAISE_APPLICATION_ERROR(-20002, 'Cliente Duplicado! ');
    WHEN others THEN
      RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida!'||SQLCODE||' '
                                     ||SQLERRM);
  END insere_cliente;
 

 PROCEDURE remove_cliente(pid IN tclientes.id%TYPE)
  IS
   BEGIN
     IF (existe_cliente(pid)) THEN
        DELETE FROM tclientes
         WHERE id = pid;
     ELSE 
        RAISE no_data_found;
     END IF;
   EXCEPTION
     WHEN no_data_found THEN
       RAISE_APPLICATION_ERROR(-20001, 'Cliente Inexistente! ');
     WHEN too_many_rows THEN
       RAISE_APPLICATION_ERROR(-20002, 'Cliente Duplicado! ');
    WHEN others THEN
      RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida!'||SQLCODE||' '
                                     ||SQLERRM);
  END;


PROCEDURE exibe_cliente  (pid     IN OUT tclientes.id%TYPE,
                            pnome      OUT tclientes.nome%TYPE,
                            pendereco  OUT tclientes.endereco%TYPE,
                            pcidade    OUT tclientes.cidade%TYPE,
                            pestado    OUT tclientes.estado%TYPE)
is

BEGIN
     IF (existe_cliente(pid)) THEN
        select nome, endereco, cidade, estado 
        into pnome, pendereco, pcidade, pestado from tclientes
         WHERE id = pid;
     ELSE 
        RAISE no_data_found;
     END IF;
   EXCEPTION
     WHEN no_data_found THEN
       RAISE_APPLICATION_ERROR(-20001, 'Cliente Inexistente! ');
     WHEN too_many_rows THEN
       RAISE_APPLICATION_ERROR(-20002, 'Cliente Duplicado! ');
    WHEN others THEN
      RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida!'||SQLCODE||' '
                                     ||SQLERRM);
  END;    

end PCK_CLIENTE;



select * from tclientes;

---- Uso da pck_cliente
SET SERVEROUTPUT ON;
DECLARE
  vId       tclientes.id%TYPE := 200;
  vNome     tclientes.nome%TYPE;
  vEndereco tclientes.endereco%TYPE;
  vCidade   tclientes.cidade%TYPE;
  vEstado   tclientes.estado%TYPE;
BEGIN
  PCK_CLIENTE.INSERE_CLIENTE(vId ,'Breno' ,'frei' ,'Porto Alegre','RS');
  DBMS_OUTPUT.PUT('<< Cliente Inserido>>');
  
  PCK_CLIENTE.EXIBE_CLIENTE(vId, vNome, vEndereco, vCidade, vEstado);
  DBMS_OUTPUT.PUT('<< Informações do cliente >>');
  DBMS_OUTPUT.PUT('Nome: ' || vNome);
  DBMS_OUTPUT.PUT('Endereço:' || vEndereco);
  DBMS_OUTPUT.PUT('Cidade:' || vCidade);
  DBMS_OUTPUT.PUT('Estado:' || vEstado);
  
--  PCK_CLIENTE.REMOVE_CLIENTE(vId);
  --DBMS_OUTPUT.PUT('Removido cliente >> ' || vNome);
END;
/


DESC tclientes;

