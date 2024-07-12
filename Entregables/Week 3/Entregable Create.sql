USE Estudiante_15_202413;

DROP TABLE IF EXISTS Hecho_Movimiento;    
DROP TABLE IF EXISTS Ciudades;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Fecha;

CREATE TABLE Fecha (
ID_Fecha INT,
Fecha DATE, 
Dia TINYINT, 
Mes VARCHAR(20), 
Anio SMALLINT,
Numero_semana_ISO TINYINT,
FechaSource VARCHAR(20),
PRIMARY KEY(ID_Fecha));

CREATE TABLE Producto (
ID_Producto_DWH SMALLINT AUTO_INCREMENT PRIMARY KEY, 
ID_Producto_T SMALLINT NOT NULL, 
Nombre VARCHAR(100),
Marca VARCHAR(30), 
Color VARCHAR(10), 
Necesita_refrigeracion BOOLEAN, 
Dias_tiempo_entrega SMALLINT,  
Precio_minorista_recomendado FLOAT, 
Impuesto FLOAT, 
Precio_unitario FLOAT);

CREATE TABLE Proveedor(
ID_proveedor_DWH INT AUTO_INCREMENT PRIMARY KEY,
ID_proveedor_T INT NOT NULL,
Nombre VARCHAR(50),
Categoria VARCHAR(50),
Contacto_principal VARCHAR(30),
Dias_pago INT, 
Codigo_postal INT);

DROP TABLE IF EXISTS TipoTransaccion;
CREATE TABLE TipoTransaccion(
ID_Tipo_transaccion_DWH TINYINT AUTO_INCREMENT PRIMARY KEY,
ID_Tipo_transaccion_T TINYINT NOT NULL,  
Tipo VARCHAR(50));

CREATE TABLE Cliente (
    ID_Cliente_DWH INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente_T INT NOT NULL, 
    Nombre VARCHAR(100),
    ClienteFactura INT,
    ID_CiudadEntrega_DWH INT, 
    LimiteCredito BIGINT, 
    FechaAperturaCuenta Date,
    DiasPago INT, 
    NombreGrupoCompra VARCHAR(30),
    NombreCategoria VARCHAR(30));

CREATE TABLE Ciudades (
    ID_Ciudad_DWH INT AUTO_INCREMENT PRIMARY KEY,
    ID_Ciudad_T INT, 
    Ciudad VARCHAR(100),
    Provincia VARCHAR(100),
    Pais VARCHAR(100),
    Poblacion INT);
    
CREATE TABLE Hecho_Movimiento (
	ID_Movimiento_DWH INT AUTO_INCREMENT PRIMARY KEY,
    ID_Movimiento_T INT NOT NULL, 
    ID_Fecha INT,
    ID_Producto_DWH SMALLINT, 
    ID_proveedor_DWH INT,
    ID_Cliente_DWH INT,
    ID_Tipo_transaccion_DWH TINYINT,
    Cantidad INT);
    
ALTER TABLE Hecho_Movimiento
ADD CONSTRAINT fk_fecha
FOREIGN KEY (ID_Fecha) REFERENCES Fecha(ID_Fecha),
ADD CONSTRAINT fk_producto
FOREIGN KEY (ID_Producto_DWH) REFERENCES Producto(ID_Producto_DWH),
ADD CONSTRAINT fk_proveedor
FOREIGN KEY (ID_proveedor_DWH) REFERENCES Proveedor(ID_proveedor_DWH),
ADD CONSTRAINT fk_cliente
FOREIGN KEY (ID_Cliente_DWH) REFERENCES Cliente(ID_Cliente_DWH),
ADD CONSTRAINT fk_tipoTransaccion
FOREIGN KEY (ID_Tipo_transaccion_DWH) REFERENCES TipoTransaccion(ID_Tipo_transaccion_DWH);