use BookMarketDB;

CREATE TABLE IF NOT EXISTS account(
	id VARCHAR(10) NOT NULL,
	password VARCHAR(10) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO account VALUES('admin','0000');

select * from account;
