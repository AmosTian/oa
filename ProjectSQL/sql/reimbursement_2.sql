-- MySQL Script generated by MySQL Workbench
-- Sun Nov 13 12:09:54 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reimbursement_2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reimbursement_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reimbursement_2` DEFAULT CHARACTER SET utf8 ;
USE `reimbursement_2` ;

-- -----------------------------------------------------
-- Table `reimbursement_2`.`Administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Administrator` (
  `uid` VARCHAR(10) NOT NULL,
  `uname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `tel` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Department` (
  `did` INT NOT NULL,
  `dname` VARCHAR(20) NULL,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`did`),
  INDEX `fk_department_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_department_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`InpetientRatio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`InpetientRatio` (
  `rid` INT NOT NULL,
  `ratioList` VARCHAR(45) NOT NULL,
  `quotaList` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Employee` (
  `uid` VARCHAR(10) NOT NULL,
  `uname` VARCHAR(20) NOT NULL,
  `IDcard` VARCHAR(18) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `sex` TINYINT NOT NULL,
  `age` INT NOT NULL,
  `tel` VARCHAR(11) NOT NULL,
  `category` INT NOT NULL,
  `area` VARCHAR(45) NULL,
  `month_re` FLOAT NULL,
  `annual_re` FLOAT NULL,
  `Department_did` INT NOT NULL,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  `Ratio_rid` INT NOT NULL,
  PRIMARY KEY (`uid`),
  INDEX `fk_Employee_department_idx` (`Department_did` ASC) VISIBLE,
  INDEX `fk_Employee_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  INDEX `fk_Employee_Ratio1_idx` (`Ratio_rid` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_department`
    FOREIGN KEY (`Department_did`)
    REFERENCES `reimbursement_2`.`Department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Ratio1`
    FOREIGN KEY (`Ratio_rid`)
    REFERENCES `reimbursement_2`.`InpetientRatio` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Auditor` (
  `uid` VARCHAR(10) NOT NULL,
  `uname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `tel` VARCHAR(11) NOT NULL,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`uid`),
  INDEX `fk_Auditor_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Auditor_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`CreditCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`CreditCard` (
  `cid` VARCHAR(19) NOT NULL,
  `cname` VARCHAR(10) NOT NULL,
  `cbank` VARCHAR(45) NOT NULL,
  `Employee_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`cid`, `cname`, `cbank`),
  INDEX `fk_creditcard_Employee1_idx` (`Employee_uid` ASC) VISIBLE,
  CONSTRAINT `fk_creditcard_Employee1`
    FOREIGN KEY (`Employee_uid`)
    REFERENCES `reimbursement_2`.`Employee` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`REform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`REform` (
  `rid` VARCHAR(20) NOT NULL,
  `state` INT NOT NULL,
  `submitDate` DATETIME NOT NULL,
  `updateDate` DATETIME NOT NULL,
  `amount_total` FLOAT NULL,
  `feedback` VARCHAR(45) NULL,
  `complaint` VARCHAR(45) NULL,
  `Auditor_uid` VARCHAR(10) NOT NULL,
  `CreditCard_cid` VARCHAR(19) NOT NULL,
  PRIMARY KEY (`rid`),
  INDEX `fk_REform_Auditor1_idx` (`Auditor_uid` ASC) VISIBLE,
  INDEX `fk_REform_creditcard1_idx` (`CreditCard_cid` ASC) VISIBLE,
  CONSTRAINT `fk_REform_Auditor1`
    FOREIGN KEY (`Auditor_uid`)
    REFERENCES `reimbursement_2`.`Auditor` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REform_creditcard1`
    FOREIGN KEY (`CreditCard_cid`)
    REFERENCES `reimbursement_2`.`CreditCard` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Drug` (
  `drid` VARCHAR(20) NOT NULL,
  `drname` VARCHAR(45) NOT NULL,
  `drprice` FLOAT NOT NULL,
  `drtype` TINYINT NOT NULL,
  `drratio` FLOAT NULL,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  `AdminTime` DATETIME NOT NULL,
  PRIMARY KEY (`drid`, `drname`),
  INDEX `fk_drug_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_drug_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Druglist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Druglist` (
  `id` INT NOT NULL,
  `amount_drug` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Druglist_has_Drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Druglist_has_Drug` (
  `druglist_id` INT NOT NULL,
  `drug_drid` VARCHAR(20) NOT NULL,
  `drug_drname` VARCHAR(45) NOT NULL,
  `drug_num` INT NOT NULL,
  PRIMARY KEY (`druglist_id`, `drug_drid`, `drug_drname`),
  INDEX `fk_druglist_has_drug_drug1_idx` (`drug_drid` ASC, `drug_drname` ASC) VISIBLE,
  INDEX `fk_druglist_has_drug_druglist1_idx` (`druglist_id` ASC) VISIBLE,
  CONSTRAINT `fk_druglist_has_drug_druglist1`
    FOREIGN KEY (`druglist_id`)
    REFERENCES `reimbursement_2`.`Druglist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_druglist_has_drug_drug1`
    FOREIGN KEY (`drug_drid` , `drug_drname`)
    REFERENCES `reimbursement_2`.`Drug` (`drid` , `drname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Hospital` (
  `hid` INT NOT NULL,
  `hname` VARCHAR(45) NOT NULL,
  `htype` TINYINT NOT NULL,
  PRIMARY KEY (`hid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`TRANSform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`TRANSform` (
  `tid` INT NOT NULL,
  `Hospital_hid` INT NOT NULL,
  PRIMARY KEY (`tid`),
  INDEX `fk_TRANSform_hospital1_idx` (`Hospital_hid` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSform_hospital1`
    FOREIGN KEY (`Hospital_hid`)
    REFERENCES `reimbursement_2`.`Hospital` (`hid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`INVOICEform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`INVOICEform` (
  `iid` VARCHAR(20) NOT NULL,
  `Employee_uid` VARCHAR(10) NOT NULL,
  `date` DATETIME NOT NULL,
  `Hospital_hid` INT NOT NULL,
  `hospitaldepartment` VARCHAR(20) NOT NULL,
  `Druglist_id` INT NOT NULL,
  `WhetherDesignated` TINYINT NOT NULL,
  `TRANSform_tid` INT NULL,
  `transformImgURL` VARCHAR(45) NULL,
  `billImgURL` VARCHAR(45) NULL,
  `prescriptionImgURL` VARCHAR(45) NULL,
  `instructions` VARCHAR(45) NULL,
  `REform_rid` VARCHAR(20) NOT NULL,
  `amount_medicine` FLOAT NULL,
  `MS_type` TINYINT NOT NULL,
  `amount_MS` FLOAT NULL,
  `amount_inpatient` FLOAT NULL,
  PRIMARY KEY (`iid`),
  INDEX `fk_INVOICEform_Employee1_idx` (`Employee_uid` ASC) VISIBLE,
  INDEX `fk_INVOICEform_druglist1_idx` (`Druglist_id` ASC) VISIBLE,
  INDEX `fk_INVOICEform_TRANSform1_idx` (`TRANSform_tid` ASC) VISIBLE,
  INDEX `fk_INVOICEform_REform1_idx` (`REform_rid` ASC) VISIBLE,
  INDEX `fk_INVOICEform_hospital1_idx` (`Hospital_hid` ASC) VISIBLE,
  CONSTRAINT `fk_INVOICEform_Employee1`
    FOREIGN KEY (`Employee_uid`)
    REFERENCES `reimbursement_2`.`Employee` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVOICEform_druglist1`
    FOREIGN KEY (`Druglist_id`)
    REFERENCES `reimbursement_2`.`Druglist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVOICEform_TRANSform1`
    FOREIGN KEY (`TRANSform_tid`)
    REFERENCES `reimbursement_2`.`TRANSform` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVOICEform_REform1`
    FOREIGN KEY (`REform_rid`)
    REFERENCES `reimbursement_2`.`REform` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVOICEform_hospital1`
    FOREIGN KEY (`Hospital_hid`)
    REFERENCES `reimbursement_2`.`Hospital` (`hid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Notice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Notice` (
  `nid` INT NOT NULL,
  `ntitle` VARCHAR(45) NOT NULL,
  `ncontent` VARCHAR(45) NULL,
  `nTime` DATETIME NOT NULL,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`nid`),
  INDEX `fk_Notice_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Notice_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
