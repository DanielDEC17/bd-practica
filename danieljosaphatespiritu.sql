CREATE DATABASE IF NOT EXISTS danieljosaphatespiritu;
USE danieljosaphatespiritu;

CREATE TABLE compania (
    compania_id INT AUTO_INCREMENT PRIMARY KEY,
    ruc VARCHAR(20) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    direccion_sucursal VARCHAR(255),
    telefono VARCHAR(20),
    cel1 VARCHAR(20),
    cel2 VARCHAR(20)
);

CREATE TABLE cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    ruc VARCHAR(20) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255)
);

CREATE TABLE vendedor (
    vendedor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE factura (
    factura_id INT AUTO_INCREMENT PRIMARY KEY,
    compania_id INT,
    cliente_id INT,
    vendedor_id INT,
    nfactura VARCHAR(50) NOT NULL,
    fecha_factura DATE NOT NULL,
    metodo_pago VARCHAR(50),
    subtotal DECIMAL(10, 2) NOT NULL,
    igv DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    cantidad VARCHAR(255),
    FOREIGN KEY (compania_id) REFERENCES compania(compania_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedor(vendedor_id)
);

CREATE TABLE elemento_factura (
    elemento_factura_id INT AUTO_INCREMENT PRIMARY KEY,
    factura_id INT,
    codigo VARCHAR(50),
    descripcion VARCHAR(255),
    cantidad DECIMAL(10, 2) NOT NULL,
    precio_unit DECIMAL(10, 4) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES factura(factura_id)
);

-- Insertando datos
INSERT INTO compania (ruc, nombre, direccion, direccion_sucursal, telefono, cel1, cel2)
VALUES ('20514641090', 'SALCEDOTEX S.A.C.', 'Jr. Luis Giribaldi Nro 583 - La Victoria - Lima - Lima', 'Jr. Luis Giribaldi Nro 575 - La. Victoria - Lima - Lima', '01-324-3938', '947-294-300', '977-765-787');

INSERT INTO cliente (ruc, nombre, direccion)
VALUES ('10105932028', 'ALANYA LEONARDO MARISOL MARIA', 'MZA. B-6 LOTE. 36 ASOC VIV STA ANITA SANTA ANITA');

INSERT INTO vendedor (nombre)
VALUES ('SERVELEON ROJAS GIANINA');

INSERT INTO factura (compania_id, cliente_id, vendedor_id, nfactura, fecha_factura, metodo_pago, subtotal, igv, total, cantidad)
VALUES (
    (SELECT compania_id FROM compania WHERE ruc = '20514641090'),
    (SELECT cliente_id FROM cliente WHERE ruc = '10105932028'),
    (SELECT vendedor_id FROM vendedor WHERE nombre = 'SERVELEON ROJAS GIANINA'),
    'F002-00000345', '2018-01-24', 'CONTADO C/E', 241.53, 43.47, 285.00, 'DOSCIENTOS OCHENTA Y CINCO CON 00/100SOLES'
);

INSERT INTO elemento_factura (factura_id, codigo, descripcion, cantidad, precio_unit, total)
VALUES (
    (SELECT factura_id FROM factura WHERE nfactura = 'F002-00000345'),
    'DRI0000012', 'DRILL 2B01 1RA GOLDEN POL', 30.00, 8.0508, 241.53
);

