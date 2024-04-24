-- MYSQL WORKBENCH FORWARD ENGINEERING

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- SCHEMA FOURPARKSDATABASE
-- -----------------------------------------------------
DROP DATABASE `FOURPARKSDATABASE`;
CREATE SCHEMA IF NOT EXISTS `FOURPARKSDATABASE` DEFAULT CHARACTER SET UTF8 ;
USE `FOURPARKSDATABASE`;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`DOCUMENTTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`DOCUMENTTYPE` (
  `IDDOCTYPE` VARCHAR(3) NOT NULL,
  `DESCDOCTYPE` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDDOCTYPE`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`USER` (
  `IDUSER` VARCHAR(13) NOT NULL,
  `FIRSTNAME` VARCHAR(45) NOT NULL,
  `LASTNAME` VARCHAR(45) NOT NULL,
  `IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDUSER`, `IDDOCTYPEFK`),
  INDEX `FK_USER_DOCUMENTTYPE_IDX` (`IDDOCTYPEFK` ASC) VISIBLE,
  CONSTRAINT `FK_USER_DOCUMENTTYPE`
    FOREIGN KEY (`IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`DOCUMENTTYPE` (`IDDOCTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CUSTOMERACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CUSTOMERACTION` (
  `IDACTION` INT NOT NULL AUTO_INCREMENT,
  `DESCACTION` VARCHAR(45) NOT NULL,
  `PERSON_IDPERSON` VARCHAR(13) NOT NULL,
  `PERSON_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDACTION`),
  INDEX `FK_ACTION_PERSON_IDX` (`PERSON_IDPERSON` ASC, `PERSON_IDDOCTYPEFK` ASC) VISIBLE,
  CONSTRAINT `FK_ACTION_PERSON`
    FOREIGN KEY (`PERSON_IDPERSON` , `PERSON_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`VEHICLETYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`VEHICLETYPE` (
  `IDVEHICLETYPE` INT NOT NULL AUTO_INCREMENT,
  `DESCVEHICLETYPE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IDVEHICLETYPE`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CITY` (
  `IDCITY` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDCITY`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKINGTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKINGTYPE` (
  `IDPARKINGTYPE` INT NOT NULL,
  `DESCPARKINGTYPE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IDPARKINGTYPE`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`RATE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`RATE` (
  `IDRATE` INT NOT NULL,
  `COSTRATE` INT NOT NULL,
  `VEHICLETYPE_IDVEHICLETYPE` INT NOT NULL,
  `CITY_IDCITY` INT NOT NULL,
  `PARKINGTYPE_IDPARKINGTYPE` INT NOT NULL,
  PRIMARY KEY (`IDRATE`, `VEHICLETYPE_IDVEHICLETYPE`, `CITY_IDCITY`, `PARKINGTYPE_IDPARKINGTYPE`),
  INDEX `FK_RATE_VEHICLETYPE_IDX` (`VEHICLETYPE_IDVEHICLETYPE` ASC) VISIBLE,
  INDEX `FK_RATE_CITY_IDX` (`CITY_IDCITY` ASC) VISIBLE,
  INDEX `FK_RATE_PARKINGTYPE_IDX` (`PARKINGTYPE_IDPARKINGTYPE` ASC) VISIBLE,
  CONSTRAINT `FK_RATE_VEHICLETYPE`
    FOREIGN KEY (`VEHICLETYPE_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RATE_CITY`
    FOREIGN KEY (`CITY_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`CITY` (`IDCITY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RATE_PARKINGTYPE`
    FOREIGN KEY (`PARKINGTYPE_IDPARKINGTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`PARKINGTYPE` (`IDPARKINGTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`SCHEDULE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`SCHEDULE` (
  `IDSCHEDULE` INT NOT NULL,
  `STARTTIME` TIME NULL,
  `ENDTIME` TIME NULL,
  `SCHEDULETYPE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDSCHEDULE`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`VEHICLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`VEHICLE` (
  `IDVEHICLE` VARCHAR(6) NOT NULL,
  `DESCVEHICLE` VARCHAR(20) NULL,
  `VEHICLETYPE_IDVEHICLETYPE` INT NOT NULL,
  PRIMARY KEY (`IDVEHICLE`, `VEHICLETYPE_IDVEHICLETYPE`),
  INDEX `FK_VEHICLE_VEHICLETYPE_IDX` (`VEHICLETYPE_IDVEHICLETYPE` ASC) VISIBLE,
  CONSTRAINT `FK_VEHICLE_VEHICLETYPE`
    FOREIGN KEY (`VEHICLETYPE_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`ADDRESS` (
  `COORDINATESX` FLOAT(10,4) NOT NULL,
  `COORDINATESY` FLOAT(10,4) NOT NULL,
  `DESCADDRESS` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`COORDINATESX`, `COORDINATESY`)
) ENGINE = INNODB;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKING` (
  `IDPARKING` INT NOT NULL AUTO_INCREMENT,
  `NAMEPARK` VARCHAR(45) NOT NULL,
  `CAPACITY` INT NOT NULL,
  `ADDRESS_COORDINATESX` FLOAT(10,4) NOT NULL,
  `ADDRESS_COORDINATESY` FLOAT(10,4) NOT NULL,
  `PARKINGTYPE_IDPARKINGTYPE` INT NOT NULL,
  `PHONE` VARCHAR(10) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  `CITY_IDCITY` INT NOT NULL,
  `SCHEDULE_IDSCHEDULE` INT NOT NULL,
  PRIMARY KEY (`IDPARKING`),
  INDEX `FK_PARKING_PARKINGTYPE_IDX` (`PARKINGTYPE_IDPARKINGTYPE` ASC) VISIBLE,
  INDEX `FK_PARKING_CITY_IDX` (`CITY_IDCITY` ASC) VISIBLE,
  INDEX `FK_PARKING_SCHEDULE_IDX` (`SCHEDULE_IDSCHEDULE` ASC) VISIBLE,
  CONSTRAINT `FK_PARKING_ADDRESS`
    FOREIGN KEY (`ADDRESS_COORDINATESX`, `ADDRESS_COORDINATESY`)
    REFERENCES `FOURPARKSDATABASE`.`ADDRESS` (`COORDINATESX`, `COORDINATESY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKING_PARKINGTYPE`
    FOREIGN KEY (`PARKINGTYPE_IDPARKINGTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`PARKINGTYPE` (`IDPARKINGTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKING_CITY`
    FOREIGN KEY (`CITY_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`CITY` (`IDCITY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKING_SCHEDULE`
    FOREIGN KEY (`SCHEDULE_IDSCHEDULE`)
    REFERENCES `FOURPARKSDATABASE`.`SCHEDULE` (`IDSCHEDULE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`RESERVATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`RESERVATION` (
  `IDRESERVATIONDETAIL` INT NOT NULL,
  `STARTTIMERES` TIME NOT NULL,
  `ENDTIMERES` TIME NOT NULL,
  `RESERVATION_IDRESERVATION` INT NOT NULL,
  `PARKING_IDPARKING` INT NOT NULL,
  `VEHICLE_IDVEHICLE` VARCHAR(6) NOT NULL,
  `VEHICLE_VEHICLETYPE_IDVEHICLETYPE` INT NOT NULL,
  `PERSON_IDPERSON` VARCHAR(13) NOT NULL,
  `PERSON_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  `CREATIONDATERES` DATE NOT NULL,
  `TOTALRES` INT NULL,
  `RATE_IDRATE` INT NOT NULL,
  `RATE_VEHICLETYPE_IDVEHICLETYPE` INT NOT NULL,
  `RATE_CITY_IDCITY` INT NOT NULL,
  PRIMARY KEY (`IDRESERVATIONDETAIL`),
  INDEX `FK_RESERVATION_PARKING_IDX` (`PARKING_IDPARKING` ASC) VISIBLE,
  INDEX `FK_RESERVATION_VEHICLE_IDX` (`VEHICLE_IDVEHICLE` ASC, `VEHICLE_VEHICLETYPE_IDVEHICLETYPE` ASC) VISIBLE,
  INDEX `FK_RESERVATION_PERSON_IDX` (`PERSON_IDPERSON` ASC, `PERSON_IDDOCTYPEFK` ASC) VISIBLE,
  INDEX `FK_RESERVATION_RATE_IDX` (`RATE_IDRATE` ASC, `RATE_VEHICLETYPE_IDVEHICLETYPE` ASC, `RATE_CITY_IDCITY` ASC) VISIBLE,
  CONSTRAINT `FK_RESERVATION_PARKING`
    FOREIGN KEY (`PARKING_IDPARKING`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RESERVATION_VEHICLE`
    FOREIGN KEY (`VEHICLE_IDVEHICLE` , `VEHICLE_VEHICLETYPE_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLE` (`IDVEHICLE` , `VEHICLETYPE_IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RESERVATION_PERSON`
    FOREIGN KEY (`PERSON_IDPERSON` , `PERSON_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RESERVATION_RATE`
    FOREIGN KEY (`RATE_IDRATE` , `RATE_VEHICLETYPE_IDVEHICLETYPE` , `RATE_CITY_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`RATE` (`IDRATE` , `VEHICLETYPE_IDVEHICLETYPE` , `CITY_IDCITY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CONTACTTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CONTACTTYPE` (
  `IDCONTACTTYPE` VARCHAR(2) NOT NULL,
  `DESCCONTACTTYPE` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDCONTACTTYPE`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CUSTOMERCONTACT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CUSTOMERCONTACT` (
  `IDCUSTOMERCONTACT` INT NOT NULL,
  `DESCCONTACT` VARCHAR(20) NOT NULL,
  `USER_IDUSER` VARCHAR(13) NOT NULL,
  `USER_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  `CONTACTTYPE_IDCONTACTTYPE` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`IDCUSTOMERCONTACT`),
  INDEX `FK_CUSTOMERCONTACT_USER_IDX` (`USER_IDUSER` ASC, `USER_IDDOCTYPEFK` ASC) VISIBLE,
  INDEX `FK_CUSTOMERCONTACT_CONTACTTYPE_IDX` (`CONTACTTYPE_IDCONTACTTYPE` ASC) VISIBLE)
ENGINE = INNODB
COMMENT = 'CLIENT';


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CARD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CARD` (
  `IDCARD` INT NOT NULL AUTO_INCREMENT,
  `SERIALCARD` VARCHAR(16) NOT NULL,
  `EXPIRYDATECARD` DATE NOT NULL,
  `CVVCARD` VARCHAR(3) NOT NULL,
  `IDPERSONDETAILSFK` INT NOT NULL,
  `IDPERSONFK` VARCHAR(13) NOT NULL,
  `IDDOCTYPEFK2` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDCARD`),
  INDEX `FK_CARD_USER_IDX` (`IDPERSONFK` ASC, `IDDOCTYPEFK2` ASC) VISIBLE,
  CONSTRAINT `FK_CARD_USER`
    FOREIGN KEY (`IDPERSONFK` , `IDDOCTYPEFK2`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`VEHICLEAVAILABILITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`VEHICLEAVAILABILITY` (
  `IDAVAILABILITYPARK` INT NOT NULL,
  `VEHICLETYPE_IDVEHICLETYPE` INT NOT NULL,
  `TOTALVEHICLEDISP` INT NOT NULL,
  `AVAILABLEVEHICLEDISP` VARCHAR(45) NOT NULL,
  `PARKING_IDPARKING` INT NOT NULL,
  PRIMARY KEY (`IDAVAILABILITYPARK`, `VEHICLETYPE_IDVEHICLETYPE`),
  INDEX `FK_VEHICLEAVAILABILITY_VEHICLETYPE_IDX` (`VEHICLETYPE_IDVEHICLETYPE` ASC) VISIBLE,
  INDEX `FK_VEHICLEAVAILABILITY_PARKING_IDX` (`PARKING_IDPARKING` ASC) VISIBLE,
  CONSTRAINT `FK_VEHICLEAVAILABILITY_VEHICLETYPE`
    FOREIGN KEY (`VEHICLETYPE_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_VEHICLEAVAILABILITY_PARKING`
    FOREIGN KEY (`PARKING_IDPARKING`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`SCORESYSTEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`SCORESYSTEM` (
  `IDPOINTS` INT NOT NULL,
  `USER_IDUSER` VARCHAR(13) NOT NULL,
  `USER_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  `PARKING_IDPARKING` INT NOT NULL,
  `RESERVATIONSCORE` VARCHAR(45) NULL,
  PRIMARY KEY (`IDPOINTS`),
  INDEX `FK_SCORESYSTEM_USER_IDX` (`USER_IDUSER` ASC, `USER_IDDOCTYPEFK` ASC) VISIBLE,
  INDEX `FK_SCORESYSTEM_PARKING_IDX` (`PARKING_IDPARKING` ASC) VISIBLE,
  CONSTRAINT `FK_SCORESYSTEM_USER`
    FOREIGN KEY (`USER_IDUSER` , `USER_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SCORESYSTEM_PARKING`
    FOREIGN KEY (`PARKING_IDPARKING`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`USERDETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`USERDETAILS` (
  `IDUSERDETAILS` INT NOT NULL,
  `USER` VARCHAR(45) NOT NULL,
  `PASSWORD` VARCHAR(45) NOT NULL,
  `ATTEMPTS` INT NOT NULL,
  `BLOCK` TINYINT NOT NULL,
  `CLIENT_IDUSER` VARCHAR(13) NOT NULL,
  `CLIENT_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDUSERDETAILS`),
  INDEX `FK_USERDETAILS_CLIENT_IDX` (`CLIENT_IDUSER` ASC, `CLIENT_IDDOCTYPEFK` ASC) VISIBLE,
  CONSTRAINT `FK_USERDETAILS_CLIENT`
    FOREIGN KEY (`CLIENT_IDUSER` , `CLIENT_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PAYMENTMETHOD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PAYMENTMETHOD` (
  `IDPAYMENTMETHOD` INT NOT NULL,
  `DESCPAYMENTMETHOD` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDPAYMENTMETHOD`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`INVOICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`INVOICE` (
  `IDINVOICE` INT NOT NULL,
  `TOTALINVOICE` INT NOT NULL,
  `DATEINVOICE` DATE NOT NULL,
  `USER_IDUSER` VARCHAR(13) NOT NULL,
  `USER_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  `RESERVATION_IDRESERVATIONDETAIL` INT NOT NULL,
  `PAYMENTMETHOD_IDPAYMENTMETHOD` INT NOT NULL,
  `SUBTOTALINVOICE` INT NULL,
  PRIMARY KEY (`IDINVOICE`),
  INDEX `FK_INVOICE_USER_IDX` (`USER_IDUSER` ASC, `USER_IDDOCTYPEFK` ASC) VISIBLE,
  INDEX `FK_INVOICE_RESERVATION_IDX` (`RESERVATION_IDRESERVATIONDETAIL` ASC) VISIBLE,
  INDEX `FK_INVOICE_PAYMENTMETHOD_IDX` (`PAYMENTMETHOD_IDPAYMENTMETHOD` ASC) VISIBLE,
  CONSTRAINT `FK_INVOICE_USER`
    FOREIGN KEY (`USER_IDUSER` , `USER_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_INVOICE_RESERVATION`
    FOREIGN KEY (`RESERVATION_IDRESERVATIONDETAIL`)
    REFERENCES `FOURPARKSDATABASE`.`RESERVATION` (`IDRESERVATIONDETAIL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_INVOICE_PAYMENTMETHOD`
    FOREIGN KEY (`PAYMENTMETHOD_IDPAYMENTMETHOD`)
    REFERENCES `FOURPARKSDATABASE`.`PAYMENTMETHOD` (`IDPAYMENTMETHOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKINGPARAMETERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKINGPARAMETERS` (
  `IDPARKINGPARAMETERS` INT NOT NULL,
  `DESCPARKINGPARAM` VARCHAR(45) NULL,
  `USER_IDUSER` VARCHAR(13) NOT NULL,
  `USER_IDDOCTYPEFK` VARCHAR(3) NOT NULL,
  `PARKING_IDPARKING` INT NOT NULL,
  PRIMARY KEY (`IDPARKINGPARAMETERS`),
  INDEX `FK_PARKINGPARAMETERS_USER1_IDX` (`USER_IDUSER` ASC, `USER_IDDOCTYPEFK` ASC) VISIBLE,
  INDEX `FK_PARKINGPARAMETERS_PARKING1_IDX` (`PARKING_IDPARKING` ASC) VISIBLE,
  CONSTRAINT `FK_PARKINGPARAMETERS_USER1`
    FOREIGN KEY (`USER_IDUSER` , `USER_IDDOCTYPEFK`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `IDDOCTYPEFK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKINGPARAMETERS_PARKING1`
    FOREIGN KEY (`PARKING_IDPARKING`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

