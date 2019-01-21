--podemos utilizar commit ou rollback em um trigger?
--res: NÃO

-- Crie uma trigger chamada VALIDA_PRECOS para tabela TCURSOS que verifique a alterações do PRECO  do curso para cada registro. 
-- As alterações podem ser efetuada desde que o fator hora do curso (PRECO/CARGA_HORARIA) seja maior que 14 e menor que 75,
--o que equivale ao curso mais barato e o mais caro respectivamente.

create or REPLACE TRIGGER VALIDA_PRECOS
BEFORE INSERT OR UPDATE OF PRECO, carga_horaria
ON tcursos
FOR EACH ROW
BEGIN
    IF( :new.preco > 332 OR :new.preco <2240)
      THEN RAISE_APPLICATION_ERROR(-20001,'As alterações podem ser efetuada');
  END IF;
    
END;

--resolucao
create or REPLACE TRIGGER VALIDA_PRECOS_NEW
BEFORE INSERT OR UPDATE OF PRECO, carga_horaria
ON tcursos
FOR EACH ROW
DECLARE
 vFator tcursos.preco%TYPE;
BEGIN
    IF :new.preco IS NOT NULL AND :new.carga_horaria IS NOT NULL THEN
        vfator := :new.preco/:new.carga_horaria;
    END IF;
    IF vfator not BETWEEN 14 and 75 THEN
      RAISE_APPLICATION_ERROR(-20001,'Fator curso inválido ');
    END IF;
EXCEPTION
    WHEN zero_divide then
     RAISE_APPLICATION_ERROR(-20002,'carga horária informada não pode ser zero');
END;



select * from log;
UPDATE tcursos SET PRECO = 0.2
WHERE ID= 1;


ROLLBACK;

DROP TRIGGER VALIDA_PRECOS;


select id, preco,carga_horaria, preco/carga_horaria,(3000/carga_horaria) FROM tcursos;
-------------------
update tcursos
set preco = 2000
where id=1;

rollback;

update tcursos -- vai ocorrer erro
set preco = 5000
where id=1;

update tcursos -- vai ocorrer erro
set cargar_horaria =0 
where id=1;


--Crie uma sequence chamada TCLIENTES_SEQ para gerar números para chave primária da tabela de clientes (TCLIENTES).

--Crie uma database DML trigger before insert a nível de linha para gerar o numero do cliente a partir da sequence TCLIENTES_SEQ.

create or replace trigger gera_num_cliente
before insert on tclientes
for EACH ROW
begin
    SELECT TCLIENTES_SEQ.nextval
    into :new.id
    from dual;
EXCEPTION
WHEN others then
    RAISE_APPLICATION_ERROR(-20001, 'Erro na leitura da tabela dual para obter nextval de TCLIENTES_SEQ ' ||
      SQLCODE || SQLERRM);
end;
   
INSERT into tclientes(nome)
VALUES('Jussara ');

desc tclientes;

select*from tclientes;