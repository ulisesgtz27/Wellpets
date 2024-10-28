CREATE DATABASE dbwellpets;
USE dbwellpets;
SHOW TABLES;
-- Crear la tabla Rol
CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol ENUM('Administrador', 'Propietario') NOT NULL
);

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    teléfono VARCHAR(15) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- Crear la tabla Mascota
CREATE TABLE Mascota (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    nombre VARCHAR(100) NOT NULL,
    sexo ENUM('Macho', 'Hembra') NOT NULL,
    raza ENUM('Pug', 'Chihuahua', 'Golden Retriever', 'Labrador Retriever', 'Beagle', 'Sin raza') NOT NULL,
    edad INT NOT NULL,
    peso DECIMAL(5, 2) NOT NULL,
    talla ENUM('Pequeña', 'Media', 'Grande') NOT NULL,
    sano BOOLEAN NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Crear la tabla Recordatorio
CREATE TABLE Recordatorio (
    id_recordatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT,
    tipo ENUM('Salud','Alimentación') NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    nota TEXT,
    FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota)
);

-- Crear la tabla Comentario
CREATE TABLE Comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    descripción TEXT NOT NULL,
    tipo ENUM('Entretenimiento', 'Salud', 'Alimentación', 'Hábitos', 'General') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Crear la tabla Plan de alimentación
CREATE TABLE Plan_Alimentacion (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT,
    comida VARCHAR(250) NOT NULL,
    suplemento VARCHAR(250),
    consideraciones VARCHAR(250),
    FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota)
);

-- Inserts para la tabla Rol
INSERT INTO Rol (nombre_rol) VALUES 
('Administrador'),
('Propietario');

-- Inserts para la tabla Usuario
INSERT INTO Usuario (nombre, teléfono, correo, password, id_rol) VALUES ('Juan Pérez', '1234567890', 'juanperez@mail.com', 'hashed_password1', 1);
INSERT INTO Usuario (nombre, teléfono, correo, password, id_rol) VALUES ('María González', '0987654321', 'mariagonzalez@mail.com', 'hashed_password2', 2);
INSERT INTO Usuario (nombre, teléfono, correo, password, id_rol) VALUES ('Carlos López', '1112223334', 'carloslopez@mail.com', 'hashed_password3', 1);
INSERT INTO Usuario (nombre, teléfono, correo, password, id_rol) VALUES ('Ana Torres', '2223334445', 'anatorres@mail.com', 'hashed_password4', 2);
INSERT INTO Usuario (nombre, teléfono, correo, password, id_rol) VALUES ('Pedro Jiménez', '3334445556', 'pedrojimenez@mail.com', 'hashed_password5', 2);

-- Inserts para la tabla Mascota

INSERT INTO Mascota (id_usuario, nombre, sexo, raza, edad, peso, talla, sano) VALUES (1, 'Firulais', 'Macho', 'Labrador Retriever', 3, 25.50, 'Grande', TRUE);
INSERT INTO Mascota (id_usuario, nombre, sexo, raza, edad, peso, talla, sano) VALUES (2, 'Luna', 'Hembra', 'Chihuahua', 2, 3.20, 'Pequeña', TRUE);
INSERT INTO Mascota (id_usuario, nombre, sexo, raza, edad, peso, talla, sano) VALUES (3, 'Rocky', 'Macho', 'Beagle', 4, 10.75, 'Media', FALSE);
INSERT INTO Mascota (id_usuario, nombre, sexo, raza, edad, peso, talla, sano) VALUES (4, 'Bella', 'Hembra', 'Golden Retriever', 1, 12.00, 'Grande', TRUE);
INSERT INTO Mascota (id_usuario, nombre, sexo, raza, edad, peso, talla, sano) VALUES (5, 'Max', 'Macho', 'Pug', 5, 8.50, 'Pequeña', FALSE);

-- Inserts para la tabla Recordatorio

INSERT INTO Recordatorio (id_mascota, tipo, fecha, hora, nota) VALUES (1, 'Salud', '2024-01-15', '10:00:00', 'Vacunación anual');
INSERT INTO Recordatorio (id_mascota, tipo, fecha, hora, nota) VALUES (2, 'Alimentación', '2024-01-16', '08:00:00', 'Cambio de alimento');
INSERT INTO Recordatorio (id_mascota, tipo, fecha, hora, nota) VALUES (3, 'Salud', '2024-02-10', '09:30:00', 'Visita al veterinario');
INSERT INTO Recordatorio (id_mascota, tipo, fecha, hora, nota) VALUES (4, 'Alimentación', '2024-02-12', '07:45:00', 'Ajuste de ración diaria');
INSERT INTO Recordatorio (id_mascota, tipo, fecha, hora, nota) VALUES (5, 'Salud', '2024-03-05', '11:00:00', 'Control de peso');

-- Inserts para la tabla Comentario
INSERT INTO Comentario (id_usuario, descripción, tipo) VALUES (1, 'Mi perro adora los juguetes interactivos.', 'Entretenimiento');
INSERT INTO Comentario (id_usuario, descripción, tipo) VALUES (2, 'Es importante mantener las vacunas al día.', 'Salud');
INSERT INTO Comentario (id_usuario, descripción, tipo) VALUES (3, 'He notado que la comida húmeda es mejor para mi perro.', 'Alimentación');
INSERT INTO Comentario (id_usuario, descripción, tipo) VALUES (4, 'Es crucial establecer buenos hábitos de higiene.', 'Hábitos');
INSERT INTO Comentario (id_usuario, descripción, tipo) VALUES (5, 'Disfruto compartir paseos con mi mascota.', 'General');

--Plan de alimentación 

INSERT INTO Plan_Alimentacion (id_mascota, comida, suplemento, consideraciones) VALUES (1, 'Croquetas de pollo', 'Vitamina D', 'Evitar cambios bruscos de comida');
INSERT INTO Plan_Alimentacion (id_mascota, comida, suplemento, consideraciones) VALUES (2, 'Comida húmeda de cordero', NULL, 'No necesita suplementos');
INSERT INTO Plan_Alimentacion (id_mascota, comida, suplemento, consideraciones) VALUES (3, 'Croquetas sin granos', 'Omega 3', 'Controlar peso regularmente');
INSERT INTO Plan_Alimentacion (id_mascota, comida, suplemento, consideraciones) VALUES (4, 'Barf (Alimento crudo)', 'Calcio', 'Lavar los alimentos antes de servir');
INSERT INTO Plan_Alimentacion (id_mascota, comida, suplemento, consideraciones) VALUES (5, 'Comida seca', 'Glucosamina', 'Vigilar posibles alergias');


SHOW TABLES;

SELECT * FROM comentario;
SELECT * FROM Mascota;
SELECT * FROM propietario;
SELECT * FROM recordatorio;
SELECT * FROM rol;
SELECT * FROM plan_alimentacion;
DROP DATABASE dbwellpets;
