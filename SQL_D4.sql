-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pc_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pc_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pc_db` DEFAULT CHARACTER SET utf8 ;
USE `pc_db` ;

-- -----------------------------------------------------
-- Table `pc_db`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`persona` (
  `idpersona` INT NOT NULL,
  `dni` INT(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `edad` TINYINT(3) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`domicilio` (
  `iddomicilio` INT NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `departamento` VARCHAR(45) NOT NULL,
  `altura` SMALLINT(5) NOT NULL,
  `domiciliocol` VARCHAR(45) NOT NULL,
  `domiciliocol1` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`iddomicilio`, `persona_idpersona`),
  INDEX `fk_domicilio_persona_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`educacion` (
  `educacion` INT NOT NULL,
  `establecimiento` VARCHAR(45) NOT NULL,
  `nivel_educ` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egr` DATE NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`educacion`, `persona_idpersona`),
  INDEX `fk_educacion_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`experiencia_laboral` (
  `experiencia_laboral` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egr` DATE NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `experiencia_laboralcol` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`experiencia_laboral`, `persona_idpersona`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`usuarios` (
  `idusuario` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `persona_idpersona`),
  INDEX `fk_usuarios_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`proyectos` (
  `idproyectos` INT NOT NULL,
  `nombre_proyecto` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  `descripcion` LONGTEXT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idproyectos`, `persona_idpersona`),
  INDEX `fk_proyectos_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyectos_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`hard&soft_skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`hard&soft_skills` (
  `hard&soft_skills` INT NOT NULL,
  `tecnologia` VARCHAR(45) NULL,
  `nivel` VARCHAR(45) NULL,
  `img_logo` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`hard&soft_skills`, `persona_idpersona`),
  INDEX `fk_hard&soft_skills_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_hard&soft_skills_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `pc_db`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`roles` (
  `idroles` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idroles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pc_db`.`roles_has_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pc_db`.`roles_has_usuarios` (
  `roles_idroles` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  `usuarios_persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`roles_idroles`, `usuarios_idusuario`, `usuarios_persona_idpersona`),
  INDEX `fk_roles_has_usuarios_usuarios1_idx` (`usuarios_idusuario` ASC, `usuarios_persona_idpersona` ASC) VISIBLE,
  INDEX `fk_roles_has_usuarios_roles1_idx` (`roles_idroles` ASC) VISIBLE,
  CONSTRAINT `fk_roles_has_usuarios_roles1`
    FOREIGN KEY (`roles_idroles`)
    REFERENCES `pc_db`.`roles` (`idroles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuario` , `usuarios_persona_idpersona`)
    REFERENCES `pc_db`.`usuarios` (`idusuario` , `persona_idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
