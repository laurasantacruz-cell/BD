DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    senha TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    data_cadastro TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Jogo (
    id_jogo SERIAL PRIMARY KEY,
    modo TEXT NOT NULL,
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP,
    estado TEXT,
    pontuacao_final INTEGER,
    id_usuario INTEGER NOT NULL REFERENCES Usuario(id_usuario)
);

CREATE TABLE Dupla (
    id_dupla SERIAL PRIMARY KEY,
    id_jogo INTEGER NOT NULL REFERENCES Jogo(id_jogo)
);

CREATE TABLE Jogador (
    id_jogador SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuario(id_usuario),
    id_jogo INTEGER NOT NULL REFERENCES Jogo(id_jogo),
    id_dupla INTEGER REFERENCES Dupla(id_dupla),
    posicao INTEGER NOT NULL
);

CREATE TABLE Partida (
    id_partida SERIAL PRIMARY KEY,
    id_jogo INTEGER NOT NULL REFERENCES Jogo(id_jogo),
    numero_partida INTEGER NOT NULL,
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP,
    vencedor INTEGER,
    modo_fim TEXT,
    pontos_vencidos INTEGER,
    pontos_perdidos INTEGER
);

CREATE TABLE Peca (
    id_peca SERIAL PRIMARY KEY,
    ponta_1 INTEGER NOT NULL,
    ponta_2 INTEGER NOT NULL,
    valor INTEGER NOT NULL
);

CREATE TABLE Pecas_distribuidas (
    id_partida INTEGER NOT NULL REFERENCES Partida(id_partida),
    id_jogador INTEGER NOT NULL REFERENCES Jogador(id_jogador),
    id_peca INTEGER NOT NULL REFERENCES Peca(id_peca),
    PRIMARY KEY (id_partida, id_jogador, id_peca)
);

CREATE TABLE Mao_do_jogador (
    id_partida INTEGER NOT NULL REFERENCES Partida(id_partida),
    id_jogador INTEGER NOT NULL REFERENCES Jogador(id_jogador),
    id_peca INTEGER NOT NULL REFERENCES Peca(id_peca),
    PRIMARY KEY (id_partida, id_jogador, id_peca)
);

CREATE TABLE Monte_comprar (
    id_partida INTEGER NOT NULL REFERENCES Partida(id_partida),
    id_peca INTEGER NOT NULL REFERENCES Peca(id_peca),
    PRIMARY KEY (id_partida, id_peca)
);

CREATE TABLE Jogada (
    id_jogada SERIAL PRIMARY KEY,
    id_jogador INTEGER NOT NULL REFERENCES Jogador(id_jogador),
    id_partida INTEGER NOT NULL REFERENCES Partida(id_partida),
    id_peca INTEGER REFERENCES Peca(id_peca),
    ordem_jogada INTEGER NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    lado TEXT,
    acao TEXT NOT NULL
);

CREATE TABLE Estado_da_mesa (
    id_estado SERIAL PRIMARY KEY,
    id_partida INTEGER NOT NULL REFERENCES Partida(id_partida),
    id_peca INTEGER NOT NULL REFERENCES Peca(id_peca),
    ordem INTEGER NOT NULL
);

INSERT INTO Usuario (nome, email, senha) VALUES
('Tupã', 'tupa@teste.com', '123'),
('Nhanderú', 'nhanderu@teste.com', '123'),
('Jaci', 'jaci@teste.com', '123'),
('Guaraci', 'guaraci@teste.com', '123');

INSERT INTO Peca (ponta_1, ponta_2, valor) VALUES
(0,0,0),(0,1,1),(0,2,2),(0,3,3),(0,4,4),(0,5,5),(0,6,6),
(1,1,2),(1,2,3),(1,3,4),(1,4,5),(1,5,6),(1,6,7),
(2,2,4),(2,3,5),(2,4,6),(2,5,7),(2,6,8),
(3,3,6),(3,4,7),(3,5,8),(3,6,9),
(4,4,8),(4,5,9),(4,6,10),
(5,5,10),(5,6,11),
(6,6,12);

INSERT INTO Jogo (modo, id_usuario) VALUES ('competitivo', 1);

INSERT INTO Dupla (id_jogo) VALUES (1),(1);

INSERT INTO Jogador (id_usuario, id_jogo, id_dupla, posicao) VALUES
(1,1,1,1),(2,1,2,2),(3,1,1,3),(4,1,2,4);

INSERT INTO Partida (id_jogo, numero_partida, data_inicio) VALUES (1,1,NOW());

DO $$
DECLARE
    id_partida INT := 1;
    id_jogadores INT[];
    mao1 INT[];
    mao2 INT[];
    mao3 INT[];
    mao4 INT[];
BEGIN
    id_jogadores := ARRAY[1,2,3,4];
    mao1 := ARRAY[1,2,3,4,5,6,7];
    mao2 := ARRAY[8,9,10,11,12,13,14];
    mao3 := ARRAY[15,16,17,18,19,20,21];
    mao4 := ARRAY[22,23,24,25,26,27,28];
    FOREACH peca IN ARRAY mao1 LOOP
        INSERT INTO Mao_do_jogador (id_partida, id_jogador, id_peca) VALUES (id_partida, id_jogadores[1], peca);
    END LOOP;
    FOREACH peca IN ARRAY mao2 LOOP
        INSERT INTO Mao_do_jogador (id_partida, id_jogador, id_peca) VALUES (id_partida, id_jogadores[2], peca);
    END LOOP;
    FOREACH peca IN ARRAY mao3 LOOP
        INSERT INTO Mao_do_jogador (id_partida, id_jogador, id_peca) VALUES (id_partida, id_jogadores[3], peca);
    END LOOP;
    FOREACH peca IN ARRAY mao4 LOOP
        INSERT INTO Mao_do_jogador (id_partida, id_jogador, id_peca) VALUES (id_partida, id_jogadores[4], peca);
    END LOOP;
END$$;