BEGIN;

INSERT INTO langganan_komoditas (
    id_pengguna,
    id_komoditas
)
SELECT
    u.id_pengguna,
    k.id_komoditas
FROM pengguna u
CROSS JOIN komoditas k
WHERE u.id_pengguna = 1
  AND k.id_komoditas = 1
ON CONFLICT (id_pengguna, id_komoditas)
DO NOTHING;

COMMIT;

BEGIN;

INSERT INTO langganan_komoditas (
    id_pengguna,
    id_komoditas
)
SELECT
    u.id_pengguna,
    k.id_komoditas
FROM pengguna u
CROSS JOIN komoditas k
WHERE u.id_pengguna = 1
  AND k.id_komoditas = 2
ON CONFLICT (id_pengguna, id_komoditas)
DO NOTHING;

ROLLBACK;

BEGIN;

INSERT INTO langganan_komoditas (
    id_pengguna,
    id_komoditas
)
SELECT
    u.id_pengguna,
    k.id_komoditas
FROM pengguna u
CROSS JOIN komoditas k
WHERE u.id_pengguna = 1
  AND k.id_komoditas = 3
ON CONFLICT (id_pengguna, id_komoditas)
DO NOTHING;

SAVEPOINT sebelum_perubahan;

UPDATE langganan_komoditas
SET tanggal_langganan = CURRENT_TIMESTAMP
WHERE id_pengguna = 1
  AND id_komoditas = 3;

ROLLBACK TO SAVEPOINT sebelum_perubahan;

COMMIT;
