-- Active: 1716011690015@@localhost@3306@empresa_transporte
INSERT INTO
    departamentos (Nombre_Departamento)
VALUES
    ('Amazonas'),
    ('Antioquia'),
    ('Arauca'),
    ('Atlántico'),
    ('Bolívar'),
    ('Boyacá'),
    ('Caldas'),
    ('Caquetá'),
    ('Casanare'),
    ('Cauca'),
    ('Cesar'),
    ('Chocó'),
    ('Córdoba'),
    ('Cundinamarca'),
    ('Guainía'),
    ('Guaviare'),
    ('Huila'),
    ('La Guajira'),
    ('Magdalena'),
    ('Meta'),
    ('Nariño'),
    ('Norte de Santander'),
    ('Putumayo'),
    ('Quindío'),
    ('Risaralda'),
    ('San Andrés y Providencia'),
    ('Santander'),
    ('Sucre'),
    ('Tolima'),
    ('Valle del Cauca'),
    ('Vaupés'),
    ('Vichada');

INSERT INTO
    ciudades (`Ciudad_Nombre`, `Departamento_ID`)
VALUES
    ('Leticia', 1),
    ('Medellin', 2),
    ('Arauca', 3),
    ('Barranquilla', 4),
    ('Cartagena', 5),
    ('Magangue', 5),
    ('Santa Cruz de Mompox', 5),
    ('Tunja', 6),
    ('Villa de Leyva', 6),
    ('Manizales', 7),
    ('Popayan', 10),
    ('Bosconia', 11),
    ('Valledupar', 11),
    ('Atrato', 12),
    ('Quibdo', 12),
    ('Monteria', 13),
    ('Bogota', 14),
    ('Chia', 14),
    ('Madrid', 14),
    ('Neiva', 17),
    ('El Banco', 19),
    ('Guamal', 19),
    ('Santa Marta', 19),
    ('Villavicencio', 20),
    ('Pasto', 21),
    ('Cucuta', 22),
    ('Mocoa', 23),
    ('Armenia', 24),
    ('Pereira', 25),
    ('Bucaramanga', 27),
    ('Cali', 30);

/* Insertando registros en la ciudad de origen
El query consiste en insertar los registros de la tabla ciudades en la tabla ciudad origen mediante un select */
INSERT INTO
    ciudad_origen (`Ciudad_Origen_ID`, `Ciudad_Origen_Nombre`)
SELECT
    `Ciudad_ID`,
    `Ciudad_Nombre`
FROM
    ciudades;

/* Mismo proceso que el documentado anteriormente, con la única diferencia en que se van a ingresar 
registros a la tabla ciudad destino */
INSERT INTO
    ciudad_destino (`Ciudad_Destino_ID`, `Ciudad_Destino_Nombre`)
SELECT
    `Ciudad_ID`,
    `Ciudad_Nombre`
FROM
    ciudades;

-- Se insertan las rutas
INSERT INTO
    rutas (`Ciudad_Origen_ID`, `Ciudad_Destino_ID`)
VALUES
    (6, 4),
    (7, 4),
    (4, 6),
    (4, 7);


INSERT INTO
    marcas (`Marca_Nombre`, `Imagen_Marca`)
VALUES
    ('Mercedes-Benz', 'https://c0.klipartz.com/pngpicture/160/763/gratis-png-logo-mercedes-benz.png'),
    ('Foton', 'https://logos-world.net/wp-content/uploads/2022/12/Foton-Motor-Logo.png'),
    ('Hyundai', 'https://e7.pngegg.com/pngimages/129/76/png-clipart-hyundai-logo-car-hyundai-motor-company-honda-logo-hyundai-i30-beijing-modern-icon-material-angle-emblem.png'),
    ('Scania', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/SCANIA_Logo_vector.svg/2560px-SCANIA_Logo_vector.svg.png'),
    ('Volvo Buses', 'https://hips.hearstapps.com/hmg-prod/images/volvo-nuevo-logo-2023-1632412589.jpg'),
    ('MAN', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Logo_MAN.png/320px-Logo_MAN.png'),
    ('Iveco', 'https://brandemia.org/contenido/subidas/2023/10/portada-iveco-2-1200x670.jpg'),
    ('Solaris', 'https://upload.wikimedia.org/wikipedia/commons/8/89/Solaris_logo.jpg'),
    ('Marcopolo', 'https://seeklogo.com/images/M/marcopolo-logo-1A5FFDFFA5-seeklogo.com.png'),
    ('Yutong', 'https://upload.wikimedia.org/wikipedia/commons/6/64/Yutong_Bus_and_Coach_Logo.jpg'),
    ('Higer', 'https://www.carlogos.org/car-logos/higer-logo-800x600.png'),
    ('Temsa', 'https://download.logo.wine/logo/TEMSA/TEMSA-Logo.wine.png');

INSERT INTO
    buses (
        `Capacidad_Pasajeros`,
        `Marca_ID`,
        `Municipio_Matricula_ID`,
        `Fecha_Matricula`
    )
VALUES
    (32, 6, 7, '2021-10-01'),
    (32, 6, 4, '2021-10-01'),
    (34, 3, 5, '2021-11-30'),
    (36, 12, 6, '2022-01-20'),
    (32, 11, 6, '2022-01-20'),
    (36, 1, 9, '2022-02-20'),
    (36, 6, 3, '2022-02-25'),
    (30, 2, 3, '2022-03-01'),
    (36, 12, 16, '2022-03-01'),
    (30, 1, 13, '2022-03-01'),
    (36, 7, 23, '2022-03-01'),
    (36, 9, 23, '2022-03-01');
    
INSERT INTO
    conductores (
        `Nombre_Conductor`,
        `Genero_Conductor`,
        `Fecha_Nacimiento_Conductor`,
        `Fecha_Contratacion`
    )
VALUES
    ('Juan Gomez', 'Masculino', '1985-10-10', '2022-03-05'),
    ('Emiliano Rodriguez', 'Masculino', '1990-11-30', '2022-03-10'),
    ('Juliana Fontas', 'Femenino', '1992-03-11', '2022-03-12'),
    ('Monica Estrada', 'Femenino', '1995-07-11', '2022-03-15'),
    ('Camila Angarita', 'Femenino', '1982-07-14', '2022-03-15');
/* 
    ('Luis Carrillo', 'Masculino', '1982-03-29', '2022-06-25'),
    ('Emilio Garcia', 'Masculino', '1990-05-05', '2023-06-14'),
    ('Javier Hidalgo', 'Masculino', '1980-10-10', '2023-06-16'),
    ('Javier Fernandez', 'Masculino', '1975-11-10', '2023-08-11'),
    ('Mario Suarez', 'Masculino', '1980-09-02', '2023-09-15'),
    ('Andrea Castañeda', 'Femenino', '1992-11-10', '2023-10-16'),
    ('Gonzalo Hernandez', 'Masculino', '1982-05-05', '2023-10-20'),
    ('Hernando Solano', 'Masculino', '1991-12-10', '2023-11-03'),
    ('Emilio Rodriguez', 'Masculino', '1993-11-10', '2023-11-10'),
    ('Juan Muñoz', 'Masculino', '1980-10-10', '2023-11-24'),
    ('Manuel Ordoñez', 'Masculino', '1990-10-19', '2023-12-20'),
    ('Juan Fernandez', 'Masculino', '1982-11-25', '2023-12-20'),
    ('William Fontanar', 'Masculino', '1995-12-11', '2024-01-14'),
    ('Robert Ardila', 'Masculino', '1980-04-02', '2024-02-01'),
    ('Juan Rodriguez', 'Masculino', '1992-05-03', '2024-03-07'),
    ('Lucas Garcia', 'Masculino', '1981-07-11', '2024-03-15'),
    ('Jonas Murillo', 'Masculino', '1980-01-05', '2024-03-30'),
    ('Luis Aguiar', 'Masculino', '1975-05-11', '2024-04-15'),
    ('Raul Ordoñez', 'Masculino', '1980-05-10', '2024-04-24'),
    ('Rodrigo Gonzales', 'Masculino', '1975-07-09', '2024-04-30'),
    ('Alexander Fontas', 'Masculino', '1970-02-02', '2024-04-30'),
    ('Mathias Cuentas', 'Masculino', '1968-07-14', '2024-05-01'),
    ('Alexander Soto', 'Masculino', '1980-09-15', '2024-05-02'); */

-- Insertando datos en la tabla de terminales
INSERT INTO
    terminales (`Nombre_Terminal`, `Ciudad_Ubicacion_ID`)
SELECT
    CONCAT('Terminal de transporte de ', c.`Ciudad_Nombre`) AS Nombre_Terminal,
    c.`Ciudad_ID`
FROM
    ciudades c
    INNER JOIN rutas r ON c.`Ciudad_ID` = r.`Ciudad_Origen_ID`
    INNER JOIN ciudad_destino cd ON r.`Ciudad_Destino_ID` = cd.`Ciudad_Destino_ID`
GROUP BY c.`Ciudad_Nombre`, c.`Ciudad_ID`
ORDER BY
    c.`Ciudad_ID`;

-- Insertando información en la tabla de taquilleros
INSERT INTO
    taquillero (
        `Nombre_Taquillero`,
        `Genero_Taquillero`,
        `Fecha_Nacimiento_Taquillero`,
        `Fecha_Contratacion`,
        `Terminal_ID`
    )
VALUES
    ('Ferdinand Ochoa', 'Masculino', '1980-11-10', '2022-02-27', 2),
    ('Katherine Muñoz', 'Femenino', '1990-12-11', '2022-02-27', 2),
    ('Sofia Gomez', 'Femenino', '1992-03-11', '2022-02-27', 1),
    ('Gonzalo Roa', 'Masculino', '1990-11-14', '2022-03-02', 1),
    ('Alex Ochoa', 'Masculino', '1980-08-19', '2022-03-02', 1),
    ('Jeronimo Duarte', 'Masculino', '1985-11-10', '2022-03-02', 3),
    ('Alejandro Consuegra', 'Masculino', '1990-08-16', '2022-03-02', 3);
/*
    ('Nicolas Buitrago', 'Masculino', '1992-11-09', '2022-05-03', 1),
    ('Maria Montero', 'Femenino', '1982-02-10', '2022-05-25', 1),
    ('Gonzalo Muñoz', 'Masculino', '1990-09-03', '2022-05-25', 1),
    ('Juliana Rondon', 'Femenino', '1990-10-01', '2022-10-04', 1),
    ('Orlando Rolon', 'Masculino', '1980-04-05', '2022-10-11', 6),
    ('Arnold Fuentes', 'Masculino', '1985-05-06', '2022-12-19', 6),
    ('Juan Soto', 'Masculino', '1992-05-01', '2023-05-20', 7),
    ('Gonzalo Consuegra', 'Masculino', '1990-08-16', '2023-05-20', 7),
    ('Ricardo Irazusta', 'Masculino', '1980-11-14', '2023-07-15', 9),
    ('Ana Blanco', 'Femenino', '1995-06-03', '2023-07-15', 9),
    ('Mayra Margallo', 'Femenino', '1993-10-02', '2023-08-15', 9),
    ('Elena Prieto', 'Femenino', '1992-12-03', '2023-08-15', 9),
    ('Roman Gallego', 'Masculino', '1995-05-30', '2023-09-14', 9),
    ('Angelina Herazo', 'Femenino', '1985-04-05', '2024-01-06', 10),
    ('Gloria Trujillo', 'Femenino', '1990-05-06', '2024-01-06', 10),
    ('Luz Salazar', 'Femenino', '1985-06-10', '2024-01-06', 11),
    ('Alexander Parra', 'Masculino', '1975-11-06', '2024-01-06', 11);
*/
/*
    ('Judith Sotelo', 'Femenino', '1980-06-06', '2023-06-15', 15),
    ('Claudia Rincon', 'Femenino', '1990-11-10', '2024-03-15', 15),
    ('Juan Vera', 'Masculino', '1993-11-10', '2023-12-20', 16),
    ('Martina Gonzales', 'Femenino', '1985-05-04', '2024-03-24', 16),
    ('Helga Centeno', 'Femenino', '1986-04-05', '2023-10-05', 17),
    ('Magda Mosquera', 'Femenino', '1982-09-06', '2023-06-24', 17),
    ('Martha Diettes', 'Femenino', '1991-06-01', '2022-05-14', 18),
    ('Juan Carcamo', 'Masculino', '1992-04-09', '2024-04-11', 18),
    ('Janneth Riascos', 'Femenino', '1990-08-12', '2023-10-11', 19),
    ('Sixta Montes', 'Femenino', '1991-11-20', '2023-05-10', 19),
    ('Audrey Londoño', 'Femenino', '1995-10-10', '2023-06-18', 20),
    ('Cristina Orjuela', 'Femenino', '1985-10-10', '2024-01-06', 20),
    ('Luis Villa', 'Masculino', '1983-05-19', '2024-01-20', 21),
    ('Alberto Caicedo', 'Masculino', '1982-11-11', '2022-06-10', 21),
    ('Aura Nuñez', 'Femenino', '1986-10-12', '2023-10-14', 22),
    ('Patricia Becerra', 'Femenino', '1990-03-09', '2023-10-18', 22),
    ('Lilian Duarte', 'Femenino', '1992-05-06', '2024-05-10', 23),
    ('Carolina Urdaneta', 'Femenino', '1993-11-11', '2023-04-11', 23),
    ('Esmeralda Ramirez', 'Femenino', '1995-06-10', '2023-05-20', 24),
    ('Juliana Tejeda', 'Femenino', '1993-06-20', '2024-05-10', 24),
    ('Lina Osorio', 'Femenino', '1990-06-08', '2023-11-09', 25),
    ('Carmen Moncada', 'Femenino', '1992-10-10', '2024-03-16', 26),
    ('Nuvia Torres', 'Femenino', '1980-11-11', '2024-05-01', 27),
    ('Hector Fuentes', 'Masculino', '1992-10-10', '2022-10-10', 28),
    ('Wilmer Becerra', 'Masculino', '1983-10-11', '2022-11-15', 28),
    ('Jhon Cortez', 'Masculino', '1990-11-06', '2022-05-16', 29),
    ('Juan Villao', 'Masculino', '1990-10-03', '2022-06-19', 29),
    ('Carolina Herrera', 'Femenino', '1998-06-12', '2022-06-15', 29),
    ('Marcela Jaramillo', 'Femenino', '1985-07-10', '2024-01-22', 30),
    ('Cecilia Alzate', 'Femenino', '1982-07-30', '2024-01-30', 30),
    ('Eugenia Andrade', 'Femenino', '1980-10-11', '2023-10-05', 31),
    ('Yolanda Arango', 'Femenino', '1992-08-03', '2022-04-11', 32),
    ('Luz Vejarano', 'Femenino', '1990-10-09', '2023-09-24', 33),
    ('Gerard Arcos', 'Masculino', '1991-07-10', '2023-06-11', 34),
    ('Mileth Arteaga', 'Femenino', '1982-04-29', '2022-05-11', 35),
    ('Enrique Beltran', 'Masculino', '1992-11-10', '2024-01-25', 36),
    ('Julian Velasco', 'Masculino', '1990-10-09', '2024-01-30', 36),
    ('Armand Bastidas', 'Masculino', '1990-11-11', '2024-01-30', 37),
    ('Bernardo Bonilla', 'Masculino', '1982-10-10', '2023-11-10', 38),
    ('Isabell Dominguez', 'Femenino', '1990-05-08', '2024-01-25', 39),
    ('Patricia Bermudez', 'Femenino', '1991-04-05', '2023-11-11', 40),
    ('William Burbano', 'Masculino', '1992-05-05', '2023-05-10', 41),
    ('Hernando Cadena', 'Masculino', '1993-05-07', '2023-10-04', 42),
    ('Lucia Cabrera', 'Femenino', '1992-06-10', '2022-05-11', 42),
    ('Antonio Caicedo', 'Masculino', '1980-06-10', '2023-05-20', 43),
    ('Silvio Teran', 'Masculino', '1990-12-10', '2023-06-10', 43),
    ('Pablo Camayo', 'Masculino', '1992-10-10', '2023-05-29', 44),
    ('Edith Castro', 'Femenino', '1985-05-03', '2023-05-29', 44),
    ('Santiago Ceron', 'Masculino', '1982-09-10', '2024-01-29', 45),
    ('Lucia Arciniega', 'Femenino', '1981-07-11', '2024-02-24', 46),
    ('Lucila Cifuentes', 'Femenino', '1980-10-03', '2024-03-30', 47),
    ('Paulo Lopez', 'Masculino', '1979-05-14', '2024-02-24', 48),
    ('Olga Urdaneta', 'Femenino', '1980-03-11', '2023-10-11', 49),
    ('Luis Bermudez', 'Masculino', '1981-03-11', '2023-10-30', 49),
    ('Humberto Erazo', 'Masculino', '1990-08-10', '2023-10-24', 50),
    ('Paolo Espinosa', 'Masculino', '1993-03-10', '2022-11-10', 51),
    ('Antonio Fernandez', 'Femenino', '1990-02-15', '2023-06-11', 52),
    ('Edward Londoño', 'Masculino', '1993-06-24', '2024-04-10', 53),
    ('Lorena Gaviria', 'Femenino', '1992-05-29', '2022-06-30', 54),
    ('Pedro Hidalgo', 'Masculino', '1990-10-25', '2023-06-20', 54),
    ('Ana Ordoñez', 'Femenino', '1995-06-30', '2023-10-30', 55),
    ('Jeremias Hurtado', 'Masculino', '1991-09-18', '2023-06-14', 56),
    ('Jeremias Lasso', 'Femenino', '1992-10-11', '2023-11-06', 57),
    ('Rosabalda Lara', 'Femenino', '1990-03-12', '2023-10-09', 58),
    ('Wilson Manrique', 'Masculino', '1995-11-10', '2023-10-14', 59),
    ('Aicardo Muñoz', 'Masculino', '1990-05-06', '2023-06-30', 60);
*/

-- Metodos de pago
INSERT INTO
    metodo_pago (`Metodo_Pago_Nombre`)
VALUES
    ('Efectivo'),
    ('Transferencia bancaria'),
    ('Tarjeta debito'),
    ('Tarjeta credito');

INSERT INTO
    viajeros (`Nombre`, `Genero`, `Fecha_Nacimiento_Viajero`)
VALUES
    ('Lucia Alban', 'Femenino', '1992-03-10'),
    ('Jose Moya', 'Masculino', '1995-10-03'),
    ('Andres Salazar', 'Masculino', '2000-11-12'),
    ('Sandra Suarez', 'Femenino', '1999-10-09'),
    ('Eugenia Escobar', 'Femenino', '1980-11-14'),
    ('Gilberto Ayala', 'Masculino', '2001-05-06'),
    ('Andres Bastidas', 'Masculino', '2000-09-17'),
    ('Luis Garcia', 'Masculino', '1992-06-09'),
    ('Sandra Bendeck', 'Femenino', '2000-12-10'),
    ('Fernanda Cifuentes', 'Femenino', '1999-11-14'),
    ('Luisa Ceron', 'Femenino', '2002-10-03'),
    ('Luz Celis', 'Femenino', '2003-12-15'),
    ('Carolina Guillen', 'Femenino', '1998-11-10'),
    ('Juliana Montreal', 'Femenino', '1999-05-09'),
    ('Carmen Monsalve', 'Femenino', '2001-08-11'),
    ('Yaneth Ceballos', 'Femenino', '2000-04-10'),
    ('Claudia Jacinto', 'Femenino', '1992-10-10'),
    ('Paulo Rosero', 'Masculino', '2000-06-01'),
    ('Olga Gomez', 'Femenino', '1997-03-11'),
    ('Martha Nuñez', 'Femenino', '1995-07-08'),
    ('Angelina Timana', 'Femenino', '1992-03-10'),
    ('Luciana Rondon', 'Femenino', '1995-04-10'),
    ('Rosalba Rodriguez', 'Femenino', '2000-03-14'),
    ('Francisco Enriquez', 'Masculino', '1989-11-10'),
    ('Cecilia Moncayo', 'Femenino', '1993-03-01'),
    ('Emilssen Beltran', 'Masculino', '2001-06-30'),
    ('Alfredo Pulido', 'Masculino', '2003-05-10'),
    ('Luis Amador', 'Masculino', '2003-11-10'),
    ('Audrey Hurtado', 'Femenino', '2010-06-30'),
    ('Francely Mosquera', 'Masculino', '2005-10-09'),
    ('Gloria Londoño', 'Femenino', '2002-11-12'),
    ('Alexander Rincon', 'Masculino', '2001-12-10'),
    ('Judith Rosales', 'Femenino', '2001-12-29'),
    ('Marcela Montreal', 'Femenino', '2000-03-10'),
    ('Teresa Hurtado', 'Femenino', '2000-10-30'),
    ('Madelyn Becerra', 'Femenino', '1998-11-30'),
    ('Cecilia Andrade', 'Femenino', '2000-10-03'),
    ('Lucia Montes', 'Femenino', '2000-10-30'),
    ('Rolando Guzman', 'Masculino', '1998-06-30'),
    ('Alfonso Salazar', 'Masculino', '1992-04-30'),
    ('Edith Gonzales', 'Femenino', '1993-06-30'),
    ('Silvio Muñoz', 'Masculino', '1992-06-15'),
    ('Enrique Beltran', 'Masculino', '1992-11-10'),
    ('Julian Velasco', 'Masculino', '1990-10-09'),
    ('Armand Bastidas', 'Masculino', '1990-11-11'),
    ('Bernardo Bonilla', 'Masculino', '1982-10-10'),
    ('Isabell Dominguez', 'Femenino', '1990-05-08'),
    ('Patricia Bermudez', 'Femenino', '1991-04-05'),
    ('William Burbano', 'Masculino', '1992-05-05'),
    ('Hernando Cadena', 'Masculino', '1993-05-07'),
    ('Lucia Cabrera', 'Femenino', '1992-06-10'),
    ('Antonio Caicedo', 'Masculino', '1980-06-10'),
    ('Silvio Teran', 'Masculino', '1990-12-10'),
    ('Pablo Camayo', 'Masculino', '1992-10-10'),
    ('Edith Castro', 'Femenino', '1985-05-03'),
    ('Santiago Ceron', 'Masculino', '1982-09-10'),
    ('Lucia Arciniega', 'Femenino', '1981-07-11'),
    ('Lucila Cifuentes', 'Femenino', '1980-10-03'),
    ('Paulo Lopez', 'Masculino', '1979-05-14'),
    ('Olga Urdaneta', 'Femenino', '1980-03-11'),
    ('Luis Bermudez', 'Masculino', '1981-03-11'),
    ('Humberto Erazo', 'Masculino', '1990-08-10'),
    ('Paolo Espinosa', 'Masculino', '1993-03-10'),
    ('Antonio Fernandez', 'Femenino', '1990-02-15'),
    ('Edward Londoño', 'Masculino', '1993-06-24'),
    ('Lorena Gaviria', 'Femenino', '1992-05-29'),
    ('Pedro Hidalgo', 'Masculino', '1990-10-25'),
    ('Ana Ordoñez', 'Femenino', '1995-06-30'),
    ('Jeremias Hurtado', 'Masculino', '1991-09-18'),
    ('Jeremias Lasso', 'Femenino', '1992-10-11'),
    ('Rosabalda Lara', 'Femenino', '1990-03-12'),
    ('Wilson Manrique', 'Masculino', '1995-11-10'),
    ('Aicardo Muñoz', 'Masculino', '1990-05-06');

INSERT INTO motivos_reprogramacion
(`Motivo_Descripcion`)
VALUES
('Poca venta de tiquetes'),
('Mantenimiento del bus'),
('Inseguridad en la zona'),
('Retraso del bus'),
('Estado de la vía');