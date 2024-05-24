-- Active: 1716011690015@@localhost@3306@empresa_transporte
CREATE PROCEDURE Reprograma_Viajes (IN Viaje INT, IN Fecha_Reprogramacion DATETIME)
BEGIN
    UPDATE viajes SET `Fecha_Programada_Viaje` = Fecha_Reprogramacion WHERE `Viaje_ID` = Viaje;
END;

-- Reprogramando un viaje
CALL `Reprograma_Viajes`(4, '2022-03-11 07:30:00');

CREATE PROCEDURE Motivo_Reprogramacion (IN Reprogramacion INT, IN Motivo INT)
BEGIN
    UPDATE viajes_reprogramados SET `Motivo_ID` = Motivo WHERE `Reprogramacion_ID` = Reprogramacion;
END;

CALL Motivo_Reprogramacion (1, 3);