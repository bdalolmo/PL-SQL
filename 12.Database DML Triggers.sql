/*
Tempos de Disparo da Trigger

BEFORE
Crie uma DML Trigger BEFORE em n�vel de comando para, por exemplo, prevenir (validar) a execu��o da opera��o (
INSERT, UPDATE e/ou DELETE) em certas condi��es que s�o complexas demais para serem testadas atrav�s de constraints.
Crie uma Database DML Trigger em n�vel de comando e permita a inser��o na tabela TCONTRATOS somente em certos hor�rios.
*/

CREATE OR REPLACE TRIGGER bi_valida_horario_trg
BEFORE INSERT
ON tcontratos
BEGIN
  IF  (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR
       TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) NOT BETWEEN 8 AND 18) THEN
       RAISE_APPLICATION_ERROR( -20001,'O cadastramento de contratos � permitido apenas dentro do hor�rio comercial');
  END IF;
END;

/*AFTER
Crie uma DML Trigger AFTER em n�vel de comando para, por exemplo, auditar a opera��o que disparou a trigger ou executar 
um c�lculo depois da opera��o completada, derivando valores.
Crie uma Database DML Trigger em n�vel de comando que crie um LOG de informa��o numa tabela a partir da atualiza��o do total 
dos contratos da tabela TCONTRATOS.
*/

/*SQL> DESC log
 Nome                                      Nulo?    Tipo
 ----------------------------------------- -------- -------------
 USUARIO                                            VARCHAR2(30)
 HORARIO                                            DATE
*/

create table log(
USUARIO     VARCHAR2(30),
HORARIO     DATE)

CREATE OR REPLACE TRIGGER au_gera_log_alteracoes_trg
AFTER UPDATE OF total
ON tcontratos
DECLARE  
BEGIN
  INSERT INTO log( usuario, horario )
  VALUES ( USER, SYSDATE );
END;

select * from log;



--Criando uma Trigger Combinando V�rios Eventos

CREATE OR REPLACE TRIGGER biud_valida_horario_trg
BEFORE INSERT OR UPDATE OR DELETE
ON tcontratos
BEGIN
IF  (TO_CHAR(SYSDATE,'DAY') IN ('SABADO', 'DOMINGO') OR
     TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) NOT BETWEEN 8 AND 18) THEN
     IF( INSERTING )THEN
         RAISE_APPLICATION_ERROR(-20001, 'O cadastramento de contratos � permitido apenas dentro do hor�rio comercial.');
     ELSIF( DELETING )THEN
         RAISE_APPLICATION_ERROR(-20002, 'A remo��o de contratos � permitida apenas dentro do hor�rio comercial.');
     ELSIF( UPDATING('TOTAL') )THEN
         RAISE_APPLICATION_ERROR(-20003, 'Altera��es de totais s�o permitidas apenas dentro do hor�rio comercial.');
     ELSE
         RAISE_APPLICATION_ERROR(-20004, 'Altera��es de cadastros de contratos s�o permitidas apenas dentro do hor�rio comercial.');
     END IF;
END IF;
END;


ALTER TABLE log ADD informacao VARCHAR2(80);

--Criando Triggers em N�vel de Linha
CREATE OR REPLACE TRIGGER aidu_audita_tcontratos
AFTER INSERT OR DELETE OR UPDATE
ON tcontratos
FOR EACH ROW
BEGIN
  IF( DELETING )THEN
      INSERT INTO log( usuario, horario, informacao )
      VALUES ( USER, SYSDATE, 'Linhas deletadas.' );
  ELSIF( INSERTING )THEN
      INSERT INTO log( usuario, horario, informacao )
      VALUES ( USER, SYSDATE, 'Linhas inseridas.' );
  ELSIF( UPDATING('TOTAL') )THEN
      INSERT INTO log( usuario, horario, informacao )
      VALUES ( USER, SYSDATE, 'Atualiza��o do TOTAL do contrato.' );
  ELSE
      INSERT INTO log( usuario, horario, informacao )
      VALUES ( USER, SYSDATE, 'Atualiza��o das informa��es do contrato.' );
  END IF;
END;


desc log;

create table tcursos_log(
ID             NUMBER(11),                             
DT_LOG         DATE,
USUARIO        VARCHAR2(30),
EVENTO         CHAR(1),                                
TCURSOS_ID     NUMBER(11),                             
PRECO_ANTERIOR NUMBER(13,2),
PRECO_NOVO     NUMBER(13,2)
);


--Acessando valores OLD e NEW em n�vel de linha
--Exemplo: Trigger para os eventos insert, delete e update da coluna pre�o da tabela TCURSOS:


create or replace trigger A_IUD_TCURSOS_L_TRG
  after insert or update of preco or delete 
  on tcursos  
  for each row
DECLARE
	v_evento     tcursos_log.evento%TYPE;
	v_tcursos_id tcursos.id%TYPE;
BEGIN
	CASE
		WHEN inserting THEN
			v_evento     := 'I';
			v_tcursos_id := :new.id;
		WHEN updating THEN
			v_evento     := 'U';
			v_tcursos_id := :new.id;
		ELSE
			v_evento     := 'D';
			v_tcursos_id := :old.id;
	END CASE;
	INSERT INTO tcursos_log
		(id, dt_log, usuario, evento, tcursos_id, preco_anterior, preco_novo)
	VALUES
		(tcursos_log_seq.nextval,  --CRIAR SEQUENCIA
		 SYSDATE,
		 USER,
		 v_evento,
		 v_tcursos_id,
		 :old.preco,
		 :new.preco);
END a_iud_tcursos_l_trg;


SELECT
    *
FROM tcursos;

ROLLBACK;

create sequence tcursos_log_seq
minvalue 1
maxvalue 9999999
start with 1
INCREMENT by 1
nocache
cycle;



--Execu��o Condicional: - Cl�usula WHEN
CREATE OR REPLACE TRIGGER b_iu_calcula_comissao_trg
BEFORE INSERT OR UPDATE OF total
ON tcontratos
FOR EACH ROW
WHEN  (new.total > 5000)
BEGIN
  IF  (:new.total <= 10000)THEN
       :new.desconto := :new.total * .1;
  ELSE
       :new.desconto := :new.total * .2;
  END IF;
END;



select * from tcontratos where id =1004;

--Cl�usula Referencing
CREATE OR REPLACE TRIGGER b_iu_calcula_comissao_trg
BEFORE INSERT OR UPDATE OF total
ON tcontratos
REFERENCING OLD AS antigo 
            NEW AS novo
FOR EACH ROW
WHEN  (novo.total > 5000)
BEGIN
  IF  (:novo.total <= 10000) THEN
       :novo.desconto := :novo.total * .1;
  ELSE
       :novo.desconto := :novo.total * .2;
  END IF;
END;

select * from tcontratos where id =1004;

ROLLBACK;


update tcontratos
set desconto=+100
where id=1004;

/*Criando Triggers INSTEAD OF
Definimos a view VCONTRATOS_PARES para exemplificar as triggers INSTEAD OF:
*/

CREATE OR REPLACE VIEW vcontratos_pares
AS SELECT id, dt_compra COMPRA, tclientes_id CLIENTE, desconto, total
FROM   tcontratos
WHERE  MOD( id,2 ) = 0;


/*Podemos criar um trigger para verificar quais usu�rios est�o utilizando comandos DMLs pela view VCONTRATOS_PARES.
Cada comando INSERT, DELETE ou UPDATE na view VCONTRATOS_PARES vai disparar a trigger IIDU_VCONTRATOS_PARES_TRG,
na qual vai inserir informa��es na tabela LOG.
*/

CREATE OR REPLACE TRIGGER iidu_vcontratos_pares_trg
INSTEAD OF INSERT OR DELETE OR UPDATE
ON vcontratos_pares
DECLARE
BEGIN
  INSERT INTO log( usuario, horario, informacao )
  VALUES ( USER, SYSDATE, 'Utilizando comandos DML a partir da view VCONTRATOS_PARES.' );
END;
/

SELECT  * FROM vcontratos_pares;

SELECT  * FROM log;


UPDATE vcontratos_pares set desconto = total * .1
where id =1008;

DELETE FROM vcontratos_pares
  WHERE  cliente = 150;
  
ROLLBACK