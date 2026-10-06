# PostgreSQL - Cheat Sheet

## Koneksi

```bash
psql -U postgres -h localhost -p 5432 -d nama_db
psql postgres://user:password@localhost:5432/nama_db
```

| Perintah     | Fungsi                   |
| ------------ | ------------------------ |
| `\c nama_db` | Pindah database          |
| `\q`         | Keluar dari psql         |
| `\conninfo`  | Lihat info koneksi aktif |

## Database

```sql
CREATE DATABASE nama_db;
DROP DATABASE nama_db;
```

| Perintah | Fungsi                 |
| -------- | ---------------------- |
| `\l`     | List semua database    |
| `\l+`    | List + ukuran database |

```bash
# Backup & restore (via terminal, bukan psql)
pg_dump -U postgres nama_db > backup.sql
pg_dump -U postgres -Fc nama_db -f backup.dump
psql -U postgres -d nama_db -f backup.sql
pg_restore -U postgres -d nama_db backup.dump
```

## User & Hak Akses

```sql
CREATE USER budi WITH PASSWORD 'rahasia';
CREATE DATABASE milik_budi OWNER budi;
GRANT ALL PRIVILEGES ON DATABASE nama_db TO budi;
GRANT ALL ON TABLE nama_tabel TO budi;          -- satu tabel
GRANT ALL ON ALL TABLES IN SCHEMA public TO budi; -- semua tabel
ALTER USER budi WITH PASSWORD 'baru';
DROP USER budi;
```

| Perintah | Fungsi         |
| -------- | -------------- |
| `\du`    | List user/role |

## Tabel & Schema

| Perintah        | Fungsi                                     |
| --------------- | ------------------------------------------ |
| `\dt`           | List tabel                                 |
| `\dt+`          | List tabel + ukuran                        |
| `\d nama_tabel` | Struktur tabel                             |
| `\dn`           | List schema                                |
| `\df`           | List functions                             |
| `\di`           | List indexes                               |
| `\x on`         | Tampilan vertikal (enak untuk tabel lebar) |

```sql
-- Buat & hapus cepat
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  nama TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE users;
ALTER TABLE users ADD COLUMN umur INT;
ALTER TABLE users DROP COLUMN umur;
ALTER TABLE users RENAME TO members;
```

## CRUD (paling sering)

```sql
-- Create
INSERT INTO users (nama, email) VALUES ('Budi', 'budi@mail.com');

-- Read
SELECT * FROM users;
SELECT nama, email FROM users WHERE email LIKE '%@mail.com%' LIMIT 10;
SELECT * FROM users ORDER BY created_at DESC LIMIT 5;

-- Update
UPDATE users SET nama = 'Budi Baru' WHERE id = 1;

-- Delete
DELETE FROM users WHERE id = 1;
TRUNCATE users; -- hapus semua isi, reset cepat
```

## Cek Ukuran & Aktivitas

```sql
-- Ukuran
SELECT pg_size_pretty(pg_database_size('nama_db'));
SELECT tablename, pg_size_pretty(pg_total_relation_size(tablename::regclass))
FROM pg_tables WHERE schemaname = 'public';

-- Koneksi aktif
SELECT pid, usename, datname, state, query FROM pg_stat_activity;

-- Kill koneksi macet (ganti PID)
SELECT pg_terminate_backend(12345);

-- Lihat query lambat / locks
SELECT * FROM pg_locks WHERE NOT granted;
```

## Index & Performa

```sql
CREATE INDEX idx_users_email ON users (email);
DROP INDEX idx_users_email;

EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'budi@mail.com';
```

## Import / Export CSV

```sql
COPY users TO '/tmp/users.csv' CSV HEADER;
COPY users FROM '/tmp/users.csv' CSV HEADER;
```

```bash
# Kalau error permission, pakai \copy di psql (akses file lokal)
\copy users TO 'users.csv' CSV HEADER
\copy users FROM 'users.csv' CSV HEADER
```

## Docker (kalau pakai container)

```bash
docker run -d --name pg -e POSTGRES_PASSWORD=rahasia -p 5432:5432 postgres:16
docker exec -it pg psql -U postgres
docker exec pg pg_dump -U postgres nama_db > backup.sql
```

## Reset Cepat (dev only!)

```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
```
