-- Tabla Países
CREATE TABLE Países (
    id_pais SERIAL PRIMARY KEY,
    nombre_pais VARCHAR(100) NOT NULL
);

-- Tabla Dirección
CREATE TABLE Dirección (
    id_direccion SERIAL PRIMARY KEY,
    calle VARCHAR(100),
    colonia VARCHAR(100),
    codigo_postal VARCHAR(10),
    ciudad VARCHAR(100),
    estado VARCHAR(100),
    id_pais INT REFERENCES Países(id_pais)
);

-- Tabla Tipo de Usuario
CREATE TABLE Tipo_de_usuario (
    id_tipo_de_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Usuario
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) ,
    correo_usuario VARCHAR(100) UNIQUE NOT NULL,
    telefono_usuario VARCHAR(15),
    contraseña_usuario VARCHAR(100) NOT NULL,
    id_direccion INT REFERENCES Dirección(id_direccion),
    id_tipo_de_usuario INT REFERENCES Tipo_de_usuario(id_tipo_de_usuario)
);
DROP TABLE Usuario;
DROP TABLE Pago;
DROP TABLE Evaluaciones


SELECT * FROM Usuario

-- Tabla Método de Pago
CREATE TABLE Metodo_de_pago (
    id_metodo_pago SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    id_metodo_pago INT REFERENCES Metodo_de_pago(id_metodo_pago),
    id_usuario INT REFERENCES Usuario(id_usuario)
);

-- Tabla Tipo de Curso
CREATE TABLE Tipo_de_curso (
    id_tipo_de_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Cursos
CREATE TABLE Cursos (
    id_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE,
    fecha_final DATE,
    horario VARCHAR(50),
    id_nivel INT,
    id_tipo_de_curso INT REFERENCES Tipo_de_curso(id_tipo_de_curso)
);

-- Tabla Tipo Inscripción
CREATE TABLE Tipo_inscripcion (
    id_inscripcion SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL CHECK (nombre IN ('Normal', 'Premium'))
);

-- Tabla Evaluaciones
CREATE TABLE Evaluaciones (
    id_evaluacion SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_usuario INT REFERENCES Usuario(id_usuario),
    id_curso INT REFERENCES Cursos(id_curso),
    id_nivel INT
);

-- Ejemplo de SELECT con INNER JOIN incluyendo Tipo_inscripcion
SELECT 
    Usuario.nombre_usuario,
    Usuario.apellido_usuario,
    Cursos.nombre AS curso,
    Pago.monto,
    Pago.fecha,
    Metodo_de_pago.nombre AS metodo_pago,
    Tipo_de_usuario.nombre AS tipo_usuario,
    Países.nombre_pais,
    Tipo_inscripcion.nombre AS tipo_inscripcion
FROM 
    Usuario
INNER JOIN 
    Dirección ON Usuario.id_direccion = Dirección.id_direccion
INNER JOIN 
    Países ON Dirección.id_pais = Países.id_pais
INNER JOIN 
    Pago ON Usuario.id_usuario = Pago.id_usuario
INNER JOIN 
    Metodo_de_pago ON Pago.id_metodo_pago = Metodo_de_pago.id_metodo_pago
INNER JOIN 
    Cursos ON Cursos.id_curso = Pago.id_usuario
INNER JOIN 
    Tipo_de_usuario ON Usuario.id_tipo_de_usuario = Tipo_de_usuario.id_tipo_de_usuario
INNER JOIN 
    Tipo_inscripcion ON Usuario.id_tipo_de_usuario = Tipo_inscripcion.id_inscripcion
ORDER BY 
    Usuario.nombre_usuario;
