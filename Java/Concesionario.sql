
-- Crear la base de datos
CREATE DATABASE Concesionario;
GO

-- Usar la base de datos
USE Concesionario;
GO

-- Tabla de Clientes
CREATE TABLE Clientes (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15),
    Correo VARCHAR(100)
);

-- Tabla de Autos
CREATE TABLE Autos (
    ID_Auto INT IDENTITY(1,1) PRIMARY KEY,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    A�o INT NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Productos
CREATE TABLE Productos (
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    ID_Empleado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50),
    Telefono VARCHAR(15)
);

-- Tabla de Servicios
CREATE TABLE Servicios (
    ID_Servicio INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Costo DECIMAL(10,2) NOT NULL
);

-- Tabla de Ventas
CREATE TABLE Ventas (
    ID_Venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Empleado INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);

-- Tabla de Detalles de Venta de Autos
CREATE TABLE VentaAutos (
    ID_VentaAuto INT IDENTITY(1,1) PRIMARY KEY,
    ID_Venta INT NOT NULL,
    ID_Auto INT NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Auto) REFERENCES Autos(ID_Auto)
);

-- Tabla de Detalles de Venta de Productos
CREATE TABLE VentaProductos (
    ID_VentaProducto INT IDENTITY(1,1) PRIMARY KEY,
    ID_Venta INT NOT NULL,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

-- Tabla de Detalles de Venta de Servicios
CREATE TABLE VentaServicios (
    ID_VentaServicio INT IDENTITY(1,1) PRIMARY KEY,
    ID_Venta INT NOT NULL,
    ID_Servicio INT NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio)
);


--Funcion de clientes 
-- Procedimiento para insertar Clientes
CREATE PROCEDURE sp_InsertarCliente
    @Nombre VARCHAR(100),
    @Telefono VARCHAR(15),
    @Correo VARCHAR(100)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Telefono, Correo)
    VALUES (@Nombre, @Telefono, @Correo);
END;

-- Procedimiento para insertar Autos
CREATE PROCEDURE sp_InsertarAuto
    @Marca VARCHAR(50),
    @Modelo VARCHAR(50),
    @A�o INT,
    @Precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Autos (Marca, Modelo, A�o, Precio)
    VALUES (@Marca, @Modelo, @A�o, @Precio);
END;

-- Procedimiento para insertar Productos
CREATE PROCEDURE sp_InsertarProducto
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(255),
    @Precio DECIMAL(10,2),
    @Stock INT
AS
BEGIN
    INSERT INTO Productos (Nombre, Descripcion, Precio, Stock)
    VALUES (@Nombre, @Descripcion, @Precio, @Stock);
END;

-- Procedimiento para insertar Servicios
CREATE PROCEDURE sp_InsertarServicio
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(255),
    @Costo DECIMAL(10,2),
    @DuracionEstimada INT
AS
BEGIN
    INSERT INTO Servicios (Nombre, Descripcion, Costo, DuracionEstimada)
    VALUES (@Nombre, @Descripcion, @Costo, @DuracionEstimada);
END;

-- Procedimiento para insertar Empleados
CREATE PROCEDURE sp_InsertarEmpleado
    @Nombre VARCHAR(100),
    @Cargo VARCHAR(50),
    @Telefono VARCHAR(15)
AS
BEGIN
    INSERT INTO Empleados (Nombre, Cargo, Telefono)
    VALUES (@Nombre, @Cargo, @Telefono);
END;

-- Procedimiento para insertar Ventas
CREATE PROCEDURE sp_InsertarVenta
    @ClienteID INT,
    @EmpleadoID INT,
    @Fecha DATE,
    @Total DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Ventas (ClienteID, EmpleadoID, Fecha, Total)
    VALUES (@ClienteID, @EmpleadoID, @Fecha, @Total);
END;

-- Procedimiento para insertar detalles de venta de autos
CREATE PROCEDURE sp_InsertarVentaAuto
    @VentaID INT,
    @AutoID INT,
    @PrecioVenta DECIMAL(10,2)
AS
BEGIN
    INSERT INTO VentaAutos (VentaID, AutoID, PrecioVenta)
    VALUES (@VentaID, @AutoID, @PrecioVenta);
END;

-- Procedimiento para insertar detalles de venta de productos
CREATE PROCEDURE sp_InsertarVentaProducto
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2)
AS
BEGIN
    INSERT INTO VentaProductos (VentaID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (@VentaID, @ProductoID, @Cantidad, @PrecioUnitario);
END;

-- Procedimiento para insertar detalles de venta de servicios
CREATE PROCEDURE sp_InsertarVentaServicio
    @VentaID INT,
    @ServicioID INT,
    @Costo DECIMAL(10,2)
AS
BEGIN
    INSERT INTO VentaServicios (VentaID, ServicioID, Costo)
    VALUES (@VentaID, @ServicioID, @Costo);
END;

-- Eliminar un Cliente
CREATE PROCEDURE sp_EliminarCliente
    @ClienteID INT
AS
BEGIN
    DELETE FROM Clientes WHERE ID_Cliente = @ClienteID;
END;

-- Eliminar un Auto
CREATE PROCEDURE sp_EliminarAuto
    @AutoID INT
AS
BEGIN

    DELETE FROM Autos WHERE ID_Auto = @AutoID;
END;

-- Eliminar un Producto
CREATE PROCEDURE sp_EliminarProducto
    @ProductoID INT
AS
BEGIN

    DELETE FROM Productos WHERE ID_Producto = @ProductoID;
END;

-- Eliminar un Servicio
CREATE PROCEDURE sp_EliminarServicio
    @ServicioID INT
AS
BEGIN

    DELETE FROM Servicios WHERE ID_Servicio = @ServicioID;
END;

-- Eliminar un Empleado
CREATE PROCEDURE sp_EliminarEmpleado
    @EmpleadoID INT
AS
BEGIN

    DELETE FROM Empleados WHERE ID_Empleado = @EmpleadoID;
END;

--Buscar Segun el ID
CREATE PROCEDURE ObtenerClientePorID
    @ID_Cliente INT
AS
BEGIN
    SELECT * FROM Clientes
    WHERE ID_Cliente = @ID_Cliente
END;

CREATE PROCEDURE ObtenerAutoPorID
    @ID_Auto INT
AS
BEGIN
    SELECT * FROM Autos
    WHERE ID_Auto = @ID_Auto
END;

CREATE PROCEDURE ObtenerProductoPorID
    @ID_Producto INT
AS
BEGIN
    SELECT * FROM Productos
    WHERE ID_Producto = @ID_Producto
END;

CREATE PROCEDURE ObtenerVentasID
    @ID_Venta INT
AS
BEGIN
    SELECT * FROM Ventas
    WHERE ID_Venta = @ID_Venta
END;

CREATE PROCEDURE ObtenerVentasAutoID
    @ID_VentaAuto INT
AS
BEGIN
    SELECT * FROM VentaAutos
    WHERE ID_VentaAuto = @ID_VentaAuto
END;

CREATE PROCEDURE ObtenerVentasServID
    @ID_VentaServ INT
AS
BEGIN
    SELECT * FROM VentaServicios
    WHERE ID_VentaServicio = @ID_VentaServ
END;

CREATE PROCEDURE ObtenerVentasProductosID
    @ID_VentaProducto INT
AS
BEGIN
    SELECT * FROM VentaProductos
    WHERE ID_VentaProducto = @ID_VentaProducto
END;