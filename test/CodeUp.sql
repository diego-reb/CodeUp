
USE CodeUp;
SHOW DATABASES;

CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    tipo_usuario ENUM('estudiante', 'profesor') NOT NULL
);

CREATE TABLE Profesores (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100),
    experiencia INT CHECK (experiencia >= 0),
    id_usuario INT UNIQUE REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Cursos (
    id_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel ENUM('básico', 'intermedio', 'avanzado') NOT NULL,
    costo DECIMAL(10, 2) CHECK (costo >= 0)
);

CREATE TABLE Clases (
    id_clase SERIAL PRIMARY KEY,
    id_curso INT NOT NULL REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    id_profesor INT REFERENCES Profesores(id_profesor) ON DELETE SET NULL,
    nombre VARCHAR(100) NOT NULL,
    contenido TEXT,
    fecha DATE
);

CREATE TABLE Inscripciones (
    id_inscripcion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT NOT NULL REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE
);


CREATE TABLE Pagos (
    id_pago SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT NOT NULL REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    monto DECIMAL(10, 2) CHECK (monto >= 0),
    fecha_pago DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Progreso (
    id_progreso SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT NOT NULL REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    porcentaje_completado DECIMAL(5, 2) CHECK (porcentaje_completado >= 0 AND porcentaje_completado <= 100)
);

SHOW TABLES;