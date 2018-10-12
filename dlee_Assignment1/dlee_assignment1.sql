/*  Assignment 1.sql
Derek Lee
CS 31A, Winter 2018 */

\W /*enable warnings! */

/*Initiates college database as long as there's no duplicate*/
CREATE DATABASE IF NOT EXISTS college;

/*Use college database*/
USE college;

/*Creates a table called instructor to store values*/

CREATE TABLE instructor (
 emp_num int,
 dept_code varchar(10),
 office varchar(50),
 degree varchar(5)
)ENGINE = INNODB;

/*Inserts values into table to create the table's entries*/
INSERT INTO instructor VALUES('103','HIST','DRE 156','Ph.D.');
INSERT INTO instructor VALUES('104','ENG','DRE 102','MA');
INSERT INTO instructor VALUES('105','ACCT','KLR 229D','Ph.D.');
INSERT INTO instructor VALUES('110','BIOL','AAK 160','Ph.D.');
INSERT INTO instructor VALUES('114','ACCT','KLR 211','Ph.D.');
INSERT INTO instructor VALUES('209','CIS','KLR 333','Ph.D.');

/*Shows tables in MySQL Workbench*/
SHOW TABLES;

/*Organizes the instructor table with values in descending numerical order*/
DESC instructor;

/*Displays everything from the instructor table*/
SELECT *
FROM instructor;

/*Displays emp_num and degree from the instructor table*/
SELECT emp_num, degree
FROM instructor;