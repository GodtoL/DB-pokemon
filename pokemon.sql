CREATE TABLE pokemon(
	id_pokemon SERIAL PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	tipo1 VARCHAR(20) NOT NULL,
	tipo2 VARCHAR (20),
	habilidad VARCHAR(50) NOT NULL,
	ataque INTEGER CHECK (ataque >= 1 AND ataque < 100),
	defensa INTEGER CHECK (defensa >= 1 AND defensa < 100),
	velocidad INTEGER CHECK (velocidad >= 1 AND velocidad < 100),
	vida INTEGER CHECK (vida >= 1 AND vida < 200)
)

CREATE TABLE entrenador(
	id_entrenador SERIAL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	origen VARCHAR(50) NOT NULL
)

CREATE TABLE entrenadores_pokemones(
	id_entrenador INTEGER NOT NULL,
	id_pokemon INTEGER NOT NULL,
	PRIMARY KEY(id_entrenador, id_pokemon),
	FOREIGN KEY (id_entrenador) references Entrenador(id_entrenador) ON DELETE CASCADE,
	FOREIGN KEY (id_pokemon) references Pokemon(id_pokemon) ON DELETE CASCADE
)
CREATE TABLE batallas(
	id_batalla SERIAL PRIMARY KEY,
	id_entrenador1 INTEGER NOT NULL,
	id_entrenador2 INTEGER NOT NULL,
	id_pokemon1 INTEGER NOT NULL,
	id_pokemon2 INTEGER NOT NULL,
	fecha DATE,
	resultado VARCHAR(20) NOT NULL,
	FOREIGN KEY (id_entrenador1) references Entrenador(id_entrenador) ON DELETE CASCADE,
	FOREIGN KEY (id_entrenador2) references Entrenador(id_entrenador) ON DELETE CASCADE,
	FOREIGN KEY (id_pokemon1) references Pokemon(id_pokemon) ON DELETE CASCADE,
	FOREIGN KEY (id_pokemon2) references Pokemon(id_pokemon) ON DELETE CASCADE
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
