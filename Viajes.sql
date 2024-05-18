-- Active: 1716011690015@@localhost@3306@empresa_transporte
-- Insertando registros de viajes
INSERT INTO
    viajes (
        `Bus_ID`,
        `Fecha_Programada_Viaje`
    )
VALUES 
    (1, '2022-03-06 10:30:00'),
    (1, '2022-03-06 21:30:00'),
    (2, '2022-03-10 07:30:00'),
    (2, '2022-03-10 06:30:00'),
    (1, '2022-03-12 06:00:00'),
    (2, '2022-03-12 10:30:00'),
    (3, '2022-03-12 12:00:00'),
    (2, '2022-03-13 14:00:00');

-- Viajes que tiene asignado cada conductor
INSERT INTO
    viaje_conductor (`Viaje_ID`, `Conductor_ID`)
VALUES 
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 1),
    (5, 2),
    (6, 2),
    (7, 3),
    (8, 1);


INSERT INTO tiquete
(`Viajero_ID`, `Taquillero_ID`, `Viaje_ID`, `Ruta_ID`, `Metodo_Pago_ID`, `Valor_Tiquete`, `Aplica_Descuento`, `Valor_Descuento`, `Fecha_Compra`)
VALUES
(1, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-01 11:55'),
(2, NULL, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-01 11:59'),
(2, NULL, 1, 10, 3, 80000, TRUE, 0.3, '2022-03-01 12:06'),
(3, NULL, 1, 10, 2, 80000, TRUE, 0.6, '2022-03-01 14:26'),
(3, NULL, 1, 10, 4, 80000, TRUE, 0.6, '2022-03-01 16:38'),
(4, 2, 1, 10, 2, 80000, TRUE, 0.6, '2022-03-01 16:39'),
(4, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 16:42'),
(5, 1, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-01 16:45'),
(6, 2, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-01 16:45'),
(6, 2, 1, 10, 3, 80000, TRUE, 0.3, '2022-03-01 16:49'),
(7, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-01 16:51'),
(7, 1, 1, 10, 1, 80000, TRUE, 0.3, '2022-03-01 16:55'),
(8, 2, 1, 10, 4, 80000, TRUE, 0.6, '2022-03-01 17:15'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.6, '2022-03-01 17:24'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 17:27'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 17:29'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 17:29'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 17:32'),
(9, 2, 1, 10, 2, 80000, TRUE, 0.3, '2022-03-01 17:36'),
(10, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-01 17:36'),
(11, 2, 1, 10, 2, 80000, TRUE, 0.6, '2022-03-01 17:42'),
(12, 1, 1, 10, 2, 80000, TRUE, 0.6, '2022-03-01 17:46'),
(12, 1, 2, 32, 2, 80000, TRUE, 0.3, '2022-03-01 17:46'),
(13, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-02 09:35'),
(14, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-02 11:46'),
(15, 2, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-02 16:45'),
(10, 2, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-03 10:00'),
(16, 1, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-03 10:01'),
(16, 1, 1, 10, 3, 80000, TRUE, 0.3, '2022-03-03 10:10:00'),
(17, NULL, 1, 10, 3, 80000, TRUE, 0.6, '2022-03-03 10:11'),
(17, NULL, 2, 32, 3, 80000, TRUE, 0.3, '2022-03-03 10:15'),
(18, NULL, 2, 32, 3, 80000, TRUE, 0.6, '2022-03-03 10:15'),
(19, 2, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-03 10:15'),
(20, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-03 11:36'),
(20, 1, 1, 10, 1, 80000, TRUE, 0.6, '2022-03-03 11:39');


-- Esto es un comentario
/*
(`Viajero_ID`, --1
`Taquillero_ID`, --2
`Viaje_ID`, --3
`Ruta_ID`, --4
`Metodo_Pago_ID`, --5
`Valor_Tiquete`, --6
`Aplica_Descuento`, --7
`Valor_Descuento`, --8
`Fecha_Compra`) --9
*/

INSERT INTO tiquete
(`Viajero_ID`, `Taquillero_ID`, `Viaje_ID`, `Ruta_ID`, `Metodo_Pago_ID`, `Valor_Tiquete`, `Aplica_Descuento`, `Valor_Descuento`, `Fecha_Compra`)
VALUES



SELECT v.`Viaje_ID`, b.`Capacidad_Pasajeros`, COUNT(t.`Compra_ID`) AS cantidad_pasajeros FROM viajes v INNER JOIN tiquete t ON t.`Viaje_ID` = v.`Viaje_ID`
INNER JOIN buses b ON b.`Bus_ID` = v.`Bus_ID` GROUP BY v.`Viaje_ID`, b.`Capacidad_Pasajeros`;