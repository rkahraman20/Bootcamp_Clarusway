
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

INSERT Person.Person(SSN, Person_FirstName, Person_LastName)
VALUES
	(75056659595, 'Zehra', 'Tekin'),
	(45269851236, 'Fatma', 'Erkan')

--INSERT INTO Person.Person(SSN, Person_FirstName, Person_LastName)
--VALUES
--	(75056659595, 'Zehra', 'Tekin'),
--	(45269851236, 'Fatma', 'Erkan')

INSERT INTO Person.Person(SSN, Person_FirstName, Person_LastName)
VALUES
	(45216854692, 'Esra', NULL),
	(66599524565, 'Mert', 'Sakin')

INSERT INTO Person.Person
VALUES (52214585692, 'Zeynep')

INSERT INTO Person.Person(SSN)
VALUES (42215274565)

INSERT Person.Person(SSN, Person_FirstName, Person_LastName)
VALUES (15078893526,'Mert','Yetiş')

INSERT INTO Person.Person_Mail(Mail, SSN)
VALUES
	('zehtek@gmail.com', 75056659595),
	('meyet@gmail.com', 15078893526),
	('metsak@gmail.com', 66599524565)

INSERT Person.Person(SSN, Person_FirstName)
VALUES (52232565894, 'Kerim')

INSERT Person.Person(SSN, Person_FirstName, Person_LastName)
VALUES (12252245896, 'Zeki', NULL)

SELECT @@IDENTITY--last process last identity number
SELECT @@ROWCOUNT--last process row count



--SELECT INTO FROM
SELECT * FROM Person.Person

SELECT * INTO Person.Person2
FROM Person.Person

SELECT * FROM Person.Person2



--INSERT INTO SELECT FROM
INSERT INTO Person.Person2
SELECT * FROM Person.Person
WHERE Person_FirstName = 'Zeki'

SELECT * FROM Person.Person2



--INSERT SELECT FROM
INSERT Person.Person2
SELECT * FROM Person.Person
WHERE Person_LastName = 'Tekin'

SELECT * FROM Person.Person2



--INSERT DEFAULT VALUES
INSERT Book.Publisher
DEFAULT VALUES

SELECT * FROM Book.Publisher



--UPDATE
UPDATE Person.Person2
SET Person_FirstName = 'Default_Name'

SELECT * FROM Person.Person2

UPDATE Person.Person2
SET Person_FirstName = 'Ahmet'
WHERE Person_LastName = 'Erkan'

SELECT * FROM Person.Person2



--DELETE
INSERT Book.Publisher
VALUES
	('İş Bankası Yayıncılık'),
	('Can Yayıncılık'),
	('İletişim Yayıncılık')

SELECT * FROM Book.Publisher

DELETE FROM Book.Publisher

DELETE FROM Book.Publisher
WHERE Publisher_Name = 'İletişim Yayıncılık'



--DROP TABLE
DROP TABLE Person.Person2



--TRUNCATE TABLE
TRUNCATE TABLE Person.Person_Mail
TRUNCATE TABLE Person.Person
TRUNCATE TABLE Book.Publisher



--ALTER TABLE
ALTER TABLE Book.Author
	ALTER COLUMN Author_ID INT NOT NULL

ALTER TABLE Book.Author
	ADD CONSTRAINT PK_Author
	PRIMARY KEY (Author_ID)


ALTER TABLE Book.Book
	ADD CONSTRAINT FK_Author
	FOREIGN KEY (Author_ID)
	REFERENCES Book.Author(Author_ID)



ALTER TABLE Book.Book
	ADD CONSTRAINT FK_Publisher
	FOREIGN KEY (Publisher_ID)
	REFERENCES Book.Publisher(Publisher_ID)



ALTER TABLE Person.Loan
	ADD CONSTRAINT FK_Person
	FOREIGN KEY (Book_ID)
	REFERENCES Book.Book(Book_ID)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION



ALTER TABLE Person.Person_Phone
	ADD CONSTRAINT FK_Person_2
	FOREIGN KEY (SSN)
	REFERENCES Person.Person(SSN)



ALTER TABLE Person.Person_Mail
	ADD CONSTRAINT FK_Person_3
	FOREIGN KEY (SSN)
	REFERENCES Person.Person(SSN)



ALTER TABLE Person.Loan
	ADD CONSTRAINT FK_Book
	FOREIGN KEY (SSN)
	REFERENCES Person.Person(SSN)
	ON UPDATE NO ACTION
	ON DELETE CASCADE



--CHECK CONSTRAINTS
SELECT * FROM Person.Person

ALTER TABLE Person.Person
	ADD CONSTRAINT Check_SSN
	CHECK (SSN > 9999999999 AND SSN < 999999999999)

INSERT Person.Person (SSN) VALUES (89598855899)