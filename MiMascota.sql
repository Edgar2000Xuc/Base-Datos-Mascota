-- Creación de tabla Personas
CREATE TABLE Personas (
    nit INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

--Creación de tabla Mascotas
CREATE TABLE Mascotas (
    id_mascota INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento DATE,
    fecha_registro DATE,
    id_persona_responsable INT,
    FOREIGN KEY (id_persona_responsable) REFERENCES Personas(nit)
);

-- Creación de tabla Citas
CREATE TABLE Citas (
    id_cita INT PRIMARY KEY,
    fecha_hora DATETIME,
    id_mascota INT,
    id_persona_responsable INT,
    descripcion TEXT,
    correlativo_cita INT,
    presentacion INT,
    fecha_siguiente_cita DATE,
    FOREIGN KEY (id_mascota) REFERENCES Mascotas(id_mascota),
    FOREIGN KEY (id_persona_responsable) REFERENCES Personas(nit)
);

-- Creación de tabla Tratamientos
CREATE TABLE Tratamientos (
    id_tratamiento INT PRIMARY KEY,
    id_cita INT,
    descripcion TEXT,
    costo DECIMAL(10, 2),
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);


INSERT INTO Personas (nit, nombre, direccion, telefono) VALUES
(1, 'Juan Pérez', 'Calle 123', '555-1234'),
(2, 'María López', 'Avenida 456', '555-5678');

INSERT INTO Mascotas (id_mascota, nombre, fecha_nacimiento, fecha_registro, id_persona_responsable) VALUES
(1, 'Firulais', '2018-05-10', '2022-01-15', 1),
(2, 'Pelusa', '2019-08-20', '2022-02-03', 1);


INSERT INTO Citas (id_cita, fecha_hora, id_mascota, id_persona_responsable, descripcion, correlativo_cita, presentacion, fecha_siguiente_cita) VALUES
(1, '2023-09-20 10:00:00', 1, 1, 'Vacunación', 1, 1, '2023-10-20'),
(2, '2023-09-22 15:30:00', 2, 1, 'Control de salud', 2, 1, '2023-10-22');


INSERT INTO Tratamientos (id_tratamiento, id_cita, descripcion, costo) VALUES
(1, 1, 'Vacuna antirrábica', 50.00),
(2, 2, 'Desparasitación', 30.00);


SELECT * FROM Personas;


SELECT Mascotas.nombre AS NombreMascota, Personas.nombre AS NombrePersona
FROM Mascotas
INNER JOIN Personas ON Mascotas.id_persona_responsable = Personas.nit
ORDER BY NombreMascota;

SELECT Mascotas.nombre AS NombreMascota, Personas.nombre AS NombrePersona, Mascotas.fecha_registro
FROM Mascotas
INNER JOIN Personas ON Mascotas.id_persona_responsable = Personas.nit
ORDER BY Mascotas.fecha_registro;

SELECT Citas.*
FROM Citas
WHERE Citas.id_mascota = 'ID_DE_LA_MASCOTA';

SELECT *
FROM Citas
WHERE EXTRACT(MONTH FROM fecha_hora) = 'MES_ESPECIFICO';

SELECT *
FROM Citas
WHERE fecha_hora >= 'FECHA_INICIO' AND fecha_hora < 'FECHA_FIN'
ORDER BY fecha_hora;

SELECT id_mascota, COUNT(*) AS total_citas
FROM Citas
GROUP BY id_mascota
ORDER BY total_citas DESC


SELECT Personas.nombre AS NombrePersona, COUNT(Mascotas.id_mascota) AS CantidadMascotas
FROM Personas
LEFT JOIN Mascotas ON Personas.nit = Mascotas.id_persona_responsable
GROUP BY Personas.nit, Personas.nombre;

SELECT Tratamientos.descripcion, Tratamientos.costo
FROM Tratamientos
INNER JOIN Citas ON Tratamientos.id_cita = Citas.id_cita
WHERE Citas.id_mascota = 'ID_DE_LA_MASCOTA';

SELECT Mascotas.nombre AS NombreMascota, SUM(Tratamientos.costo) AS CostoTotalTratamientos
FROM Tratamientos
INNER JOIN Citas ON Tratamientos.id_cita = Citas.id_cita
INNER JOIN Mascotas ON Citas.id_mascota = Mascotas.id_mascota
WHERE Mascotas.id_persona_responsable = 'NIT_DE_LA_PERSONA'
GROUP BY Mascotas.id_mascota, Mascotas.nombre;
