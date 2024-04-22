--Bruno Ramos da Costa(RM551942)
-- Lucas Carabolad Bob (RM550519)

-- Foi inserido "_alt" no final dos nomes das tabelas pois já tínhamos tabelas criadas com o mesmo nome e para não haver interferência com outro projeto fizemos isso.


--Drop de tabelas
DROP TABLE Produto_alt CASCADE CONSTRAINTS;
DROP TABLE Produto1_alt CASCADE CONSTRAINTS;
DROP TABLE Produto2_alt CASCADE CONSTRAINTS;
DROP TABLE Cate_prod_alt CASCADE CONSTRAINTS;
DROP TABLE Boletim_alt CASCADE CONSTRAINTS;

-- Criar tabelas
CREATE TABLE Produto_alt (
    cd_prod INT PRIMARY KEY,
    nm_prod VARCHAR(50),
    preco NUMERIC(10, 2)
);

CREATE TABLE Produto1_alt (
    cd_prod INT PRIMARY KEY,
    nm_prod VARCHAR(50),
    preco NUMERIC(10, 2)
);

CREATE TABLE Produto2_alt (
    cd_prod INT PRIMARY KEY,
    nm_prod VARCHAR(50),
    preco NUMERIC(10, 2)
);

CREATE TABLE Cate_prod_alt (
    Id_prod INT PRIMARY KEY,
    nm_prod VARCHAR(50),
    preco NUMERIC(10,2),
    categoria CHAR(1),
    novo_preco NUMERIC(10,2)
);

CREATE TABLE Boletim_alt (
    Nome_alu VARCHAR2(100),
    Nome_disciplina VARCHAR2(100),
    Nota1 NUMBER(5,2),
    Nota2 NUMBER(5,2),
    Nota3 NUMBER(5,2),
    Faltas NUMBER,
    C_hora NUMBER,
    Media NUMBER(5,2),
    Situacao VARCHAR2(50)
);

-- Inserir dados nas tabelas
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (1, 'Água', 1.75);
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (2, 'Peixe', 75.00);
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (3, 'Feijão', 30.00);
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (4, 'Vinho', 79.50);

-- Inserir dados na tabela Cate_prod_alt
INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (1, 'Água', 1.75, 'A');

INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (2, 'Chá mate', 3.80, 'A');

INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (3, 'Macarrão', 18.80, 'B');

INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (4, 'Molho Tomate', 7.65, 'B');

INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (5, 'Guardanapo', 1.05, 'C');

INSERT INTO Cate_prod_alt (Id_prod, nm_prod, preco, categoria)
VALUES (6, 'Papel Toalha', 4.30, 'C');

-- Inserir dados na tabela Boletim_alt
INSERT INTO Boletim_alt (Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora)
VALUES ('Bruno', 'DBA', 10, 10, 10, 0, 80);

INSERT INTO Boletim_alt (Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora)
VALUES ('Lucas', 'IA', 6, 7.5, 8.5, 80, 80);

INSERT INTO Boletim_alt (Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora)
VALUES ('Vinicius', 'IOT', 1, 1, 1, 1, 60);

INSERT INTO Boletim_alt (Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora)
VALUES ('Antonio', 'QA', 5, 5, 5, 6, 60);

INSERT INTO Boletim_alt (Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora)
VALUES ('Marcelo', 'JAVA', 1, 1, 1, 40, 60);

-- Exercício 1
DECLARE
    CURSOR C_PRODUTO IS
        SELECT cd_prod, nm_prod, preco FROM Produto_alt;
    V_PRODUTO C_PRODUTO%ROWTYPE;
BEGIN
    OPEN C_PRODUTO;
    LOOP
        FETCH C_PRODUTO INTO V_PRODUTO;
        EXIT WHEN C_PRODUTO%NOTFOUND;
        INSERT INTO Produto1_alt (cd_prod, nm_prod, preco)
        VALUES (V_PRODUTO.cd_prod, V_PRODUTO.nm_prod, V_PRODUTO.preco);
    END LOOP;
    CLOSE C_PRODUTO;
    
    COMMIT;
END;
/

-- Exercício 2
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (5, 'Macarrão', 18.80);
INSERT INTO Produto_alt (cd_prod, nm_prod, preco) VALUES (6, 'Óleo', 14.60);

INSERT INTO Produto1_alt (cd_prod, nm_prod, preco) VALUES (5, 'Azeite', 35.80);
INSERT INTO Produto1_alt (cd_prod, nm_prod, preco) VALUES (6, 'Carvão', 40.60);

-- Exercício 3
DECLARE
    CURSOR C_PRODUTO IS
        SELECT cd_prod, nm_prod, preco FROM Produto_alt;
        
    CURSOR C_PRODUTO1 IS
        SELECT cd_prod, nm_prod, preco FROM Produto1_alt;
BEGIN
    FOR V_PRODUTO IN C_PRODUTO LOOP
        INSERT INTO Produto2_alt (cd_prod, nm_prod, preco)
        SELECT V_PRODUTO.cd_prod, V_PRODUTO.nm_prod, V_PRODUTO.preco
        FROM dual
        WHERE NOT EXISTS (
            SELECT 1 FROM Produto2_alt WHERE cd_prod = V_PRODUTO.cd_prod
        );
    END LOOP;
    
    FOR V_PRODUTO1 IN C_PRODUTO1 LOOP
        INSERT INTO Produto2_alt (cd_prod, nm_prod, preco)
        SELECT V_PRODUTO1.cd_prod, V_PRODUTO1.nm_prod, V_PRODUTO1.preco
        FROM dual
        WHERE NOT EXISTS (
            SELECT 1 FROM Produto2_alt WHERE cd_prod = V_PRODUTO1.cd_prod
        );
    END LOOP;
    
    COMMIT;
END;
/

-- Exercício 4
DECLARE
  v_percentage_A NUMBER(5,2) := 5;
  v_percentage_B NUMBER(5,2) := 10;
  v_percentage_C NUMBER(5,2) := 15;
BEGIN
  FOR product IN (SELECT Id_prod, nm_prod, preco, categoria FROM Cate_prod_alt) LOOP
    DECLARE
      v_Id_prod Cate_prod_alt.Id_prod%TYPE := product.Id_prod;
      v_nm_prod Cate_prod_alt.nm_prod%TYPE := product.nm_prod;
      v_preco Cate_prod_alt.preco%TYPE := product.preco;
      v_categoria Cate_prod_alt.categoria%TYPE := product.categoria;
    BEGIN
      IF v_categoria = 'A' THEN
        v_preco := v_preco * (1 + v_percentage_A / 100);
      ELSIF v_categoria = 'B' THEN
        v_preco := v_preco * (1 + v_percentage_B / 100);
      ELSIF v_categoria = 'C' THEN
        v_preco := v_preco * (1 + v_percentage_C / 100);
      END IF;
   
      UPDATE Cate_prod_alt
      SET preco = v_preco,
          novo_preco = v_preco 
      WHERE Id_prod = v_Id_prod;
    END;
  END LOOP;
 
  COMMIT;
END;
/

-- Exercício 5
DECLARE
    CURSOR C_BOLETIM IS
        SELECT Nome_alu, Nome_disciplina, Nota1, Nota2, Nota3, Faltas, C_hora, Media, Situacao
        FROM Boletim_alt;
    
    V_MEDIA NUMBER(5,2);
BEGIN
    FOR V_BOLETIM IN C_BOLETIM LOOP
        V_MEDIA := (V_BOLETIM.Nota1 + V_BOLETIM.Nota2 + V_BOLETIM.Nota3 - LEAST(V_BOLETIM.Nota1, V_BOLETIM.Nota2, V_BOLETIM.Nota3)) / 2;

        UPDATE Boletim_alt
        SET Media = V_MEDIA
        WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;

        IF V_MEDIA >= 7.0 THEN
            IF V_BOLETIM.Faltas < 0.25 * V_BOLETIM.C_hora THEN
                UPDATE Boletim_alt
                SET Situacao = 'Aprovado'
                WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;
            ELSE
                UPDATE Boletim_alt
                SET Situacao = 'Reprovado por faltas'
                WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;
            END IF;
        ELSIF V_MEDIA >= 4.5 THEN
            IF V_BOLETIM.Faltas < 0.25 * V_BOLETIM.C_hora THEN
                UPDATE Boletim_alt
                SET Situacao = 'DP'
                WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;
            ELSE
                UPDATE Boletim_alt
                SET Situacao = 'Reprovado por nota e faltas'
                WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;
            END IF;
        ELSE
            UPDATE Boletim_alt
            SET Situacao = 'Reprovado por nota'
            WHERE Nome_alu = V_BOLETIM.Nome_alu AND Nome_disciplina = V_BOLETIM.Nome_disciplina;
        END IF;
    END LOOP;

    COMMIT;
END;
/

-- Exibir dados finais
SELECT * FROM Produto_alt;
SELECT * FROM Produto1_alt;
SELECT * FROM Produto2_alt;
SELECT * FROM Cate_prod_alt;
SELECT * FROM Boletim_alt;