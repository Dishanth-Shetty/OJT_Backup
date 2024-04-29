-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aarogya_healthcare_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aarogya_healthcare_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aarogya_healthcare_db` DEFAULT CHARACTER SET utf8 ;
USE `aarogya_healthcare_db` ;

-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`registered_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`registered_users` (
  `email_address` VARCHAR(100) NOT NULL,
  `fIrst_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `phone_num` BIGINT(12) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`email_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`registered_admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`registered_admins` (
  `email_address` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `phone_num` BIGINT(12) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `admin_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`email_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`registered_doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`registered_doctors` (
  `email_address` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `phone_num` BIGINT(12) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `department` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`email_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`query_records`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`query_records` (
  `query_id` INT NOT NULL AUTO_INCREMENT,
  `email_address` VARCHAR(100) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `subject` VARCHAR(50) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `message_status` VARCHAR(20) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`query_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`appointment_records`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`appointment_records` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `appointment_date` DATE NOT NULL,
  `appointment_time` TIME NOT NULL,
  `appointment_type` VARCHAR(100) NOT NULL,
  `appointment_status` VARCHAR(20) NOT NULL,
  `registered_users_email_address` VARCHAR(100) NULL,
  `registered_doctors_email_address` VARCHAR(100) NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `fk_appointment_records_registered_users_idx` (`registered_users_email_address` ASC) VISIBLE,
  INDEX `fk_appointment_records_registered_doctors1_idx` (`registered_doctors_email_address` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_records_registered_users`
    FOREIGN KEY (`registered_users_email_address`)
    REFERENCES `aarogya_healthcare_db`.`registered_users` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_records_registered_doctors1`
    FOREIGN KEY (`registered_doctors_email_address`)
    REFERENCES `aarogya_healthcare_db`.`registered_doctors` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`prescription` (
  `prescription_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `diagnosis` VARCHAR(255) NOT NULL,
  `medication_info` VARCHAR(255) NOT NULL,
  `refill` INT NOT NULL,
  `instructions` VARCHAR(255) NOT NULL,
  `appointment_records_appointment_id` INT NULL,
  `registered_doctors_email_address` VARCHAR(100) NULL,
  `registered_users_email_address` VARCHAR(100) NULL,
  PRIMARY KEY (`prescription_id`),
  INDEX `fk_prescription_appointment_records1_idx` (`appointment_records_appointment_id` ASC) VISIBLE,
  INDEX `fk_prescription_registered_doctors1_idx` (`registered_doctors_email_address` ASC) VISIBLE,
  INDEX `fk_prescription_registered_users1_idx` (`registered_users_email_address` ASC) VISIBLE,
  CONSTRAINT `fk_prescription_appointment_records1`
    FOREIGN KEY (`appointment_records_appointment_id`)
    REFERENCES `aarogya_healthcare_db`.`appointment_records` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_registered_doctors1`
    FOREIGN KEY (`registered_doctors_email_address`)
    REFERENCES `aarogya_healthcare_db`.`registered_doctors` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_registered_users1`
    FOREIGN KEY (`registered_users_email_address`)
    REFERENCES `aarogya_healthcare_db`.`registered_users` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aarogya_healthcare_db`.`admin_email_credentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aarogya_healthcare_db`.`admin_email_credentials` (
  `email_address` VARCHAR(100) NOT NULL,
  `email_password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`email_address`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
