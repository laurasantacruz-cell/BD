# Capivara Game – Banco de Dados do Jogo de Dominó

## Integrantes
- Ivan Francisco Santos – RGA: 202419060250
- Laura Santa Cruz – RGA: 202419060293   

## Link para o Google Drive
(Conteúdo completo do trabalho, conforme exigido pelo professor)

🔗 <INSERIR_LINK_DO_DRIVE_AQUI>

---

## Descrição do Projeto
Este projeto implementa o banco de dados do Capivara Game, cujo primeiro jogo é o Dominó.  
O banco foi desenvolvido em PostgreSQL e contém todas as regras de negócio do jogo, incluindo jogadas válidas, compra de peças, trancamento, batida, cálculo de pontos e ranking de jogadores.

Toda a lógica principal do jogo foi implementada diretamente no banco por meio de **tabelas, funções, procedures, triggers e views**.

---

## Arquivos Entregues (na pasta /sql)
- `tables.sql` – criação das tabelas  
- `insert.sql` – povoamento inicial  
- `functions.sql` – funções de validação, jogadas possíveis e trancamento  
- `procedure.sql` – procedimento de compra de peça  
- `triggers.sql` – gatilhos (batida, trancamento, inserir_mesa)  
- `views.sql` – ranking e listagem de partidas  

---

## Como Executar
1. Criar o banco:
