use BookMarketDB;

CREATE TABLE IF NOT EXISTS cart(
	id INTEGER NOT NULL AUTO_INCREMENT,
	account_id VARCHAR(10) NOT NULL,
	book_id VARCHAR(10) NOT NULL,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (id)
);

select * from cart;
