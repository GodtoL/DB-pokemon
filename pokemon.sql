CREATE TABLE pokemon(
  idpokemon SERIAL PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  tipo1 VARCHAR(20) NOT NULL,
  tipo2 VARCHAR(20),
  habilidad VARCHAR(20) NOT NULL,
  ataque integer CHECK(ataque >= 1 AND ataque <= 100),
  defensa integer CHECK (defensa >= 1 AND defensa <= 100),
  velocidad integer CHECK (velocidad >= 1 AND velocidad <= 100),
  vida integer CHECK (vida >= 1 AND vida <= 200),
)

CREATE TABLE entrenador
(
  identrenador SERIAL PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  origen VARCHAR(50) NOT NULL,
)

CREATE TABLE entrenadores_pokemones (
    id_entrenador INT NOT NULL,
    id_pokemon INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_pokemon),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores(id_entrenador),
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    UNIQUE (id_entrenador, id_pokemon)
);

CREATE TABLE batallas(
    idbatalla SERIAL PRIMARY KEY,
    identrenador1 integer NOT NULL,
    identrenador2 integer NOT NULL,
    idpokemon1 integer NOT NULL,
    idpokemon2 integer NOT NULL,
    fecha date,
    resultado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_entrenador1) REFERENCES entrenadores(id_entrenador),
    FOREIGN KEY (id_entrenador2) REFERENCES entrenadores(id_entrenador),
    FOREIGN KEY (id_pokemon1) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_pokemon2) REFERENCES pokemon(id_pokemon)
)

-- VISUALIZAR
SELECT * FROM entrenador;
SELECT * FROM pokemon;
SELECT * FROM batallas;
SELECT * FROM entrenador_pokemon;

-- AGREGAR
INSERT INTO entrenador(nombre, origen)
values('As', 'Pueblo Paleta');

-- ACTUALIZAR
UPDATE entrenador
SET nombre =  'Ash'
WHERE identrenador = 6;

-- INSERTAR
INSERT INTO batallas(identrenador1 , identrenador2, idpokemon1, idpokemon2, fecha, resultado)
values(1, 6, 10, 14, '2023-05-28', 'Gano entrenador 1');

INSERT INTO entrenador_pokemon (identrenador, idpokemon)
SELECT 6 AS identrenador, p.idpokemon
FROM pokemon p
WHERE NOT EXISTS (
  SELECT 6
  FROM entrenador_pokemon ep
  WHERE ep.idpokemon = p.idpokemon
);
SELECT 
    b.idbatalla,
    e1.nombre AS nombre_entrenador1,
    e2.nombre AS nombre_entrenador2,
    p1.nombre AS nombre_pokemon1,
    p2.nombre AS nombre_pokemon2,
    b.fecha,
    b.resultado
FROM 
    batallas b
JOIN 
    entrenador e1 ON b.identrenador1 = e1.identrenador
JOIN 
    entrenador e2 ON b.identrenador2 = e2.identrenador
JOIN 
    pokemon p1 ON b.idpokemon1 = p1.idpokemon
JOIN 
    pokemon p2 ON b.idpokemon2 = p2.idpokemon;

DELETE FROM entrenador
WHERE identrenador = 6;