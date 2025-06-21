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

-- 2. CONSISTENCY
-- Transaksi hanya bisa mengubah data konidsi konsisten ke kondisi konsisten lainnya
-- Menjaga data tetap konsisten, dan menjamin integritas antar relasi
START TRANSACTION;
UPDATE accounts SET name = null WHERE id = "hasan"; -- Akan gagal, harus konsisten dengan aturan yg dibuat di awal (name = not null)
COMMIT;

-- 3. ISOLATION
-- Menjaga ketika transaksi bersamaan, database dapat mengelola seperti transaksi berurutan
-- Menjaga kontrol terhadap konkurensi
-- Simulasi dua user eksekusi transaksi yg sama berbarengan, maka salah satu user harus menunggu dan memperoleh data akhir setelah transaksi user lain selesai
START TRANSACTION;
SELECT * FROM accounts WHERE id IN ('hasan','sans') FOR UPDATE;
UPDATE accounts SET balace = balace - 500000 where id = "hasan";
UPDATE accounts SET balace = balace + 500000 where id = "sans";
COMMIT;

-- 4. DURABILITY
-- Menjamin ketika sekali data telah disimpan, maka data akan tetap disimpan bahkan dalam kasus kegagalan sistem (crash, padam, kebakaran dll)
START TRANSACTION;
SELECT * FROM accounts WHERE id IN ('hasan','sans') FOR UPDATE;
UPDATE accounts SET balace = balace - 500000 where id = "hasan";
-- Shutdown/Off MySQL
-- Data harus konsisten seperti data sebelum transaction karena belum COMMIT
-- Kecuali sampai COMMIT lalu shutdown mysql, maka data terbaru yang harus disimpan
UPDATE accounts SET balace = balace + 500000 where id = "sans";
COMMIT;







