
*******DATABASE OCPIZZA_BD*********

CREATE DATABASE IF NOT EXISTS OCPIZZA_BD ;
USE OCPIZZA_BD ;

********* Table Compte *******


CREATE TABLE IF NOT EXISTS Compte
(
    idCompte INTEGER NOT NULL AUTO_INCREMENT,
    login VARCHAR(100),
    passWord VARCHAR(100),
	PRIMARY KEY (idCompte)
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Address*********


CREATE TABLE IF NOT EXISTS Adress
(
	idAdress INTEGER AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(100),
    postalCode VARCHAR(5),
	additionAdress  VARCHAR(250)  ,
	PRIMARY KEY(idAdress)
)ENGINE = InnoDB CHARACTER SET latin1;


********* Table Client *******

CREATE TABLE IF NOT EXISTS Client
(
    idClient INTEGER KEY AUTO_INCREMENT,
	idCompte INTEGER ,
	idAdress INTEGER,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    email VARCHAR(255),
	phoneNumber  VARCHAR(10),
    PRIMARY KEY (idClient),
	CONSTRAINT FK_ClientCompte FOREIGN KEY (idCompte) REFERENCES Compte(idCompte),
	CONSTRAINT FK_ClientAdress FOREIGN KEY (idAdress) REFERENCES Adress(idAdress)
    
)ENGINE = InnoDB CHARACTER SET latin1;


*******Table User*********

CREATE TABLE IF NOT EXISTS User
(
	idUser INTEGER AUTO_INCREMENT,
    idCompte INTEGER NOT NULL ,
	idAdress INTEGER,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    email VARCHAR(255),
	phoneNumber  VARCHAR(10),
	typeProfil ENUM('Livreur', 'Pizzaiolos', 'Manager', 'ResponsablePointofSale') NOT NULL,
		
	PRIMARY KEY(idUser),
	CONSTRAINT FK_UserCompte FOREIGN KEY (idCompte) REFERENCES Compte(idCompte),
	CONSTRAINT FK_UserAdress FOREIGN KEY (idAdress) REFERENCES Adress(idAdress)
	
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table PointOfSale*********

CREATE TABLE IF NOT EXISTS PointOfSale
(
	idPointOfSale INTEGER AUTO_INCREMENT,
    name VARCHAR(100),
    idResponsable INTEGER,
	PRIMARY KEY(idPointOfSale),
	CONSTRAINT FK_PointOfSaleUser FOREIGN KEY (idResponsable) REFERENCES User(idUser)
	
)ENGINE = InnoDB CHARACTER SET latin1;



*******Table Supplier*********

CREATE TABLE IF NOT EXISTS Supplier
(
	idSupplier INTEGER  AUTO_INCREMENT,
    name VARCHAR(100),
    idAdress INTEGER,
	phoneNumber  VARCHAR(10),
    email VARCHAR(255),
	PRIMARY KEY(idSupplier),
	CONSTRAINT FK_SupplierAdress FOREIGN KEY (idAdress) REFERENCES Adress(idAdress)
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Payement*********

CREATE TABLE IF NOT EXISTS Payement
(
    idPayement INTEGER  AUTO_INCREMENT,
	amount FLOAT,
	PRIMARY KEY(idPayement),
	status ENUM('Espece', 'In Paypal', 'Carte')  NOT NULL
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Commande*********

CREATE TABLE IF NOT EXISTS Commande
(
    idCommande INTEGER AUTO_INCREMENT,
	IdPayement INTEGER,
	IdLivreur INTEGER ,
	idClient INTEGER ,
	idAdress INTEGER,
	dateCommande DATETIME,
	livraisonHour TIME,
	status ENUM('Confirmmed', 'In preparation', 'Out for delivry', 'Delivred')  NOT NULL,
	PRIMARY KEY(idCommande),
	CONSTRAINT FK_CommandePayement FOREIGN KEY (IdPayement) REFERENCES Payement(IdPayement),
	CONSTRAINT FK_CommandeUser FOREIGN KEY (IdLivreur) REFERENCES User(idUser),
    CONSTRAINT FK_CommandeClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
    CONSTRAINT FK_CommandeAdress FOREIGN KEY (idAdress) REFERENCES Adress(idAdress)
    
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Product*********

CREATE TABLE  IF NOT EXISTS Product
(
    idProduct INTEGER AUTO_INCREMENT,
	name VARCHAR(100),
	Unity ENUM('Kg', 'U', 'L')  NOT NULL,
	UnitPrice FLOAT ,
	sellingPrice FLOAT,
	urlPicture VARCHAR(200),
	PRIMARY KEY(idProduct)
)ENGINE = InnoDB CHARACTER SET latin1;


*******Table Pizza*********

CREATE TABLE IF NOT EXISTS Pizza
(
    idPizza INTEGER AUTO_INCREMENT,
	receipts VARCHAR(100),
	idProduct INTEGER,
    PRIMARY KEY(idPizza),
	CONSTRAINT FK_PizzaProduct FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
	
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Categorie*********

CREATE TABLE IF NOT EXISTS Categorie
(
    idCategorie INTEGER AUTO_INCREMENT,
    name VARCHAR(100),
	PRIMARY KEY(idCategorie)
)ENGINE = InnoDB CHARACTER SET latin1;

*******Table Extra*********

CREATE TABLE IF NOT EXISTS Extra
(
    idExtra INTEGER  AUTO_INCREMENT,
	idProduct INTEGER,
	idSupplier INTEGER,
	idCategorie INTEGER,
	purchasingPrice FLOAT;
	
	PRIMARY KEY(idExtra),
	CONSTRAINT FK_ExtraProduct FOREIGN KEY (idProduct) REFERENCES Product(idProduct),
	CONSTRAINT FK_ExtraSupplier FOREIGN KEY (idSupplier) REFERENCES Supplier(idSupplier),
	CONSTRAINT FK_ExtraCategorie FOREIGN KEY (idCategorie) REFERENCES Categorie(idCategorie)
	
)ENGINE = InnoDB;


*******Table DetailCommande*********

CREATE TABLE IF NOT EXISTS DetailCommande
(
    idDetail INTEGER AUTO_INCREMENT,
	idCommande INTEGER,
	idPoduct INTEGER,
	quantity INTEGER,
    PRIMARY KEY(idDetail),
	CONSTRAINT FK_DetailCommandeCommande FOREIGN KEY (idCommande) REFERENCES Commande(idCommande),
	CONSTRAINT FK_DetailCommandeProduct FOREIGN KEY (idPoduct) REFERENCES Product(idPoduct)
	
)ENGINE = InnoDB;


*******Table Stock*********

CREATE TABLE IF NOT EXISTS Stock
(
    idStock INTEGER  AUTO_INCREMENT,
	idPointOfSale INTEGER,
	idExtra INTEGER,
	reelQuantityStock INTEGER,
	safetyStock INTEGER,
    PRIMARY KEY(idStock),
	CONSTRAINT FK_StockPointOfSale FOREIGN KEY (idPointOfSale) REFERENCES PointOfSale(idPointOfSale),
	CONSTRAINT FK_StockSupplier FOREIGN KEY (idExtra) REFERENCES Supplier(idExtra)
)ENGINE = InnoDB ;













 




