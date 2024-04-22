# Exercícios Cursores

```
Tabela: Produto
        cd_prod - nm_prod - preco
            1       Água    1.75
            2       Peixe   75.00
            3       Feijão  30.00
            4       Vinho   79.50
```

### 1) Criar um bloco pl com cursor para migrar os dados da tabela produto para produto1

### 2) Inserir os seguintes dados:

```
Tabela: Produto
            5 - Macarrão  18.80
            6 - Óleo      14.60
           
Tabela: Produto1
            5 - Azeite  35.80
            6 - Carvão  40.60
```
           
### 3)Criar um bloco pl com cursor para migrar os dados das tabelas produto e Porduto 1 para 
 produto2, migre os dados sem repetição.


```
Resultado:
Produto2
            1 - Água          1.75
            2 - Peixe         75.00
            3 - Feijão        30.00
            4 - Vinho        79.50
            5 - Macarrão  18.80
            6 - Óleo          14.60
            7 - Azeite        35.80
            8 - Carvão       40.60
```

### 3.A) Criar um bloco PL/SQL (usando cursor) para atualizar a tabela abaixo, conforme segue:
```
Tabela: Cate_prod
     Id_prod - Nome_prod - preco - categoria - novo_preco
               1   Água              1.75           A
               2   Chá mate        3.80          A
               3   Macarrão        18.80         B
               4  Molho Tomate   7.65         B
               5  Guardanapo       0.75        C
               6  Papel Toalha       4.30        C
```
 Produtos categoria A deverão ser reajustados em 5%
 Produtos categoria B deverão ser reajustados em 10%
 Produtos categoria C deverão ser reajustados em 15%
 Cadastrar os resultados na tabela

### 5)Criar um bloco de programação com cursores para calcular a média de um aluno e sua situação.
De acordo com as regras a seguir:
-   Informar 3 notas, descartar a menor nota, calcular a média e atualizar o campo média na tabela boletim.
- Para o campo situação, atualizar a tabela boletim:
    - se média maior ou igual a 7,0 e número de faltas menor que 25% da carga horária da disciplina, situação igual a Aprovado.
    - se média maior ou igual a 7,0 e número de faltas maior ou igual a 25% da carga horária da disciplina, situação igual a       Reprovado por faltas.
    - se média maior ou igual a 4,5, menor ou igual a 6,9 e número de faltas menor que 25% da carga horária da disciplina, situação igual a DP.
    - se média menor ou igual a 4,4 e número de faltas menor que 25% da carga horária da disciplina, situação igual a Reprovado por nota.
     -se média menor ou igual a 4,4 e número de faltas maior ou igual a 25% da carga horária da disciplina, situação igual a Reprovado por nota e faltas.
      
````
Tabela Boletim

 Nome_alu - Nome_disciplina - Nota1 - Nota2 - Nota3 - Faltas - C_hora - Media - Situacao

 Marcel         DBA                         10         10        10            0          80              
 Marcel         IA                               6          7.5       8.5        80          80              
 Marcel         IOT                             1          1          1             1          60              
 Marcel         QA                              5          5          5             6         60          
 Marcel         JAVA                            1         1          1            40         60
`````
