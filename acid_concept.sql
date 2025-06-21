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

-- 1. ATOMICITY : 
-- Transaksi berhasil = semua statement berhasil
START TRANSACTION;
INSERT INTO accounts(id, name, balace)
VALUES ('hasan', 'M. Hasan', 5000000);
INSERT INTO accounts(id, name, balace)
VALUES ('sans', 'Sanstuy', 1000000);
COMMIT; -- Kedua data baru berhasil ditambahkan disini karena semua statement berhasil

-- Transaksi gagal = semua statement != berhasil / digagalkan
START TRANSACTION;
DELETE FROM accounts WHERE id = "hasan";
DELETE FROM accounts WHERE id = "sans";
ROLLBACK; -- Kedua data gagal dihapus disini karena dirollback









