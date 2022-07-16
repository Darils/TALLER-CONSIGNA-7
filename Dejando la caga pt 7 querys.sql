USE CoderHouse

/* DESAFIO CLASE 7 */ 

/* 1.- Indicar cuantos cursos y carreras  tiene el área de Data. Renombrar la nueva columna como cant_asignaturas. Keywords: Tipo, Área, Asignaturas. */

-- PARA VER LAS TABLAS
SELECT * FROM Asignaturas

-- COMIENZO DE LA SINTAXIS
SELECT Tipo, COUNT(Area) AS cant_asignaturas    -- COMO PIDE INDICAT CUANTOS, INICIAMOS SENTENCIA DE CONTAR A Area
FROM Asignaturas
WHERE Area = 5									-- APLICAMOS AL AREA 5 QUE SERIA "Data"
GROUP BY Tipo									-- AGRUPAMOS SEGUN CURSO O CARRERA


/* 2.- Se requiere saber cual es el nombre, el documento y el teléfono de los estudiantes que son profesionales en agronomía y que nacieron entre el año 1970 y el año 2000.
Keywords: Estudiantes, Profesión, fecha de Nacimiento. */ 

-- PARA VER LAS TABLAS
SELECT * FROM Estudiantes
SELECT * FROM Profesiones
-- NECESITAMOS  6 PARA AGRONOMIA

-- COMIENZO DE LA SINTAXIS
SELECT																	-- PEDIMOS NOMBRE DOCUMENTO Y TEL COMO PIDE LA CONSIGNA
Nombre,
Documento,	
Telefono
FROM Estudiantes														-- TABLA A UTILIZAR
where Profesion = '6'													-- NECESITAMOS AGRONOMIA DE LA TABLA PROFESIONES = 6
and [Fecha de Nacimiento] BETWEEN '1970-01-01' AND '2000-12-31'			-- CONDICION DE FECHA ENTRE AÑOS SOLICITADOS
	
/* 3.- Se requiere un listado de los docentes que ingresaron en el año 2021 y concatenar los campos nombre y apellido. El resultado debe utilizar un separador: guión (-). 
Ejemplo: Elba-Jimenez. Renombrar la nueva columna como Nombres_Apellidos. Los resultados de la nueva columna deben estar en mayúsculas. Keywords: Staff, Fecha Ingreso, Nombre, Apellido. */

-- PARA VER LAS TABLAS
SELECT * FROM Staff

-- COMIENZO DE LA SINTAXIS
SELECT UPPER(CONCAT(Nombre, '-', Apellido)) AS Nombres_Apellidos		-- COMENZAMOS CONCATENANDO SEGUN LA CONSIGNA, PIDIENDOLAS EN MAYUS
FROM Staff
WHERE YEAR([Fecha Ingreso]) = 2021										-- CONDICION FECHA DE INGRESO DEL 2021
 
 /* 4.- Indicar la cantidad de encargados de docentes y de tutores. Renombrar la columna como CantEncargados. Quitar la palabra ”Encargado ”en cada uno de los registros. 
 Renombrar la columna como NuevoTipo. Keywords: Encargado, tipo, Encargado_ID. */

 -- PARA VER LAS TABLAS
 SELECT * FROM Encargado

 -- COMIENZO DE LA SINTAXIS
 SELECT REPLACE(Tipo, 'Encargado', '') AS NuevoTipo, COUNT(Encargado_ID) AS CantEncargados		-- PEDIMOS QUE REEMPLAZE ENCARGADO POR UN ESPACIO Y CONTAMOS LOS ENCARGADOS
 FROM [Encargado]
 GROUP BY Tipo

 /* 5.- Indicar cual es el precio promedio de las carreras y los cursos por jornada. Renombrar la nueva columna como Promedio. Ordenar los promedios de Mayor a menor
 Keywords: Tipo, Jornada, Asignaturas. */
  
 -- PARA VER LAS TABLAS
 SELECT * FROM Asignaturas

 -- COMIENZO DE LA SINTAXIS
 SELECT Tipo, Jornada, AVG(Costo) AS Promedio			-- PEDIMOS EL PROMEDIO DEL COSTO
 FROM [Asignaturas]
 GROUP BY Tipo, Jornada									-- PEDIMOS QUE AGRUPE SEGUN TIPO DE ASIGNATURA, QUE DEVOLVERA EL PROMEDIO POR GRUPO DE ASIGNATURA
 ORDER BY Promedio DESC

 /* 6.- Se requiere calcular la edad de los estudiantes en una nueva columna. Renombrar a la nueva columna Edad. Filtrar solo los que son mayores de 18 años. 
Ordenar de Menor a Mayor Keywords: Fecha de Nacimiento, Estudiantes. */

 -- PARA VER LAS TABLAS
 SELECT * FROM Estudiantes

 -- COMIENZO DE LA SINTAXIS
 SELECT
 *,
 DATEDIFF(year, [Fecha de Nacimiento], GETDATE()) AS Edad			-- PARA OBTENER LA EDAD, HACEMOS DIFERENCIA ENTRE LA FECHA DE NACIMIENTO Y LA ACTUAL
 FROM Estudiantes
 WHERE DATEDIFF(year, [Fecha de Nacimiento], GETDATE()) >= 18		-- FILTRAMOS LOS MAYORES DE EDAD
 ORDER BY Edad ASC

/* 7.- Se requiere saber el Nombre,el correo, la camada y la fecha de ingreso de personas del staff que contienen correo .edu y su DocenteID se mayor o igual que 100
 Keywords: Staff, correo, DocentesID*/

 -- COMIENZO DE LA SINTAXIS
 SELECT DocentesID, Nombre, Correo, Camada, [Fecha Ingreso]			-- PEDIMOS LOS DATOS DE LA TABLA STAFF
 FROM Staff
WHERE Correo LIKE '%.edu%' AND DocentesID >= 100					-- PEDIMOS LOS DATOS CON LA CONDICIONANTE QUE TENGA .EDU EN EL CORREO Y QUE EL ID SEA MAYOR AL VALOR QUE PIDE 100


/* 8.- Se requiere conocer el documento, el domicilio el código postal y el nombre de los primeros estudiantes que se registraron en la plataforma. 
Keywords: Documento, Estudiantes, Fecha Ingreso. */

-- PARA VER LAS TABLAS
SELECT * FROM Estudiantes

-- COMIENZO DE LA SINTAXIS
SELECT Documento, Domicilio, [Codigo Postal], Nombre									-- PEDIMOS LOS DATOS DE LOS ESTUDIANTES
FROM Estudiantes 
WHERE [Fecha Ingreso] = (SELECT MIN([Fecha Ingreso]) AS fechamin FROM Estudiantes)		-- AGREGAMOS QUE LA CONDICION SEA LA MENOR FECHA (PRIMER REGISTRO) EN UN SELECT ANIDADO

/* 9.- Indicar el nombre apellido y documento de los docentes y tutores que tienen asignaturas “UX” . 
Keywords: Staff, Asignaturas, Nombre, Apellido. */

-- PARA VER LAS TABLAS
SELECT * FROM Asignaturas

-- COMIENZO DE LA SINTAXIS
SELECT Nombre, Apellido, Documento															-- PEDIMOS LOS DATOS DE LA TABLA STAFF
FROM Staff
WHERE Asignatura IN (SELECT AsignaturasID FROM Asignaturas WHERE Nombre LIKE('%UX%'))		-- ANIDAMOS UNA SUBCONSULTA CON IN PARA QUE NOS DEVUELVA LOS VALORES QUE OBTENGA EL OPERADOR LIKE SOBRE UX

/* 10.- Se desea calcular el 25% de aumento para las asignaturas del área de marketing de la jornada mañana
se deben traer todos los campos, mas el de los cálculos correspondientes el porcentaje y el Nuevo costo debe estar en decimal con 3 digitos. 
Renombrar el calculo del porcentaje con el nombre porcentaje y la suma del costo mas el porcentaje por NuevoCosto. Keywords: Asignaturas, Costo, Área, Jornada, Nombre */

-- PARA VER LAS TABLAS
SELECT * FROM Asignaturas

-- COMIENZO DE LA SINTAXIS
SELECT *, 
'+25%' AS Porcentaje,										-- Mostramos en el query cual es el porcentaje que vamos a agregar
CAST((Costo*0.25)AS DECIMAL(7,3)) AS ValorPorcentaje,		-- Tomamos el valor del porcentaje individual segun el valor de la asignatura
Costo+CAST((Costo*0.25)AS DECIMAL(7,3)) AS NuevoCosto		-- Sumamos el valor del porcentaje mas el costo para tener el valor nuevo
FROM Asignaturas
WHERE Jornada = 'Manana' AND Nombre LIKE '%Marketing%'		-- Agregamos condicion que sea en la mañana y sea de las asignaturas de marketing

-- FIN CONSIGNA 7

