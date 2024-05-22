-- Active: 1716011690015@@localhost@3306@empresa_transporte
-- Triggers que calcula las edades
CREATE TRIGGER calcula_edad_conductor 
BEFORE INSERT ON conductores 
FOR EACH ROW
BEGIN
    SET NEW.Edad_Conductor = TIMESTAMPDIFF(YEAR, NEW.Fecha_Nacimiento_Conductor, CURDATE());
END;

CREATE TRIGGER calcula_edad_viajero BEFORE INSERT ON viajeros FOR EACH ROW
BEGIN
	SET NEW.Edad_Viajero = TIMESTAMPDIFF(YEAR, NEW.Fecha_Nacimiento_Viajero, CURDATE());
END;

CREATE TRIGGER calcula_edad_taquillero BEFORE INSERT ON taquillero FOR EACH ROW
BEGIN
	SET NEW.Edad_Taquillero = TIMESTAMPDIFF(YEAR, NEW.Fecha_Nacimiento_Taquillero, CURDATE());
END;

-- Trigger que evita insertar trabajadores menores de edad
CREATE TRIGGER conductores_menores_edad BEFORE INSERT 
ON conductores FOR EACH ROW 
BEGIN 
DECLARE
	Edad INT;
    SET Edad = NEW.Edad_Conductor;
	IF Edad < 18 THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'El usuario debe ser mayor de 18 años.';
END
	IF;
END;

CREATE TRIGGER taquilleros_menores_edad BEFORE INSERT 
ON taquillero FOR EACH ROW 
BEGIN 
DECLARE
	Edad INT;
	SET Edad = NEW.Edad_Taquillero;
	IF Edad < 18 THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'El usuario debe ser mayor de 18 años.';
END
	IF;
END;

/* Trigger que inserta automaticamente registros en la tabla de conductores desvinculados antes de 
hacer la eliminación */
CREATE TRIGGER conductores_desvinculados BEFORE DELETE 
ON conductores FOR EACH ROW 
BEGIN 
	INSERT INTO
	    trabajadores_desvinculados (
	        `Trabajador_ID`, `Nombre_Trabajador`, `Genero_Trabajador`, `Fecha_Nacimiento_Trabajador`, `Fecha_Contrato_Trabajador`, `Fecha_Retiro`
	    )
	VALUES (
	        OLD.Conductor_ID, OLD.Nombre_Conductor, OLD.Genero_Conductor, OLD.Fecha_Nacimiento_Conductor, OLD.Fecha_Contratacion, CURDATE()
	    );
END;

CREATE TRIGGER taquilleros_desvinculados BEFORE DELETE 
ON taquillero FOR EACH ROW 
BEGIN 
	INSERT INTO
	    trabajadores_desvinculados (
	        `Trabajador_ID`, `Nombre_Trabajador`, `Genero_Trabajador`, `Fecha_Nacimiento_Trabajador`, `Fecha_Contrato_Trabajador`, `Fecha_Retiro`
	    )
	VALUES (
	        OLD.Taquillero_ID, OLD.Nombre_Taquillero, OLD.Genero_Taquillero, OLD.Fecha_Nacimiento_Taquillero, OLD.Fecha_Contratacion, CURDATE()
	    );
END;

/* Trigger que actualiza registros en la tabla tiquete en caso de algún error, por ejemplo, si al 
ingresar un registro que no aplica descuento y se asigna un valor incorrecto, automaticamente el 
trigger actualizará el valor a 0.0 en Valor_Descuento */
CREATE TRIGGER descuentos_inconsistentes BEFORE INSERT ON tiquete FOR EACH ROW
BEGIN
	DECLARE Aplica_Descuento BOOLEAN;
	SET Aplica_Descuento = NEW.Aplica_Descuento;

	IF Aplica_Descuento = FALSE THEN
		SET NEW.Valor_Descuento = 0;
	END IF;
END;

/* Trigger que cambia el estado de viaje a finalizado cuando se inserta un viaje en la tabla de 
llegadas, ya que por defecto en la tabla de viajes se encuentra en estado programado */
CREATE TRIGGER viajes_finalizados AFTER INSERT ON llegadas 
FOR EACH ROW 
BEGIN 
	UPDATE viajes
	SET
	    Estado_Viaje = 'Finalizado'
	WHERE
	    viajes.`Viaje_ID` = NEW.`Viaje_ID`;
END;

/* Creación de un trigger que inserta registros en una tabla (viajes_reprogramados) cuando se cambia la 
fecha del viaje. Esto ocurrirá después de un UPDATE en la tabla viajes */
CREATE TRIGGER viajes_reprogramados AFTER UPDATE ON 
viajes FOR EACH ROW 
BEGIN 
	INSERT INTO
	    viajes_reprogramados (
	        `Viaje_ID`, `Fecha_Programada_Viaje_Inicial`, `Fecha_Programada_Viaje_Nueva`
	    )
	SELECT NEW.`Viaje_ID`, OLD.`Fecha_Programada_Viaje`, NEW.`Fecha_Programada_Viaje`
	FROM viajes
	WHERE
	    viajes.`Viaje_ID` = NEW.`Viaje_ID`
	    AND `Estado_Viaje` = 'Programado';
END;

-- Se realizan pruebas con el trigger y funcionó de forma correcta

CREATE TRIGGER no_actualizar_viajes_finalizados BEFORE 
UPDATE ON viajes FOR EACH ROW 
BEGIN 
DECLARE
	Viaje_Estado VARCHAR(30);
	SET Viaje_Estado = OLD.Estado_Viaje;
	IF Viaje_Estado = 'Finalizado' THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'No es posible actualizar viajes finalizados, por favor verifica la información que deseas actualizar';
END
	IF;
END;

/* El siguiente trigger consiste en actualizar el estado del viaje en la tabla viaje_conductor, por 
defecto se encontrará en estado programado, y una vez finalizado el viaje se va a cambiar a estado 
finalizado */
CREATE TRIGGER viaje_estado AFTER UPDATE ON viajes 
FOR EACH ROW 
BEGIN 
	UPDATE viaje_conductor
	SET
	    `Estado_Viaje` = NEW.`Estado_Viaje`
	WHERE
	    `Viaje_ID` = NEW.`Viaje_ID`;
END;

-- Trigger que cuenta la cantidad de tiquetes que ha comprado un usuario
CREATE TRIGGER cantidad_viajes AFTER INSERT ON tiquete FOR EACH ROW
BEGIN
    UPDATE viajeros SET `Cantidad_Viajes` = (SELECT COUNT(NEW.Viajero_ID) FROM tiquete t
    WHERE `Viajero_ID` = NEW.`Viajero_ID`)
    WHERE `Viajero_ID` = NEW.`Viajero_ID`;
END;

-- El trigger cuenta la cantidad de tiquetes o las veces que un taquillero atendió
CREATE TRIGGER cantidad_tiquetes AFTER INSERT ON tiquete FOR EACH ROW
BEGIN
	UPDATE taquillero SET `Cantidad_Tiquetes` = (SELECT COUNT(`Taquillero_ID`) FROM tiquete WHERE `Taquillero_ID` = NEW.`Taquillero_ID`)
	WHERE `Taquillero_ID` = NEW.`Taquillero_ID`;
END;

/* Trigger que cambia el estado de un viaje reprogramado a finalizado en caso de que el viaje 
registrado bajo el Viaje_ID tenga registro de una llegada */
CREATE TRIGGER viajes_reprogramados_actualizados AFTER UPDATE ON viajes FOR EACH ROW
BEGIN
	UPDATE viajes_reprogramados SET `Estado_Viaje` = 'Finalizado' WHERE `Viaje_ID` = NEW.`Viaje_ID`
	AND NEW.`Estado_Viaje` = 'Finalizado';
END;

/* Trigger que se encargue de sumar la cantidad de viajes asignados que tiene un bus. El proceso se 
ejecuta después de insertar un registro en la tabla de viajes */
CREATE TRIGGER viajes_asignados_buses AFTER INSERT ON viajes FOR EACH ROW
BEGIN
	UPDATE buses SET `Cantidad_Viajes_Asignados` = (SELECT COUNT(`Viaje_ID`) FROM viajes WHERE `Bus_ID` = NEW.`Bus_ID`)
	WHERE `Bus_ID` = NEW.`Bus_ID`;
END;

/* Trigger que se encargue de sumar la cantidad de viajes finalizados que tiene un bus. El proceso se 
ejecuta después de insertar un registro en la tabla de viajes, además, después de actualizada la 
información hará una resta entre la cantidad de viajes asignados y finalizados, con la finalidad de 
determinar la cantidad real de viajes que tiene pendientes o asignados */
CREATE TRIGGER viajes_finalizados_buses AFTER UPDATE ON viajes FOR EACH ROW
BEGIN
	UPDATE buses SET `Cantidad_Viajes_Finalizados` = (SELECT COUNT(`Viaje_ID`) FROM viajes WHERE `Bus_ID` = NEW.`Bus_ID` AND `Estado_Viaje` = 'Finalizado') WHERE `Bus_ID` = NEW.`Bus_ID`;
END;

/* Trigger que cuenta la cantidad de viajes finalizados que tuvo asignado un conductor. El proceso 
consiste en actualizar la cantidad de viajes que realizó un conductor después de que se actualicé la 
tabla de viaje_conductor */
CREATE TRIGGER cantidad_viajes_realizados AFTER UPDATE ON viaje_conductor FOR EACH ROW
BEGIN
	UPDATE conductores SET `Cantidad_Viajes_Realizados` = (SELECT COUNT(`Conductor_ID`) FROM viaje_conductor WHERE `Estado_Viaje` = 'Finalizado' AND `Conductor_ID` = NEW.`Conductor_ID`)
	WHERE `Conductor_ID` = NEW.`Conductor_ID`;
END;

CREATE TRIGGER total_viajes_conductor AFTER INSERT ON viaje_conductor FOR EACH ROW
BEGIN
	UPDATE conductores SET `Total_Viajes_Asignados` = (SELECT COUNT(`Conductor_ID`) FROM viaje_conductor WHERE `Conductor_ID` = NEW.`Conductor_ID`)
	WHERE `Conductor_ID` = NEW.`Conductor_ID`;
END;

/* El presente trigger evitará que una fecha de compra de un determinado tiquete sea mayor que la fecha 
del viaje programado */
CREATE TRIGGER fecha_compra_tiquete BEFORE INSERT ON tiquete FOR EACH ROW
BEGIN
	DECLARE fecha_programada DATETIME;
	SELECT v.`Fecha_Programada_Viaje` INTO fecha_programada FROM viajes v WHERE NEW.`Viaje_ID` = v.`Viaje_ID`;
	IF NEW.Fecha_Compra > fecha_programada THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de información, la fecha de compra es mayor que la fecha de viaje programada.';
    END IF;	
END;

/* Trigger que evita ingresar una fecha de llegada menor a una fecha programada de dicho viaje, 
es decir, si un viaje está programado para el 2024-05-20 17:00 no puede registrar una fecha de llegada
de 2024-05-20 16:00 */ 
CREATE TRIGGER fecha_llegada BEFORE INSERT ON llegadas FOR EACH ROW
BEGIN
	DECLARE fecha_programada DATETIME;
	SELECT v.`Fecha_Programada_Viaje` INTO fecha_programada FROM viajes v WHERE NEW.`Viaje_ID` = v.`Viaje_ID`;
	IF NEW.Fecha_Llegada < fecha_programada THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de información, la fecha de llegada no puede ser menor que la fecha de viaje programada.';
    END IF;	 
END;

/* El presente trigger tiene como finalidad evitar que la cantidad de pasajeros en un viaje sea mayor
que la capacidad que tiene un bus de llevar pasajeros, por ejemplo, si un bus tiene una capacidad de
llevar 34 pasajeros el trigger evitará que se haga una compra de un pasajero #35 y se debe tener en
cuenta que el viaje no debe estar finalizado. */
CREATE TRIGGER capacidad_buses BEFORE INSERT ON tiquete FOR EACH ROW
BEGIN
	DECLARE capacidad_buses INT;
	DECLARE cantidad_pasajeros INT;
	DECLARE estado_viaje VARCHAR(30);
	
	SELECT b.Capacidad_Pasajeros
    INTO capacidad_buses
    FROM buses b
    JOIN viajes v ON v.Bus_ID = b.Bus_ID
    WHERE v.Viaje_ID = NEW.Viaje_ID AND v.`Estado_Viaje` = 'Programado';


	SELECT COUNT(*)
    INTO cantidad_pasajeros
    FROM tiquete t
    WHERE t.Viaje_ID = NEW.Viaje_ID;


	IF cantidad_pasajeros = capacidad_buses 
	THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay cupos disponibles en el viaje.';
    END IF;
END;