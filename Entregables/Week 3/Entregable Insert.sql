# Identificamos cinco transacciones para poblar de datos el modelo creado
# Dos transacciones de para tipo de transacción salida de inventario, dos para el tipo de transacción recepción de inventario y una para el tipo de transacción ajuste de inventario. 
(SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=10 Limit 2)
UNION
(SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=11 Limit 2)
UNION
(SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=12 Limit 1); 
# De acuerdo con los registros seleccionados, se ingresaran datos para las transacciones 10, 11, 12 y otras. En proveedores para el proveedor 4 y otros. 
# En productos para los productos 217, 135, 80, 95, 57

# Antes de realizar la insercción de datos a cada tabla aseguramos que la tabla este vacia, por lo cual la borramos y ajustamos la clave primaria para se reinicie en 1. 
# Para eliminar los datos ignoramos las claves foraneas
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Estudiante_15_202413.TipoTransaccion;
TRUNCATE TABLE Estudiante_15_202413.Proveedor;
TRUNCATE TABLE Estudiante_15_202413.Ciudades;
TRUNCATE TABLE Estudiante_15_202413.Cliente;
TRUNCATE TABLE Estudiante_15_202413.Producto;
TRUNCATE TABLE Estudiante_15_202413.Fecha;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE Estudiante_15_202413.TipoTransaccion AUTO_INCREMENT = 1;
ALTER TABLE Estudiante_15_202413.Proveedor AUTO_INCREMENT = 1;
ALTER TABLE Estudiante_15_202413.Ciudades AUTO_INCREMENT = 1;
ALTER TABLE Estudiante_15_202413.Cliente AUTO_INCREMENT = 1;
ALTER TABLE Estudiante_15_202413.Producto AUTO_INCREMENT = 1;

# Insertar datos en TipoTransaccion 
INSERT INTO Estudiante_15_202413.TipoTransaccion SELECT NULL, TT.TipoTransaccionID, TT.TipoTransaccionNombre FROM WWImportersTransactional.TiposTransaccion TT WHERE TT.TipoTransaccionID >8;
SELECT * FROM Estudiante_15_202413.TipoTransaccion;

# Insertar datos en Proveedor, para asegurar que se ingerse el proveedor con ID 4 
INSERT INTO Estudiante_15_202413.Proveedor 
SELECT NULL, P.ProveedorID, P.NombreProveedor, C.CategoriaProveedor, P.PersonaContactoPrincipalID, P.DiasPago, P.CodigoPostal FROM WWImportersTransactional.proveedoresCopia P 
LEFT JOIN WWImportersTransactional.CategoriasProveedores C ON P.CategoriaProveedorID = C.CategoriaProveedorID WHERE P.ProveedorID LIMIT 5;
SELECT * FROM Estudiante_15_202413.Proveedor;

# Insertar datos en Producto para los cinco productos seleccionados 217, 135, 80, 95, 57
INSERT INTO Estudiante_15_202413.Producto 
SELECT NULL, P.ID_Producto, P.NombreProducto, P.Marca, C.Color, P.Necesita_refrigeracion, P.Dias_tiempo_entrega, P.PrecioRecomendado, P.Impuesto, P.PrecioUnitario FROM WWImportersTransactional.Producto P 
LEFT JOIN WWImportersTransactional.Colores C ON P.ID_Color = C.ID_Color
WHERE P.ID_Producto IN (217, 135, 80, 95, 57); 
SELECT * FROM Estudiante_15_202413.Producto;

# Insertar datos en Ciudades, se insertaran las ciudades que corresponden con los clientes 476 y 33; 17353, 3736. 
# Aseguramos que se incluyan estos dos registros y 
INSERT INTO Estudiante_15_202413.Ciudades 
SELECT NULL, C.ID_Ciudad, C.NombreCiudad, PV.NombreEstadoProvincia, PP.Nombre, C.Poblacion FROM WWImportersTransactional.Ciudades C 
LEFT JOIN WWImportersTransactional.EstadosProvincias PV ON C.ID_EstadoProvincia = PV.ID_EstadosProvincias
LEFT JOIN WWImportersTransactional.Paises PP ON PV.ID_pais = PP.ID_pais
WHERE (C.ID_Ciudad = 3736 OR C.ID_Ciudad= 17353)
UNION
SELECT NULL, C.ID_Ciudad, C.NombreCiudad, PV.NombreEstadoProvincia, PP.Nombre, C.Poblacion FROM WWImportersTransactional.Ciudades C 
LEFT JOIN WWImportersTransactional.EstadosProvincias PV ON C.ID_EstadoProvincia = PV.ID_EstadosProvincias
LEFT JOIN WWImportersTransactional.Paises PP ON PV.ID_pais = PP.ID_pais
LIMIT 5;
SELECT * FROM Estudiante_15_202413.Ciudades;

# Insertar datos en Cliente, agregamos los dados de los clientes 476 y 33 y otros tres datos para dar cumplimineto al requermimiento de poblar la tabla con 5 datos. 

INSERT INTO Estudiante_15_202413.Cliente 
SELECT NULL, C.ID_Cliente, C.Nombre, C.ClienteFactura, EC.ID_Ciudad_DWH, C.LimiteCredito, C.FechaAperturaCuenta, C.DiasPago, GC.NombreGrupoCompra, CC.NombreCategoria FROM WWImportersTransactional.Clientes C 
LEFT JOIN WWImportersTransactional.CategoriasCliente CC ON C.ID_Categoria = CC.ID_Categoria
LEFT JOIN WWImportersTransactional.GruposCompra GC ON GC.ID_GrupoCompra = C.ID_GrupoCompra
LEFT JOIN Estudiante_15_202413.Ciudades EC ON EC.ID_Ciudad_T = C.ID_CiudadEntrega
WHERE C.ID_Cliente=476 OR C.ID_Cliente=33
UNION
SELECT NULL, C.ID_Cliente, C.Nombre, C.ClienteFactura, EC.ID_Ciudad_DWH, C.LimiteCredito, C.FechaAperturaCuenta, C.DiasPago, GC.NombreGrupoCompra, CC.NombreCategoria FROM WWImportersTransactional.Clientes C 
LEFT JOIN WWImportersTransactional.CategoriasCliente CC ON C.ID_Categoria = CC.ID_Categoria
LEFT JOIN WWImportersTransactional.GruposCompra GC ON GC.ID_GrupoCompra = C.ID_GrupoCompra
LEFT JOIN Estudiante_15_202413.Ciudades EC ON EC.ID_Ciudad_T = C.ID_CiudadEntrega
LIMIT 5; 
SELECT * FROM Estudiante_15_202413.Cliente;

INSERT INTO Estudiante_15_202413.Fecha VALUES 
(20140425, "2014-04-25", 25, "Abril", "2014", WEEK('2014-04-25', 3), "Apr 25,2014"), 
(20151210, "2015-12-10", 10, "Diciembre", "2015", WEEK('2015-12-10', 3), "Dec 10,2015"), 
(20150210, "2015-02-10", 10, "Febrero", "2015", WEEK('2015-02-10', 3), "Feb 10,2015"), 
(20140327, "2014-03-27", 27, "Marzo", "2014", WEEK('2014-03-27', 3), "Mar 27,2014"), 
(20160430, "2016-04-30", 30, "Abril", "2016", WEEK('2016-04-30', 3), "Apr 30,2016");
SELECT * FROM Estudiante_15_202413.Fecha;

INSERT INTO Estudiante_15_202413.Hecho_Movimiento 
SELECT NULL, MV.TransaccionProductoID, F.ID_Fecha, PD.ID_Producto_DWH, PV.ID_proveedor_DWH, C.ID_Cliente_DWH, 
            TT.ID_Tipo_transaccion_DWH, MV.Cantidad FROM
             
    ((SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=10 Limit 2)
    UNION
    (SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=11 Limit 2)
    UNION
    (SELECT * FROM WWImportersTransactional.movimientosCopia MC WHERE MC.TipoTransaccionID=12 Limit 1) ) as MV
     
        LEFT JOIN Producto PD ON MV.ProductoID = PD.ID_Producto_T
        LEFT JOIN Cliente C ON MV.ClienteID = C.ID_Cliente_T
        LEFT JOIN Proveedor PV ON MV.ProveedorID = PV.ID_Proveedor_T 
        LEFT JOIN TipoTransaccion TT ON MV.TipoTransaccionID = ID_Tipo_transaccion_T
        LEFT JOIN Fecha F ON MV.FechaTransaccion = F.FechaSource;
SELECT * FROM Hecho_Movimiento
