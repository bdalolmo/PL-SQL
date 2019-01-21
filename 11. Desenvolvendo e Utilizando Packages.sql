--11. Desenvolvendo e Utilizando Packages  


--Crie o Package Specification utilizando o comando CREATE PACKAGE.

CREATE OR REPLACE PACKAGE pck_cursos
IS
  gDesconto tcontratos.desconto%TYPE;

  PROCEDURE atualiza_preco_cursos;
  
  PROCEDURE aumenta_porcentagem_curso(pPorcentagem IN NUMBER DEFAULT 10);

  PROCEDURE aumenta_preco(pId IN tcursos.id%TYPE);

  FUNCTION consulta_preco(pId IN tcursos.id%TYPE) RETURN NUMBER;

END pck_cursos;


--Crie o Package Body utilizando o comando CREATE PACKAGE BODY.

CREATE OR REPLACE PACKAGE BODY pck_cursos
IS
    PROCEDURE atualiza_preco_cursos
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1;
    END;
    PROCEDURE aumenta_porcentagem_curso
    (pPorcentagem IN NUMBER DEFAULT 10)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * ((pPorcentagem / 100) + 1);
    END;
    PROCEDURE aumenta_preco
    (pId IN tcursos.id%TYPE)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1
      WHERE  id = pId;
    END;
    FUNCTION consulta_preco
    (pId IN tcursos.id%TYPE)
    RETURN NUMBER IS
      vPreco   tcursos.preco%TYPE := 0;
    BEGIN
      SELECT preco
      INTO   vPreco
      FROM   tcursos
      WHERE  id = pId;
      RETURN(vPreco);
   END;
END pck_cursos;


---chamadas

SELECT id, nome,  preco
FROM  tcursos
where preco = pck_cursos.consulta_preco(10);

execute pck_cursos.atualiza_preco_cursos;

select * from tcursos;

rollback;


----------Procedimento de Única Execução------------

CREATE OR REPLACE PACKAGE BODY pck_cursos
IS
    PROCEDURE atualiza_preco_cursos
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1;
    END;

    PROCEDURE aumenta_porcentagem_curso
     (pPorcentagem IN NUMBER DEFAULT 10)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * ((pPorcentagem / 100) + 1);
    END;

    PROCEDURE aumenta_preco
     (pId IN tcursos.id%TYPE)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1
      WHERE  id = pId;
    END;

    FUNCTION consulta_preco
      (pId IN tcursos.id%TYPE)
    RETURN NUMBER IS
      vPreco   tcursos.preco%TYPE := 0;
    BEGIN
      SELECT preco
      INTO   vPreco
      FROM   tcursos
      WHERE  id = pId;
      RETURN(vPreco);
   END;
BEGIN
   SELECT AVG(preco)*.25
   INTO   gDesconto
   FROM   tcursos;
END pck_cursos;


-------chamadas para packages

ROLLBACK;

select * from tcursos;



SELECT id, nome,  preco
FROM  tcursos
where preco = pck_cursos.consulta_preco(10);

SELECT pck_cursos.consulta_preco(10)
FROM  dual;

SELECT id, nome, pck_cursos.consulta_preco(10) preco
FROM  tcursos;


EXECUTE pck_cursos.atualiza_preco_cursos;

--------------Removendo Packages
DROP PACKAGE nome_package;

--Remova somente o Package Body com o comando DROP PACKAGE BODY

DROP PACKAGE BODY nome_package;


--Referenciando componentes da package a partir de construções da própria Package

CREATE OR REPLACE PACKAGE BODY pck_cursos
IS
    PROCEDURE atualiza_preco_cursos
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1;
    END;
    PROCEDURE aumenta_porcentagem_curso(pPorcentagem IN NUMBER DEFAULT 10)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * ((pPorcentagem / 100) + 1);
    END;
    PROCEDURE aumenta_preco(pId IN tcursos.id%TYPE)
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1
      WHERE  id = pId;
    END;
    FUNCTION consulta_preco(pId IN tcursos.id%TYPE) RETURN NUMBER
    IS
      vPreco   tcursos.preco%TYPE := 0;
    BEGIN
      SELECT preco
      INTO   vPreco
      FROM   tcursos
      WHERE  id = pId;
      IF(vPreco < 500)THEN       
        aumenta_preco( pId );    -- Invocando a PROCEDURE aumenta_preco
        COMMIT;
      END IF;
      SELECT preco
      INTO   vPreco
      FROM   tcursos
      WHERE  id = pId;
      RETURN(vPreco);
   END;
END pck_cursos;

EXECUTE pck_cursos.aumenta_preco( 50 )

ROLLBACK;


-------------------------Exemplo: Referenciando a variável gdesconto da package pck_cursos.


CREATE OR REPLACE PROCEDURE atualiza_contrato
 (pcontrato IN tcontratos.id%TYPE,
  pcliente IN tclientes.id%TYPE)
IS
  vestado   tclientes.estado%TYPE;
  vdesconto tcontratos.desconto%TYPE;
  vtotal    tcontratos.total%TYPE;

BEGIN
  SELECT tcl.estado
  INTO   vestado
  FROM   tclientes tcl
  WHERE  tcl.id = pCliente;

  IF  (vestado IN ('SP','RJ'))  THEN
       SELECT tcn.total * .3
       INTO   vdesconto
       FROM   tcontratos tcn
       WHERE  tcn.id = pContrato;
  ELSE
       vdesconto := pck_cursos.gdesconto;
  END IF;

  UPDATE tcontratos
  SET    desconto = vdesconto
  WHERE  id = pcontrato;

  COMMIT;
EXCEPTION
  WHEN no_data_found THEN
    RAISE_APPLICATION_ERROR(-20201, 'Número de Contrato inválido!');
  WHEN others THEN
    RAISE_APPLICATION_ERROR(-20201, 'Erro Oracle' || SQLCODE ||    SQLERRM);
END;

ROLLBACK;

--Re-compilando Packages 
--Compilando Package Specification e Package Body.

ALTER PACKAGE nome_package COMPILE;

--Compilando Package Specification somente.

ALTER PACKAGE nome_package COMPILE SPECIFICATION;

--Compilando Package Body somente.
ALTER PACKAGE nome_package COMPILE BODY;




-- testando
create or replace package pck_outra
is
    procedure atualiza;
    
end pck_outra;

CREATE OR REPLACE PACKAGE BODY pck_outra
IS
    PROCEDURE atualiza
    IS
    BEGIN
      UPDATE tcursos
      SET    preco = preco * 1.1;
    END;
end pck_outra;

execute pck_outra.atualiza;



