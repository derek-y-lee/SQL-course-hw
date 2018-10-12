/* Derek Lee 
CS 31 Assignment 4
dlee_assignment4.sql*/

SHOW warnings; /* enable warnings!*/ 


CREATE DATABASE IF NOT EXISTS library;

USE library;

Drop table if exists branch_staff;
Drop table if exists computer_staff;
Drop table if exists staff;
Drop table if exists computer;

/*Query 1: Creates STAFF, COMPUTER_STAFF, BRANCH_STAFF, COMPUTER tables*/
CREATE TABLE staff (
staff_id VARCHAR(100),
lname VARCHAR(100), 
fname VARCHAR(100),
phone VARCHAR(100),
email VARCHAR(100)
)ENGINE = INNODB;

CREATE TABLE computer_staff (
serial_number VARCHAR(100), 
staff_id VARCHAR (50),
date_assigned VARCHAR(50)
)ENGINE = INNODB;

CREATE TABLE branch_staff (
branch_id VARCHAR(100), 
staff_id VARCHAR (50),
contact VARCHAR(50)
)ENGINE = INNODB;

CREATE TABLE computer (
serial_number VARCHAR(100), 
make VARCHAR (50),
model VARCHAR(50),
processor_type VARCHAR(50),
speed VARCHAR(50),
main_memory VARCHAR(50),
disk_size VARCHAR(50)
)ENGINE = INNODB;

/*Query 2: Runs insert_data_computer.sql*/
/* SOURCE insert_data_computer.sql;*/

/*Query 3: Display serial numbers and models of all computers*/

SELECT serial_number, model from COMPUTER;

/*Query 4: Add a date_added column for the date and time book was added to BOOKS table created in Query 2
Display column names and datatypes for BOOKS table*/


ALTER TABLE books
ADD COLUMN date_added datetime;

DESCRIBE books;



/*Query 5: Modify STAFF table so lname column cannot store NULL values and can contain max of 30 characters
Display column names and datatypes for STAFF table*/


ALTER TABLE STAFF
MODIFY lname VARCHAR(30) NOT NULL; 


/*Query 6: Adds column named salary with datatype of decimal(7,2) to STAFF table*/

ALTER TABLE STAFF
ADD COLUMN SALARY DECIMAL(7,2);


/*Query 7: Display all columns of all rows of COMPUTER_Staff table without using asterisk notation*/

SELECT serial_number, staff_id, date_assigned from COMPUTER_STAFF;

/*Query 8: Delete date_added column from BOOKS table*/

ALTER TABLE books
DROP COLUMN date_added;


/*Query 9: Creates separate table named BOOKS_ARCHIVE with same structure as BOOKS table to hold archive records*/
DROP TABLE IF EXISTS BOOKS_ARCHIVE;

CREATE TABLE BOOKS_ARCHIVE AS SELECT * FROM BOOKS;


/*Query 10: Removes BOOKS_ARCHIVE table from database. Displays names of tables in current database*/

DROP TABLE BOOKS_ARCHIVE;

