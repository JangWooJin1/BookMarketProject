use BookMarketDB;

CREATE TABLE IF NOT EXISTS book(
	b_id VARCHAR(10) NOT NULL,
	b_name VARCHAR(20),
	b_unitPrice  INTEGER,
	b_author VARCHAR(50),
	b_publisher VARCHAR(20),
	b_description TEXT,
   	b_category VARCHAR(20),	
	b_unitsInStock LONG,
	b_totalPages LONG,
	b_releaseDate VARCHAR(20),
	b_condition VARCHAR(20),
	b_fileName  VARCHAR(20),
	PRIMARY KEY (b_id)
)default CHARSET=utf8;

desc book;
drop table book;
select * from book;



