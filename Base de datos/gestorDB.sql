DROP DATABASE IF EXISTS gestor;
CREATE DATABASE gestor CHARACTER SET utf8mb4;
USE gestor;

/*Creando tabla categorias*/
CREATE TABLE categorias (
  idCategoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  categoria VARCHAR (30)
);


/*Insertando datos a tabla marcas*/
insert into categorias(categoria)
values('Logica de programacion'),
	   ('Flutter'),
      ('Node.js'),
      ('Java'),
      ('Python'),
      ('MySQL');
      
insert into categorias(categoria)
values('PHP');
      
      
 /*Creando tabla tutoriales*/     
CREATE TABLE tutoriales (
  idTutorial INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  prioridad INT NOT NULL,
  url TEXT NOT NULL,
  estado ENUM('Revisado', 'Por revisar') DEFAULT 'Por revisar', -- Columna para el estado del tutorial
  idCategoria INT NOT NULL,
  FOREIGN KEY (idCategoria) REFERENCES categorias(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Insertando datos de prueba en la tabla de tutoriales */
INSERT INTO tutoriales (titulo, prioridad, url, idCategoria) 
VALUES ('Introducción a la lógica de programación', 9, 'https://www.hostgator.mx/blog/logica-de-programacion-primer-paso/', 1),
       ('Desarrollo de aplicaciones con Flutter', 7, 'https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=es-419#0', 2);




/* .............Creacion de procedimientos............ */

 /*Creando procedimiento de insercion de tutoriales*/   

DELIMITER //
CREATE PROCEDURE InsertarTutorial (
    IN p_titulo VARCHAR(100),
    IN p_prioridad INT,
    IN p_url TEXT,
    IN p_idCategoria INT
)
BEGIN
    INSERT INTO tutoriales (titulo, prioridad, url, idCategoria)
    VALUES (p_titulo, p_prioridad, p_url, p_idCategoria);
END //
DELIMITER ;

 /*Creando procedimiento de eliminacion de tutoriales*/   
DELIMITER //
CREATE PROCEDURE eliminarTutorial (
    IN p_idTutorial INT
)
BEGIN
    DELETE FROM tutoriales WHERE idTutorial = p_idTutorial;
END //
DELIMITER ;

DELIMITER //

 /*Creando procedimiento edicion de tutoriales*/   
DELIMITER //
CREATE PROCEDURE editarTutorial (

    IN p_idTutorial INT,
    IN p_titulo VARCHAR(100),
    IN p_prioridad INT,
    IN p_url TEXT,
    IN p_idCategoria INT
)
BEGIN
    UPDATE tutoriales
    SET titulo = p_titulo,
        prioridad = p_prioridad,
        url = p_url,
        idCategoria = p_idCategoria
    WHERE idTutorial = p_idTutorial;
END //
DELIMITER ;


 /*Creando procedimiento de insercion de categorias*/   
DELIMITER //
CREATE PROCEDURE InsertarCategoria (
    IN p_categoria VARCHAR(30)
)
BEGIN
    INSERT INTO categorias (categoria)
    VALUES (p_categoria);
END //
DELIMITER ;

 /*Creando procedimiento de eliminacion de categorias*/   
DELIMITER //
CREATE PROCEDURE eliminarCategoria (
    IN p_idCategoria INT
)
BEGIN
    DELETE FROM categorias WHERE idCategoria = p_idCategoria;
END //
DELIMITER ;

 /*Creando procedimiento de edicion de categorias (El nombre de estas)*/   
DELIMITER //

CREATE PROCEDURE editarCategoria (
    IN p_idCategoria INT,
    IN p_nuevoNombre VARCHAR(30)
)
BEGIN
    UPDATE categorias 
    SET categoria = p_nuevoNombre
    WHERE idCategoria = p_idCategoria;
END //

DELIMITER ;



 /*Dato de prueba para editar o eliminar*/   
INSERT INTO tutoriales (titulo, prioridad, url, idCategoria) 
VALUES ('I am error', 1, 'https://es.wikipedia.org/wiki/I_am_Error', 1);


