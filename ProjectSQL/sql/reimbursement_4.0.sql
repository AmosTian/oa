-- MySQL Script generated by MySQL Workbench
-- Sun Nov 13 20:11:01 2022
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
  `uid` VARCHAR(10) NOT NULL DEFAULT 'A1001',
  `uname` VARCHAR(20) NOT NULL DEFAULT '韩梅梅',
  `password` VARCHAR(16) NOT NULL DEFAULT '123456',
  `tel` VARCHAR(11) NOT NULL DEFAULT '13012345678',
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Department` (
  `did` INT NOT NULL AUTO_INCREMENT,
  `dname` VARCHAR(20) NOT NULL DEFAULT '研究生院',
  `Administrator_uid` VARCHAR(10) NOT NULL DEFAULT 'A1001',
  PRIMARY KEY (`did`),
  INDEX `fk_department_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_department_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`InhospitalRatio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`InhospitalRatio` (
  `Inid` TINYINT NOT NULL AUTO_INCREMENT,
  `Intype` VARCHAR(45) NOT NULL DEFAULT '在职人员',
  `Inratio` VARCHAR(45) NOT NULL DEFAULT '0.9-10000-0.94',
  PRIMARY KEY (`Inid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Employee` (
  `uid` VARCHAR(10) NOT NULL DEFAULT 'S22124001',
  `uname` VARCHAR(20) NOT NULL DEFAULT '张三',
  `IDcard` VARCHAR(18) NOT NULL DEFAULT '340202197104106891',
  `password` VARCHAR(16) NOT NULL DEFAULT '123456',
  `sex` VARCHAR(10) NOT NULL DEFAULT '男',
  `age` INT NOT NULL DEFAULT 22,
  `tel` VARCHAR(11) NOT NULL DEFAULT '18812345678',
  `category` INT NOT NULL DEFAULT 1 COMMENT '1为学生，2为在职职工，3为退休人员',
  `ratio` VARCHAR(45) NOT NULL DEFAULT '0.9-10000-0.94',
  `area` VARCHAR(45) NULL DEFAULT '北京市永定路52号院',
  `month_re` FLOAT NULL DEFAULT 0,
  `annual_re` FLOAT NULL DEFAULT 0,
  `Department_did` INT NOT NULL DEFAULT 1,
  `Administrator_uid` VARCHAR(10) NOT NULL DEFAULT 'A1001',
  `InhospitalRatio_Inid` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`uid`),
  INDEX `fk_Employee_department_idx` (`Department_did` ASC) VISIBLE,
  INDEX `fk_Employee_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  INDEX `fk_Employee_InhospitalRatio1_idx` (`InhospitalRatio_Inid` ASC) VISIBLE,
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
  CONSTRAINT `fk_Employee_InhospitalRatio1`
    FOREIGN KEY (`InhospitalRatio_Inid`)
    REFERENCES `reimbursement_2`.`InhospitalRatio` (`Inid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Auditor` (
  `uid` VARCHAR(10) NOT NULL DEFAULT 'X101',
  `uname` VARCHAR(20) NOT NULL DEFAULT '小明',
  `password` VARCHAR(16) NOT NULL DEFAULT '123456',
  `tel` VARCHAR(11) NOT NULL DEFAULT '15900000000',
  `Administrator_uid` VARCHAR(10) NOT NULL DEFAULT 'A1001',
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
  `cid` VARCHAR(19) NOT NULL DEFAULT '6217566211112222333',
  `cname` VARCHAR(10) NOT NULL DEFAULT 'BOC',
  `cbank` VARCHAR(45) NOT NULL DEFAULT '中国银行股份有限公司北京市分行',
  `Employee_uid` VARCHAR(10) NOT NULL DEFAULT 'S22124001',
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
  `rid` VARCHAR(20) NOT NULL DEFAULT '1001200230034004',
  `state` INT NOT NULL DEFAULT 1 COMMENT '四种状态。1为待审核、2为审核通过、3为审核未通过、4为撤销',
  `submitDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount_total` FLOAT NULL DEFAULT 0.0,
  `feedback` VARCHAR(45) NULL DEFAULT '回执回执回执回执回执回执回执回执回执回执回执回执回执回执回执回执回执回执',
  `complaint` VARCHAR(45) NULL DEFAULT '申诉申诉申诉申诉申诉申诉申诉申诉申诉申诉申诉申诉申诉申诉',
  `Auditor_uid` VARCHAR(10) NOT NULL DEFAULT 'X101',
  `CreditCard_cid` VARCHAR(19) NOT NULL DEFAULT '6217566211112222333',
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
  `drid` INT NOT NULL AUTO_INCREMENT,
  `drname` VARCHAR(45) NOT NULL DEFAULT '阿司匹林',
  `drprice` FLOAT NOT NULL DEFAULT 9.9,
  `drtype` TINYINT NOT NULL DEFAULT 2 COMMENT '1为甲类/100%报销，2为乙类/部分报销，3为丙类/零报销',
  `drratio` FLOAT NOT NULL DEFAULT 0.6,
  `Administrator_uid` VARCHAR(10) NOT NULL,
  `AdminTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`drid`),
  INDEX `fk_Drug_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Drug_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Druglist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Druglist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount_drug` FLOAT NULL DEFAULT 0.0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`MedicalService`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`MedicalService` (
  `MSid` INT NOT NULL AUTO_INCREMENT,
  `ratioOutpatient` VARCHAR(20) NOT NULL DEFAULT 0.9,
  `ratioDeputy` FLOAT NOT NULL DEFAULT 0.5,
  `ratioChief` FLOAT NOT NULL DEFAULT 0.33,
  `ratioExpert` FLOAT NOT NULL DEFAULT 0.25,
  `ratioEmergency` FLOAT NOT NULL DEFAULT 0.95,
  PRIMARY KEY (`MSid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Hospital` (
  `hid` INT NOT NULL AUTO_INCREMENT,
  `hname` VARCHAR(45) NOT NULL DEFAULT '解放军人民总医院',
  `MedicalService_MSid` INT NOT NULL,
  PRIMARY KEY (`hid`),
  INDEX `fk_Hospital_MedicalService1_idx` (`MedicalService_MSid` ASC) VISIBLE,
  CONSTRAINT `fk_Hospital_MedicalService1`
    FOREIGN KEY (`MedicalService_MSid`)
    REFERENCES `reimbursement_2`.`MedicalService` (`MSid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`TRANSform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`TRANSform` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  `Hospital_hid` INT NOT NULL DEFAULT 1,
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
  `iid` VARCHAR(20) NOT NULL DEFAULT '401709820402',
  `Employee_uid` VARCHAR(10) NOT NULL DEFAULT 'S22124001',
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Hospital_hid` INT NOT NULL DEFAULT 1,
  `hospitaldepartment` VARCHAR(20) NOT NULL DEFAULT '外科',
  `Druglist_id` INT NOT NULL DEFAULT 1,
  `WhetherDesignated` TINYINT NOT NULL DEFAULT 1 COMMENT '1为非定点医院需转诊，0为定点',
  `TRANSform_tid` INT NULL DEFAULT 1,
  `transformImgURL` VARCHAR(45) NULL DEFAULT 'HTTP:URL1',
  `billImgURL` VARCHAR(45) NULL DEFAULT 'HTTP:URL2',
  `prescriptionImgURL` VARCHAR(45) NULL DEFAULT 'HTTP:URL3',
  `instructions` VARCHAR(45) NULL DEFAULT '备注备注备注备注备注备注备注备注备注',
  `REform_rid` VARCHAR(20) NOT NULL DEFAULT '1',
  `amount_medicine` FLOAT NULL DEFAULT 45.0,
  `amount_MS` FLOAT NULL DEFAULT 100.0,
  `amount_inpatient` FLOAT NULL DEFAULT 1000.0,
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
  `nid` INT NOT NULL DEFAULT 1,
  `ntitle` VARCHAR(45) NOT NULL DEFAULT '公告1',
  `ncontent` VARCHAR(45) NULL DEFAULT '内容内容内容内容内容内容内容内容',
  `nTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Administrator_uid` VARCHAR(10) NOT NULL DEFAULT 'A1001',
  PRIMARY KEY (`nid`),
  INDEX `fk_Notice_Administrator1_idx` (`Administrator_uid` ASC) VISIBLE,
  CONSTRAINT `fk_Notice_Administrator1`
    FOREIGN KEY (`Administrator_uid`)
    REFERENCES `reimbursement_2`.`Administrator` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reimbursement_2`.`Druglist_has_Drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reimbursement_2`.`Druglist_has_Drug` (
  `Druglist_id` INT NOT NULL DEFAULT 1,
  `Drug_drid` INT NOT NULL DEFAULT 1,
  `drug_num` INT NOT NULL DEFAULT 3,
  PRIMARY KEY (`Druglist_id`, `Drug_drid`),
  INDEX `fk_Druglist_has_Drug_Drug1_idx` (`Drug_drid` ASC) VISIBLE,
  INDEX `fk_Druglist_has_Drug_Druglist1_idx` (`Druglist_id` ASC) VISIBLE,
  CONSTRAINT `fk_Druglist_has_Drug_Druglist1`
    FOREIGN KEY (`Druglist_id`)
    REFERENCES `reimbursement_2`.`Druglist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Druglist_has_Drug_Drug1`
    FOREIGN KEY (`Drug_drid`)
    REFERENCES `reimbursement_2`.`Drug` (`drid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
