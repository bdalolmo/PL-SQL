create or replace PROCEDURE atualiza_precos IS
begin
    update tcursos 
    set preco = preco*1.5;
end;

execute atualiza_precos;
    
execute atualiza;

create or replace procedure atualiza is
begin
    update tcontratos
    set total = desconto*1.5
    where id=1000;

end;

create or replace procedure atual is
begin
    update tcontratos set total = total *1.25
    where id = 1001;
end;

execute atual;

select * from tcontratos;

rollback;

--------------------------------

CREATE OR REPLACE PROCEDURE aumenta_preco
(pId IN tcursos.id%TYPE, 
 ppercentual IN NUMBER DEFAULT 10)
IS
BEGIN
  UPDATE tcursos
  SET    preco = preco * (1 + (ppercentual / 100))
  WHERE  id = pId;
END aumenta_preco;

execute aumenta_preco(50,10); execute aumenta_preco(50);

----------------------------------------------------------

select * from tcursos;

create or replace procedure aumenta_desconto
(pId in tcontratos.id%type,
pp in number DEFAULT 2)
is 
begin
    UPDATE tcontratos
    set desconto = (pp*desconto)
    WHERE id=pId;
end;

EXECUTE aumenta_desconto(1001);

select * from tcontratos;

rollback;
-----------------------------------------------------
create or replace procedure aumenta_preco
(pId  in tcursos.id%TYPE,
pp in number)
is
begin
    UPDATE tcursos set preco = (1+(pp/100) * PRECO)
    WHERE id=pId;
end;

execute aumenta_preco(3,2);


select * from tcursos;

rollback;

-------------------------------------------------------------------
select * from tcontratos;

CREATE or REPLACE PROCEDURE atua_desc
(pId in tcontratos.id%type,
pdesc in tcontratos.desconto%TYPE)
is
begin
    UPDATE tcontratos
    set desconto = desconto * (1+(pdesc/100))
    where id = pId;
end;

EXECUTE atua_desc(1000,10);

rollback;


--Parâmetros tipo OUT

CREATE OR REPLACE PROCEDURE consulta_cliente
(pid            IN  tclientes.id%TYPE,
 pnome          OUT tclientes.nome%TYPE,
 pdt_nascimento OUT tclientes.dt_nascimento%TYPE,
 pcidade        OUT tclientes.cidade%TYPE)
IS
BEGIN
   SELECT nome, dt_nascimento, cidade
   INTO   pnome, pdt_nascimento, pcidade -- Atribuindo valores.
   FROM   tclientes
   WHERE  id = pid;
   -- Comandos
   
EXCEPTION 
WHEN  no_data_found  THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cliente inexistente');
WHEN  others  THEN
      RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle' || SQLCODE || SQLERRM);
END consulta_cliente;

--EXEC consulta_cliente( 150, :nome, :dt_nascimento, :cidade );
--Chamada do procedimento declarado anteriormente.

DECLARE
   vNome            tclientes.nome%TYPE;
   vDt_nascimento   tclientes.dt_nascimento%TYPE;
   vCidade          tclientes.cidade%TYPE;
BEGIN
   consulta_cliente( 150,   -- Valor de entrada.
                     vNome,           -- Valor de saída.
                     vDt_nascimento,  -- Valor de saída.
                     vCidade );       -- Valor de saída.
   
   DBMS_OUTPUT.PUT_LINE(vNome);
END;


select * from tclientes;


create or replace procedure consul_nom
(pId in tclientes.id%type,
 pnome out tclientes.nome%type,
 pcidade out tclientes.cidade%type)
 is
 begin
    select nome, cidade
    into  pnome,pcidade
    from tclientes
    where id = pId;
 
 end;

declare
    vNome tclientes.nome%type;
    vCidade tclientes.nome%type;
begin
    consul_nom(100,vNome,vCidade);
    --DBMS_OUTPUT.put_line(vNome);
end;

desc tcontratos;

create or replace procedure atu
(pId in tcontratos.id%type,
 pp out tcontratos.desconto%type)
is
begin
UPDATE tcontratos
set desconto = desconto*(pp * 1.25)
where id = pId;
end;

declare
    vDesconto tcontratos.desconto%type;
begin
    atu(1000,vDesconto);
end;

rollback;

select * from tcontratos;

--Parâmetros tipo IN OUT
CREATE OR REPLACE PROCEDURE formata_cpf
 (pcpf IN OUT VARCHAR2)
IS
BEGIN
   pcpf := SUBSTR(pcpf, 1, 3) || '.' || SUBSTR(pcpf, 4, 3) || '.' ||
           SUBSTR(pcpf, 7, 3) || '-' || SUBSTR(pcpf, 10, 2);
END formata_cpf;
/

CREATE OR REPLACE PROCEDURE consulta_cliente
(pid IN  tclientes.id%TYPE,
 pNome OUT NOCOPY tclientes.nome%TYPE,
 pDt_nascimento OUT NOCOPY tclientes.dt_nascimento%TYPE,
 pCidade OUT NOCOPY tclientes.cidade%TYPE)
IS


