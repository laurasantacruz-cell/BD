# BD

# Capivara Game – Banco de Dados para o Jogo de Dominó
Trabalho Prático – Laboratório de Banco de Dados – UFMS – 2025

## 👥 Integrantes
- **Ivan Francisco Santos** – RGA: <inserir> – E-mail: ivan@ufms.br  
- **Laura Santa Cruz** – RGA: <inserir> – E-mail: laura.santa.cruz@ufms.br  

---

## 📁 Link para o Google Drive (Obrigatório)
Todos os artefatos do trabalho estão armazenados no Drive institucional, conforme exigido pelo professor.

🔗 **Link do projeto:** <inserir_link_do_drive>

Conteúdo dentro da pasta:
- `Trabalho_Laboratório_de_Banco_de_Dados.pdf` (relatório SBC)
- `/sql/tables.sql`
- `/sql/insert.sql`
- `/sql/functions.sql`
- `/sql/procedure.sql`
- `/sql/triggers.sql`
- `/sql/views.sql`
- `/prints` (capturas usadas no relatório)
- `video_apresentacao.mp4`

---

## 🧩 Descrição do Projeto
Este projeto implementa o banco de dados do **Capivara Game**, plataforma online cujo primeiro jogo é o **Dominó**.  
O foco do trabalho é **modelagem**, **projeto** e **implementação lógica** das regras do jogo diretamente no **PostgreSQL**.

O banco é responsável por:
- Registrar todas as partidas, jogadas, compras e passes
- Validar automaticamente jogadas e encaixes
- Detectar trancamento do jogo
- Calcular pontuações
- Gerar histórico completo das ações
- Manter ranking e vencedores

A aplicação externa só realiza chamadas simples — a **lógica principal está totalmente no banco**.

---

## 📘 Regras de Negócio Implementadas
As seguintes regras de negócio do Dominó foram implementadas diretamente no banco (conforme seção 2 do relatório):

- RN01 – Jogador com peça 6–6 inicia a partida  
- RN02 – Jogada válida apenas quando a peça encaixa nas extremidades  
- RN03 – Jogador sem jogada deve passar  
- RN04 – Monte vazio → passa a vez  
- RN05 – Vitória por batida  
- RN06 – Detecção de trancamento  
- RN07 – Valor da peça = soma das pontas  
- RN08 – Pontuação ao bater  
- RN09/RN10 – Pontuação em trancamento  
- RN11 – Jogo termina ao atingir 50 pontos  
- RN12 – Cálculo automático de pontos (trigger)  
- RN13 – Compra de peça por procedure  
- RN14 – Validação de jogada por função  
- RN15 – Verificar jogadas possíveis  
- RN16 – Detectar partida trancada  
- RN17 – Histórico completo de jogadas  
- RN18 – Ranking de usuários  
- RN19 – Listagem de partidas e vencedores  

---

## 🗃️ Estrutura do Banco de Dados
Arquivos presentes na pasta `/sql`:

| Arquivo | Conteúdo |
|--------|----------|
| **tables.sql** | Criação das tabelas, chaves primárias, FKs, e as 28 peças |
| **insert.sql** | Dados iniciais e povoamento |
| **functions.sql** | Funções: validar jogada, jogadas possíveis, detectar trancamento |
| **procedure.sql** | Procedures: compra de peça |
| **triggers.sql** | Triggers: batida, trancamento, inserir_mesa (registrar peça jogada) |
| **views.sql** | Views: ranking de jogadores, partidas e vencedores |

### Principais entidades modeladas
- Usuário  
- Jogo (conjunto de partidas)  
- Partida  
- Jogadores da partida  
- Duplas  
- Peças  
- Monte  
- Mão do jogador  
- Movimentações (jogar, comprar, passar)  
- Estado da mesa  
- Pontuação  

O diagrama ER está incluído no relatório.

---

## 🔧 Lógica Importante Implementada no Banco
### ✔ Gatilho **inserir_mesa**
Registra automaticamente cada peça jogada na mesa, calculando a ordem da jogada:

- Determina o próximo número de ordem (`prox`)
- Insere a peça em `Estado_da_mesa`
- Mantém histórico completo da sequência

### ✔ Função **detectar_jogo_trancado()**
Verifica se nenhum jogador possui jogadas possíveis.

### ✔ Procedure **comprar_peca()**
Seleciona a próxima peça do monte e entrega ao jogador.

### ✔ Trigger **detectar_batida**
Quando a mão do jogador fica vazia → atualiza automaticamente:
- vencedor da partida  
- modo de término  
- pontuação dos adversários  

### ✔ View **ranking**
Conta:
- Partidas vencidas  
- Jogos vencidos  
- Pontuação total  

---

## ▶️ Como Executar
1. Crie o banco:
   ```sh
   createdb capivara_game
