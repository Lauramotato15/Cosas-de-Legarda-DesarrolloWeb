CREATE DATABASE salonEstudiantes; 
USE salonEstudiantes; 

CREATE TABLE estudiantes(
  id_estudiante CHAR(5) PRIMARY KEY,
  nombre_estudiante VARCHAR(100),
  nota_final FLOAT 
);

CREATE TABLE prueba(
  id_prueba INT AUTO_INCREMENT PRIMARY KEY,
  nombre_prueba VARCHAR(100),
  porcentaje FLOAT 
);

CREATE TABLE notas(
  id_prueba INT,
  id_estudiante CHAR(5),
  FOREIGN KEY(id_prueba) REFERENCES prueba(id_prueba),
  FOREIGN KEY(id_estudiante) REFERENCES estudiantes(id_estudiante), 
  PRIMARY KEY(id_estudiante,id_prueba),
  nota FLOAT 
);


INSERT INTO estudiantes VALUES ('E0001', 'Juan Perez', 85.5);
INSERT INTO estudiantes VALUES ('E0002', 'Maria Lopez', 92.3);
INSERT INTO estudiantes VALUES ('E0003', 'Carlos Ramirez', 78.9);
INSERT INTO estudiantes VALUES ('E0004', 'Ana Martinez', 88.0);

INSERT INTO prueba (  id_prueba,nombre_prueba, porcentaje) VALUES (1,'Examen 1', 20.0);
INSERT INTO prueba (  id_prueba,nombre_prueba, porcentaje) VALUES (2,'Examen 2', 25.0);
INSERT INTO prueba (  id_prueba,nombre_prueba, porcentaje) VALUES (3,'Proyecto', 30.0);
INSERT INTO prueba (  id_prueba,nombre_prueba, porcentaje) VALUES (4,'Tarea', 25.0);


INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (1,'E0001', 2.0);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (3,'E0001', 5.0);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (2,'E0003', 4.0);
,
INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (4,'E0001', 2.5);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (1,'E0002', 3.4);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (1,'E0002', 2.0);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (2,'E0002', 1.8);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (4,'E0004', 4.1);

INSERT INTO notas (id_prueba, id_estudiante, nota) VALUES (3,'E0003', 2.7);


DELIMITER // 
CREATE TRIGGER pruebaBI BEFORE INSERT ON prueba 
FOR EACH ROW
BEGIN 
  DECLARE v_sumPorcentaje FLOAT; 
  SET v_sumPorcentaje = (SELECT SUM(porcentaje) FROM prueba);

  IF(v_sumPorcentaje + NEW.porcentaje) > 100 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo insertar, el porcentaje excedie el limite';    
  END IF;
END; 
//
DELIMITER ;


DELIMITER // 
CREATE TRIGGER notasBI BEFORE INSERT ON notas 
FOR EACH ROW
BEGIN 
  IF(NEW.nota < 0.0 OR NEW.nota > 5.0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo insertar la nota del estudiante';    
  END IF;
END; 
//
DELIMITER ;

DROP TRIGGER notasAI//

DELIMITER // 
CREATE TRIGGER notasAI AFTER INSERT ON notas 
FOR EACH ROW
BEGIN 
  DECLARE v_sumarPorcentaje FLOAT; 
  SET v_sumarPorcentaje = (SELECT SUM(notas.nota * prueba.porcentaje / 100) FROM prueba 
  JOIN notas ON prueba.id_prueba = notas.id_prueba
  JOIN estudiantes ON notas.id_estudiante = NEW.id_estudiante);

  UPDATE estudiantes SET nota_final = v_sumarPorcentajePorcentaje WHERE id_estudiante = NEW.id_estudiante;
END; 
//
DELIMITER ;


DELIMITER // 
CREATE TRIGGER notasAU AFTER UPDATE ON notas 
FOR EACH ROW
BEGIN 
  DECLARE v_Porcentaje FLOAT; 
  SET v_Porcentaje = (SELECT SUM(notas.nota * prueba.porcentaje / 100) FROM prueba 
  JOIN notas ON prueba.id_prueba = notas.id_prueba
  WHERE notas.id_estudiante = NEW.id_estudiante);

  UPDATE estudiante set nota_final = v_Porcentaje;
END; 
//
DELIMITER ;


DELIMITER // 
CREATE TRIGGER notasBU BEFORE UPDATE ON notas 
FOR EACH ROW
  SET nota = NEW.nota WHERE id_estudiante = NEW.id_estudiante AND id_prueba = NEW.id_prueba;
//
DELIMITER ;

