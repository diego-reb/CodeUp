CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    tipo_usuario VARCHAR(50) CHECK (tipo_usuario IN ('estudiante', 'profesor'))
);

CREATE TABLE Profesores (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100),
    experiencia INT CHECK (experiencia >= 0),
    id_usuario INT REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Cursos (
    id_curso SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel VARCHAR(50) CHECK (nivel IN ('básico', 'intermedio', 'avanzado')),
    costo DECIMAL(10, 2) CHECK (costo >= 0)
);

CREATE TABLE Clases (
    id_clase SERIAL PRIMARY KEY,
    id_curso INT REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    id_profesor INT REFERENCES Profesores(id_profesor),
    nombre VARCHAR(100) NOT NULL,
    contenido TEXT,
    fecha DATE
);

CREATE TABLE Inscripciones (
    id_inscripcion SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Pagos (
    id_pago SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    monto DECIMAL(10, 2) CHECK (monto >= 0),
    fecha_pago DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Porcentaje (
    id_porcentaje SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_curso INT REFERENCES Cursos(id_curso) ON DELETE CASCADE,
    porcentaje_completado DECIMAL(5, 2) CHECK (porcentaje_completado >= 0 AND porcentaje_completado <= 100)
);

SELECT inet_server_addr() AS ip_address;
SHOW listen_addresses;


SELECT 
    Usuarios.nombre AS usuario,
    Cursos.nombre AS curso,
    Profesores.nombre AS profesor,
    Porcentaje.porcentaje_completado AS avance
FROM 
    Inscripciones
JOIN 
    Usuarios ON Inscripciones.id_usuario = Usuarios.id_usuario
JOIN 
    Cursos ON Inscripciones.id_curso = Cursos.id_curso
JOIN 
    Porcentaje ON Usuarios.id_usuario = Porcentaje.id_usuario AND Cursos.id_curso = Porcentaje.id_curso
JOIN 
    Clases ON Clases.id_curso = Cursos.id_curso
JOIN 
    Profesores ON Clases.id_profesor = Profesores.id_profesor
ORDER BY 
    Usuarios.nombre;
