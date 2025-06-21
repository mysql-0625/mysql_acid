SHOW DATABASES;

CREATE DATABASE mysql_acid;

USE mysql_acid;

CREATE TABLE accounts(
	id VARCHAR(100),
    name VARCHAR(100) NOT NULL,
    balace BIGINT NOT NULL,
    PRIMARY KEY (id)
);

DESC accounts;

ALTER TABLE accounts
MODIFY id VARCHAR(100) NOT NULL;

SELECT * FROM accounts;









