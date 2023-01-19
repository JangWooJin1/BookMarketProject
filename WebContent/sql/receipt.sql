use BookMarketDB;

CREATE TABLE IF NOT EXISTS receipt(
	id INTEGER NOT NULL AUTO_INCREMENT,
	account_id VARCHAR(10) NOT NULL,
	name VARCHAR(10) NOT NULL,
	zipCode VARCHAR(10) NOT NULL,
	addressName VARCHAR(30) NOT NULL,
	shippingDate VARCHAR(10) NOT NULL,
	book_ids VARCHAR(50) NOT NULL,
	quantitys VARCHAR(50) NOT NULL,
	PRIMARY KEY (id)
);

select * from receipt;
