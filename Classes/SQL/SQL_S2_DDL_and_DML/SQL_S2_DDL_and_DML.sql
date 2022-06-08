
CREATE DATABASE LibDatabase;

Use LibDatabase;

--Create Book Schema
CREATE SCHEMA Book;

--Create Book.Book Table
CREATE TABLE Book.Book(
	Book_ID INT PRIMARY KEY,
	Book_Name NVARCHAR(50) NOT NULL,
	Author_ID INT NOT NULL,
	Publisher_ID INT NOT NULL
	);

--Create Book.Author Table
CREATE TABLE Book.Author(
	Author_ID INT,
	Author_FirstName NVARCHAR(50) NOT NULL,
	Author_LastName NVARCHAR(50) NOT NULL
	);

--Create Book.Publisher Table
CREATE TABLE Book.Publisher(
	Publisher_ID INT PRIMARY KEY IDENTITY(1,1),
	Publisher_Name NVARCHAR(100) NULL
	);

--Create Person Schema
CREATE SCHEMA Person;

--Create Person.Person Table
CREATE TABLE Person.Person(
	SSN BIGINT PRIMARY KEY,
	Person_FirstName NVARCHAR(50) NULL,
	Person_LastName NVARCHAR(50) NULL
	);

--Create Person.Loan Table
CREATE TABLE Person.Loan(
	SSN BIGINT NOT NULL,
	Book_ID INT NOT NULL,
	PRIMARY KEY (SSN, Book_ID)
	);

--Create Person.Person_Phone Table
CREATE TABLE Person.Person_Phone(
	Phone_Number BIGINT PRIMARY KEY NOT NULL,
	SSN BIGINT NOT NULL
	);

--Create Person.Person_Mail Table
CREATE TABLE Person.Person_Mail(
	Mail_ID INT PRIMARY KEY IDENTITY(1,1),
	Mail NVARCHAR(MAX) NOT NULL,
	SSN BIGINT UNIQUE NOT NULL
	);

INSERT INTO Person.Person(SSN, Person_FirstName, Person_LastName) VALUES
	(75056659595, 'Zehra', 'Tekin'),
	(45269851236, 'Fatma', 'Erkan')

INSERT INTO Person.Person(SSN, Person_FirstName, Person_LastName) VALUES
	(45216854692, 'Esra', NULL),
	(66599524565, 'Mert', 'Sakin')

INSERT INTO Person.Person VALUES (52214585692, 'Zeynep')

INSERT INTO Person.Person(SSN) VALUES (42215274565)

INSERT Person.Person(SSN, Person_FirstName, Person_LastName) VALUES (15078893526,'Mert','Yetiş')

INSERT INTO Person.Person_Mail (Mail, SSN) VALUES
	('zehtek@gmail.com', 75056659595),
	('meyet@gmail.com', 15078893526),
	('metsak@gmail.com', 66599524565)

SELECT @@IDENTITY--last process last identity number
SELECT @@ROWCOUNT--last process row count