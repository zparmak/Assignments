--Course event
--Charlie's Chocolate Factory company produces chocolates. The following product information is stored: product name, product ID, and quantity on hand. These chocolates are made up of many components. Each component can be supplied by one or more suppliers. The following component information is kept: component ID, name, description, quantity on hand, suppliers who supply them, when and how much they supplied, and products in which they are used. On the other hand following supplier information is stored: supplier ID, name, and activation status.

--Assumptions

--A supplier can exist without providing components.
--A component does not have to be associated with a supplier. It may already have been in the inventory.
--A component does not have to be associated with a product. Not all components are used in products.
--A product cannot exist without components. 

--Do the following exercises, using the data model.

     --a) Create a database named "Manufacturer"
     --b) Create the tables in the database.
     --c) Define table constraints.


CREATE DATABASE Manufacturer
USE Manufacturer

CREATE TABLE Product(
	[product_id] INT PRIMARY KEY IDENTITY (1, 1)NOT NULL,
	[product_name] NVARCHAR (100) NOT NULL,
	[quantity] INT NOT NULL
);

CREATE TABLE Component(
	[component_id] INT PRIMARY KEY NOT NULL,
	[component_name] NVARCHAR(100) NOT NULL,
	[description] NVARCHAR(300) NOT NULL,
	[quantity_comp] INT NOT NULL
);

CREATE TABLE Supplier(
	[supplier_id] INT PRIMARY KEY NOT NULL,
	[supplier_name] NVARCHAR(100) NOT NULL,
	[supplier_location] NVARCHAR(100) NOT NULL,
	[act_status] bit NOT NULL
);

CREATE TABLE Prod_Comp(
	[product_id] INT CONSTRAINT FK_Pro_id FOREIGN KEY (product_id) REFERENCES 
		Product(product_id) NOT NULL,
	[component_id]  INT CONSTRAINT FK_Comp_id FOREIGN KEY (component_id) REFERENCES 
		Component(component_id) NOT NULL,
	[quantity_comp] INT,
	PRIMARY KEY ([product_id], [component_id])  --composite key
); 

CREATE TABLE Comp_Supp( 
	[supplier_id] INT CONSTRAINT FK_Supp_id FOREIGN KEY (supplier_id) REFERENCES 
		Supplier(supplier_id) NOT NULL, 
	[component_id] INT CONSTRAINT (FK_Comp_id) FOREIGN KEY (component_id) REFERENCES 
		Component(component_id) NOT NULL,
	[order_date] DATE NOT NULL,
	[quantity] INT, 
	PRIMARY KEY ([component_id], [supplier_id])  --composite key
);




