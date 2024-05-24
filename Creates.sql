-- Active: 1716011690015@@localhost@3306@empresa_transporte
-- Creación de la base de datos
CREATE DATABASE empresa_transporte;
USE empresa_transporte;
-- Creación de tabla viajeros o pasajeros
CREATE TABLE
    viajeros (
        Viajero_ID INT AUTO_INCREMENT PRIMARY KEY,
        Nombre VARCHAR(30) NOT NULL,
        Genero VARCHAR(30),
        Fecha_Nacimiento_Viajero DATE,
        Edad_Viajero INT,
        Cantidad_Viajes INT DEFAULT 0
    );

-- Creación de tabla de departamentos (departamentos de Colombia)
CREATE TABLE
    departamentos (
        Departamento_ID INT AUTO_INCREMENT PRIMARY KEY,
        Nombre_Departamento VARCHAR(30) NOT NULL
    );

-- Creación de tabla de ciudades
CREATE TABLE
    ciudades (
        Ciudad_ID INT AUTO_INCREMENT PRIMARY KEY,
        Ciudad_Nombre VARCHAR(30),
        Departamento_ID INT NOT NULL,
        CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY (Departamento_ID) REFERENCES departamentos (Departamento_ID) ON DELETE CASCADE ON UPDATE CASCADE
    );

/* Se crean tablas de ciudad origen y ciudad destino, las cuales tienen como función alimentar la tabla 
de ruta, ya que en una empresa de viajes siempre hay una ciudad desde la que parte un bus hasta una 
ciudad de llegada o destino */
CREATE TABLE ciudad_origen (
    Ciudad_Origen_ID INT PRIMARY KEY,
    Ciudad_Origen_Nombre VARCHAR(30)
);

CREATE TABLE ciudad_destino (
    Ciudad_Destino_ID INT PRIMARY KEY,
    Ciudad_Destino_Nombre VARCHAR(30)
);

-- Creación de tabla de rutas
CREATE TABLE rutas (
    Ruta_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ciudad_Origen_ID INT,
    Ciudad_Destino_ID INT,
    CONSTRAINT FK_CIUDAD_ORIGEN_RUTA FOREIGN KEY(Ciudad_Origen_ID) REFERENCES ciudad_origen(Ciudad_Origen_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CIUDAD_DESTINO_RUTA FOREIGN KEY(Ciudad_Destino_ID) REFERENCES ciudad_destino(Ciudad_Destino_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Creación de la tabla de conductores
CREATE TABLE
    conductores (
        Conductor_ID INT AUTO_INCREMENT PRIMARY KEY,
        Nombre_Conductor VARCHAR(30) NOT NULL,
        Genero_Conductor VARCHAR(30),
        Fecha_Nacimiento_Conductor DATE,
        Edad_Conductor INT,
        Fecha_Contratacion DATE NOT NULL,
        Total_Viajes_Asignados INT DEFAULT 0,
        Cantidad_Viajes_Realizados INT DEFAULT 0,
        Cantidad_Viajes_Pendientes INT AS (Total_Viajes_Asignados - Cantidad_Viajes_Realizados)
    );
-- Creación de la tabla de marcas. Contiene un listado de las marcas de los buses
CREATE TABLE
    marcas (
        Marca_ID INT AUTO_INCREMENT PRIMARY KEY,
        Marca_Nombre VARCHAR(30) NOT NULL,
        Imagen_Marca TEXT
    );

-- Creación de la tabla de buses
CREATE TABLE
    buses (
        Bus_ID INT AUTO_INCREMENT PRIMARY KEY,
        Capacidad_Pasajeros INT,
        Marca_ID INT NOT NULL,
        Municipio_Matricula_ID INT,
        Fecha_Matricula DATE,
        Cantidad_Viajes_Asignados INT DEFAULT 0,
        Cantidad_Viajes_Finalizados INT DEFAULT 0,
        Cantidad_Viajes_Pendientes INT AS (Cantidad_Viajes_Asignados - Cantidad_Viajes_Finalizados),
        CONSTRAINT FK_MUNICIPIO_MATRICULA FOREIGN KEY (Municipio_Matricula_ID) REFERENCES ciudades (Ciudad_ID) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_MARCA_BUS FOREIGN KEY (Marca_ID) REFERENCES marcas (Marca_ID) ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Tabla que contiene todos los viajes programados
CREATE TABLE viajes (
    Viaje_ID INT AUTO_INCREMENT PRIMARY KEY,
    Bus_ID INT NOT NULL,
    Ruta_ID INT,
    Fecha_Programada_Viaje DATETIME NOT NULL,
    Estado_Viaje VARCHAR(30) DEFAULT 'Programado',
    CONSTRAINT FK_BUSES_VIAJES FOREIGN KEY(Bus_ID) REFERENCES buses(Bus_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_RUTAS_VIAJES FOREIGN KEY(Ruta_ID) REFERENCES rutas(Ruta_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Llegadas de los viajes
CREATE TABLE llegadas (
    Llegada_ID INT AUTO_INCREMENT PRIMARY KEY,
    Viaje_ID INT NOT NULL,
    Fecha_Llegada DATETIME NOT NULL,
    CONSTRAINT FK_VIAJES_LLEGADAS FOREIGN KEY (Viaje_ID) REFERENCES viajes(Viaje_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Motivos_Reprogramacion (
    Motivo_ID INT AUTO_INCREMENT PRIMARY KEY,
    Motivo_Descripcion VARCHAR(30) NOT NULL
)

/* En caso de que un viaje se reprograme bajo cualquier circunstancia se crea una tabla llamada viajes 
reprogramados */
CREATE TABLE Viajes_Reprogramados (
    Reprogramacion_ID INT AUTO_INCREMENT PRIMARY KEY,
    Viaje_ID INT,
    Fecha_Programada_Viaje_Inicial DATETIME, -- Primera fecha en la que se programó el viaje
    Fecha_Programada_Viaje_Nueva DATETIME, -- Nueva fecha en la que se programa el viaje
    Estado_Viaje VARCHAR(30) DEFAULT 'Reprogramado',
    Motivo_ID INT DEFAULT 1,
    CONSTRAINT FK_VIAJE_REPROGRAMADO FOREIGN KEY (Viaje_ID) REFERENCES viajes(Viaje_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_MOTIVO_REPROGRAMACION FOREIGN KEY (Motivo_ID) REFERENCES Motivos_Reprogramacion(Motivo_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* Se va a crear una tabla que mantenga relaciones entre las tablas viajes y conductores, debido a que 
un viaje puede tener asignados varios conductores y varios conductores pueden estar asignados para un 
viaje */
CREATE TABLE Viaje_Conductor (
    Registro_ID INT AUTO_INCREMENT PRIMARY KEY,
    Viaje_ID INT,
    Conductor_ID INT,
    Estado_Viaje VARCHAR(30) DEFAULT 'Programado',
    CONSTRAINT FK_VIAJE_CONDUCTOR FOREIGN KEY (Viaje_ID) REFERENCES viajes(Viaje_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CONDUCTOR_VIAJE FOREIGN KEY (Conductor_ID) REFERENCES conductores(Conductor_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Listado de terminales o instalaciones donde parte el bus
CREATE TABLE
    terminales (
        Terminal_ID INT AUTO_INCREMENT PRIMARY KEY,
        Nombre_Terminal VARCHAR(100) NOT NULL,
        Ciudad_Ubicacion_ID INT,
        CONSTRAINT FK_CIUDAD_UBICACION FOREIGN KEY (Ciudad_Ubicacion_ID) REFERENCES ciudades (Ciudad_ID) ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Listado de trabajadores que se encargan de elaborar el tiquete a los pasajeros
CREATE TABLE
    taquillero (
        Taquillero_ID INT AUTO_INCREMENT PRIMARY KEY,
        Nombre_Taquillero VARCHAR(30) NOT NULL,
        Genero_Taquillero VARCHAR(30),
        Fecha_Nacimiento_Taquillero DATE,
        Edad_Taquillero INT,
        Fecha_Contratacion DATE NOT NULL,
        Cantidad_Tiquetes INT DEFAULT 0,
        Terminal_ID INT,
        CONSTRAINT FK_TERMINAL_OPERACION FOREIGN KEY (Terminal_ID) REFERENCES terminales(Terminal_ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

CREATE TABLE Metodo_Pago (
    Metodo_Pago_ID INT AUTO_INCREMENT PRIMARY KEY,
    Metodo_Pago_Nombre VARCHAR(30)
);

/* Tabla que contiene información detallada del tiquete, como la información del viajero, el taquillero 
o trabajador que hizo el tiquete, el bus asignado para el viaje, la ruta, la fecha en la que se compra 
el tiquete y una fecha en la que está programado el viaje */
CREATE TABLE tiquete (
    Compra_ID INT AUTO_INCREMENT PRIMARY KEY,
    Viajero_ID INT,
    Taquillero_ID INT,
    Viaje_ID INT,
    Metodo_Pago_ID INT,
    Valor_Tiquete INT,
    Aplica_Descuento BOOLEAN,
    Valor_Descuento FLOAT,
    Valor_Pagado INT AS (
        CASE 
            WHEN Aplica_Descuento = TRUE THEN (Valor_Tiquete - (Valor_Tiquete * Valor_Descuento))  
            ELSE Valor_Tiquete 
        END
    ),
    Fecha_Compra DATETIME,
    CONSTRAINT FK_VIAJERO_TIQUETE FOREIGN KEY (Viajero_ID) REFERENCES viajeros(Viajero_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_VIAJE_TIQUETE FOREIGN KEY (Viaje_ID) REFERENCES viajes(Viaje_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_TAQUILLERO_TIQUETE FOREIGN KEY (Taquillero_ID) REFERENCES taquillero(Taquillero_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_METODO_DE_PAGO FOREIGN KEY (Metodo_Pago_ID) REFERENCES Metodo_Pago(Metodo_Pago_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Se realiza una tabla de empleados que renuncian a la empresa
CREATE TABLE
    trabajadores_desvinculados (
        Trabajador_ID INT PRIMARY KEY,
        Nombre_Trabajador VARCHAR(30),
        Genero_Trabajador VARCHAR(30),
        Fecha_Nacimiento_Trabajador VARCHAR(30),
        Fecha_Contrato_Trabajador DATE,
        Fecha_Retiro DATE
    );