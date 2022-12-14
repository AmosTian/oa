-- MySQL Script generated by MySQL Workbench
-- Mon Oct  3 13:37:47 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reimbursement
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reimbursement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reimbursement` DEFAULT CHARACTER SET utf8 ;
USE `reimbursement` ;

-- -----------------------------------------------------
-- Table `reimbursement`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Department` (
  `Did` INT NOT NULL,
  `DName` VARCHAR(20) NULL,
  PRIMARY KEY (`Did`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Employee` (
  `uid` VARCHAR(10) NOT NULL,
  `uname` VARCHAR(10) NULL,
  `pwd` VARCHAR(16) NULL,
  `Level` INT NULL,
  `Email` VARCHAR(45) NULL,
  `Tel` BIGINT(11) NULL,
  `department_Did` INT NOT NULL,
  PRIMARY KEY (`uid`),
  INDEX `fk_Employee_department_idx` (`department_Did` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_department`
    FOREIGN KEY (`department_Did`)
    REFERENCES `reimbursement`.`Department` (`Did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`CreditCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`CreditCard` (
  `CardNo` BIGINT(19) NOT NULL,
  `BankName` VARCHAR(10) NOT NULL,
  `AccountBank` VARCHAR(45) NOT NULL,
  `Employee_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CardNo`, `BankName`, `AccountBank`),
  INDEX `fk_CreditCard_Employee1_idx` (`Employee_uid` ASC) VISIBLE,
  CONSTRAINT `fk_CreditCard_Employee1`
    FOREIGN KEY (`Employee_uid`)
    REFERENCES `reimbursement`.`Employee` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Auditor` (
  `uid` INT NOT NULL,
  `uname` VARCHAR(10) NULL,
  `pwd` VARCHAR(16) NULL,
  `Tcl` BIGINT(11) NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Form`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Form` (
  `Fid` INT NOT NULL,
  `type` VARCHAR(2) NULL,
  `date` DATE NOT NULL,
  `amount` FLOAT NULL,
  `note` VARCHAR(45) NULL,
  `CreditCard_CardNo` BIGINT(19) NOT NULL,
  `CreditCard_BankName` VARCHAR(10) NOT NULL,
  `CreditCard_AccountBank` VARCHAR(45) NOT NULL,
  `Auditor_uid` INT NOT NULL,
  PRIMARY KEY (`Fid`, `date`),
  INDEX `fk_Form_CreditCard1_idx` (`CreditCard_CardNo` ASC, `CreditCard_BankName` ASC, `CreditCard_AccountBank` ASC) VISIBLE,
  INDEX `fk_Form_Auditor1_idx` (`Auditor_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Form_CreditCard1`
    FOREIGN KEY (`CreditCard_CardNo` , `CreditCard_BankName` , `CreditCard_AccountBank`)
    REFERENCES `reimbursement`.`CreditCard` (`CardNo` , `BankName` , `AccountBank`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Form_Auditor1`
    FOREIGN KEY (`Auditor_uid`)
    REFERENCES `reimbursement`.`Auditor` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Administrant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Administrant` (
  `uid` INT NOT NULL,
  `uname` VARCHAR(10) NULL,
  `pwd` VARCHAR(16) NULL,
  `Tcl` BIGINT(11) NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Administrant_manage_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Administrant_manage_Employee` (
  `Administrant_uid` INT NOT NULL,
  `Employee_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Administrant_uid`, `Employee_uid`),
  INDEX `fk_Administrant_has_Employee_Employee1_idx` (`Employee_uid` ASC) VISIBLE,
  INDEX `fk_Administrant_has_Employee_Administrant1_idx` (`Administrant_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Administrant_has_Employee_Administrant1`
    FOREIGN KEY (`Administrant_uid`)
    REFERENCES `reimbursement`.`Administrant` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrant_has_Employee_Employee1`
    FOREIGN KEY (`Employee_uid`)
    REFERENCES `reimbursement`.`Employee` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Administrant_manage_Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Administrant_manage_Department` (
  `Administrant_uid` INT NOT NULL,
  `Department_Did` INT NOT NULL,
  PRIMARY KEY (`Administrant_uid`, `Department_Did`),
  INDEX `fk_Administrant_has_Department_Department1_idx` (`Department_Did` ASC) VISIBLE,
  INDEX `fk_Administrant_has_Department_Administrant1_idx` (`Administrant_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Administrant_has_Department_Administrant1`
    FOREIGN KEY (`Administrant_uid`)
    REFERENCES `reimbursement`.`Administrant` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrant_has_Department_Department1`
    FOREIGN KEY (`Department_Did`)
    REFERENCES `reimbursement`.`Department` (`Did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement`.`Administrant_manage_Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement`.`Administrant_manage_Auditor` (
  `Administrant_uid` INT NOT NULL,
  `Auditor_uid` INT NOT NULL,
  PRIMARY KEY (`Administrant_uid`, `Auditor_uid`),
  INDEX `fk_Administrant_has_Auditor_Auditor1_idx` (`Auditor_uid` ASC) VISIBLE,
  INDEX `fk_Administrant_has_Auditor_Administrant1_idx` (`Administrant_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Administrant_has_Auditor_Administrant1`
    FOREIGN KEY (`Administrant_uid`)
    REFERENCES `reimbursement`.`Administrant` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Administrant_has_Auditor_Auditor1`
    FOREIGN KEY (`Auditor_uid`)
    REFERENCES `reimbursement`.`Auditor` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
