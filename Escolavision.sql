CREATE TABLE area (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre TEXT NOT NULL,
    descripción TEXT,
    logo varchar(10000)
);

CREATE TABLE test (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombretest TEXT NOT NULL
);

CREATE TABLE profesor (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    dni VARCHAR(100) NOT NULL UNIQUE,
    foto varchar(10000),
    idarea BIGINT,
    claveaccesoprof TEXT NOT NULL,
    CONSTRAINT fk_area FOREIGN KEY (idarea) REFERENCES area(id)
);


CREATE TABLE alumno (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    foto varchar(10000),
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    dni VARCHAR(100) NOT NULL UNIQUE,
    claveaccesoalum TEXT NOT NULL,
    idprofesor BIGINT,
    CONSTRAINT fk_profesor FOREIGN KEY (idprofesor) REFERENCES profesor(id)
);


CREATE TABLE pregunta (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    idtest BIGINT,
    enunciado TEXT NOT NULL,
    CONSTRAINT fk_test FOREIGN KEY (idtest) REFERENCES test(id)
);

CREATE TABLE pxa (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    idpregunta BIGINT,
    idarea BIGINT,
    CONSTRAINT fk_pregunta_pxa FOREIGN KEY (idpregunta) REFERENCES pregunta(id),
    CONSTRAINT fk_area_pxa FOREIGN KEY (idarea) REFERENCES area(id)
);


CREATE TABLE intentos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    idtest BIGINT,
    idalumno BIGINT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    resultados TEXT,
    CONSTRAINT fk_test_intentos FOREIGN KEY (idtest) REFERENCES test(id),
    CONSTRAINT fk_alumno_intentos FOREIGN KEY (idalumno) REFERENCES alumno(id)
);

