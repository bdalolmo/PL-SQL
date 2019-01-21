--Regras para Uso de Triggers – Mutating Tables

CREATE OR REPLACE TRIGGER au_atualiza_pre_requisitos_trg
AFTER UPDATE OF id
ON tcursos
FOR EACH ROW
BEGIN
  UPDATE tcursos
  SET    pre_requisito = :new.id
  WHERE  pre_requisito = :old.id;
END;


--Ao se disparar um comando UPDATE como:

UPDATE tcursos
    SET id = 1000
    WHERE id = 1;
    
    
--Regra 2 de Mutating Table
CREATE OR REPLACE TRIGGER biu_verifica_total_trg
BEFORE INSERT OR UPDATE OF total
ON tcontratos
FOR EACH ROW
DECLARE
  vMin_total   tcontratos.total%TYPE;
  vMax_total   tcontratos.total%TYPE;
BEGIN
  SELECT MIN(total), MAX(total)
  INTO   vMin_total, vMax_total 
  FROM   tcontratos;

  IF( :new.total < vMin_total OR   -- Novo valor deve estar entre o valor
      :new.total > vMax_total )THEN  -- Mínimo e Máximo
    RAISE_APPLICATION_ERROR(-20505, 'Valor Total do contrato inválido');
  END IF;
END;


--Ao ser disparada através de um comando UPDATE como:

 UPDATE tcontratos
    SET    total = 3500
    WHERE  id = 1000;
    
    select * from tcontratos;
    
insert into tcontratos(id,tclientes_id,total)
    values(1021,180,200); --trigger invalida

desc tcontratos;


--Resolvendo o problema de Mutating Tables
CREATE OR REPLACE PACKAGE TcontratosDados AS
  TYPE valor_type IS TABLE OF NUMBER(10,2)
    INDEX BY BINARY_INTEGER;
  
  vValor  valor_type;

END TcontratosDados;

--2. Criação da trigger BEFORE em nível de comando (Ler os Dados):
CREATE OR REPLACE TRIGGER biu_verifica_total_trg_c
BEFORE INSERT OR UPDATE OF total
ON tcontratos
BEGIN
  SELECT MIN(total), MAX(total)
  INTO   TcontratosDados.vValor(1), TcontratosDados.vValor(2) 
  FROM   tcontratos;
END;

--Criação da trigger BEFORE em nível de linha (Executar a verificação):
CREATE OR REPLACE TRIGGER biu_verifica_total_trg_l
BEFORE INSERT OR UPDATE OF total
ON tcontratos
FOR EACH ROW
DECLARE
BEGIN
   IF( :new.total < TcontratosDados.vValor(1) OR
      :new.total > TcontratosDados.vValor(2) ) THEN
    RAISE_APPLICATION_ERROR(-20001,'Valor Total do contrato inválido');
  END IF;
END;


UPDATE tcontratos  ---erro
SET    total = 3500
WHERE  id = 1000;

/*
a tabela HR.TCONTRATOS é mutante; talvez o gatilho/função não possa localizá-la
ORA-06512: em "HR.BIU_VERIFICA_TOTAL_TRG", line 5
ORA-04088: erro durante a execução do gatilho 'HR.BIU_VERIFICA_TOTAL_TRG'
*/
    
    
SELECT
    *
FROM tcontratos WHERE id = 1000;
    
    select min(min1.total),max(max1.total) 
    from tcontratos min1 join tcontratos max1
    on min1.id = max1.id;


/* Habilitando e Desabilitando Database DML Triggers
Desabilite uma Trigger com o comando ALTER TRIGGER.*/

ALTER TRIGGER biu_verifica_total_trg_c DISABLE;

ALTER TRIGGER biu_verifica_total_trg_l DISABLE;

ALTER TRIGGER biu_verifica_total_trg DISABLE;

--Habilite uma Trigger com o comando ALTER TRIGGER.

ALTER TRIGGER biu_verifica_total_trg_c enable;

ALTER TRIGGER biu_verifica_total_trg_l enable;

ALTER TRIGGER biu_verifica_total_trg enable;


ROLLBACK;

--Desabilite todas as triggers para uma tabela específica com o comando ALTER TABLE.

ALTER TABLE biu_verifica_total_trg_c DISABLE ALL TRIGGERS;

ALTER TABLE biu_verifica_total_trg_l DISABLE ALL TRIGGERS;

ALTER TABLE biu_verifica_total_trg DISABLE ALL TRIGGERS;

--Habilite todas as triggers para uma tabela específica com o comando ALTER TABLE.


ALTER TABLE biu_verifica_total_trg_c ENABLE ALL TRIGGERS;

ALTER TABLE biu_verifica_total_trg_l ENABLE ALL TRIGGERS;

ALTER TABLE biu_verifica_total_trg ENABLE ALL TRIGGERS;

--ALTER TABLE nome_tabela ENABLE ALL TRIGGERS;


--Consultando o Código Fonte de Database Triggers
DESC user_triggers

--exemplo
SELECT trigger_body
FROM   user_triggers
WHERE  trigger_name = 'IIDU_TCONTRATOS_PARES_TRG';


/*TRIGGER_BODY
-----------------------------------------------------------------*/
DECLARE
BEGIN
  INSERT INTO log( usuario, horario, informacao )
  VALUES ( USER, SYSDATE, 'Utilizando comandos DML a partir da
           view TCONTRATOS_PARES.' );
END;



SELECT
    *
FROM log;

