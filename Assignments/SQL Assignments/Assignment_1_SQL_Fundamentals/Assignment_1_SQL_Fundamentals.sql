
CREATE DATABASE Manufacturer;

CREATE TABLE Supplier(
	Supplier_ID INT NOT NULL,
	Supplier_Name VARCHAR(50) NULL,
	Supplier_Location VARCHAR(50) NULL,
	Supplier_Country VARCHAR(50) NULL,
	is_active bit NULL,
	PRIMARY KEY(Supplier_ID)
	);

CREATE TABLE Component(
	Component_ID INT NOT NULL,
	Component_Name VARCHAR(50) NULL,
	Description VARCHAR(50) NULL,
	Quantity_Hand INT NULL,
	PRIMARY KEY (Component_ID),
	);

CREATE TABLE Product(
	Product_ID INT NOT NULL,
	Product_Name VARCHAR(50) NULL,
	Quantity_Hand INT NULL,
	PRIMARY KEY (Product_ID),
	);

CREATE TABLE Prod_Comp(
	Prod_ID INT NOT NULL,
	Comp_ID INT NOT NULL,
	Quantity_Hand INT NULL,
	PRIMARY KEY CLUSTERED (Prod_ID, Comp_ID),
	FOREIGN KEY(Prod_ID) REFERENCES Product(Product_ID),
	FOREIGN KEY(Comp_ID) REFERENCES Component(Component_ID),
	);

CREATE TABLE Comp_Supp(
	Supplier_ID INT NOT NULL,
	Comp_ID INT NOT NULL,
	Order_Date DATE NOT NULL,
	Quantity_Hand INT NULL,
	PRIMARY KEY CLUSTERED (Supplier_ID, Comp_ID),
	FOREIGN KEY(Supplier_ID) REFERENCES Supplier(Supplier_ID),
	FOREIGN KEY(Comp_ID) REFERENCES Component(Component_ID)
	);