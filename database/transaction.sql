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

BEGIN;

WITH laporan_diperbarui AS (
    UPDATE laporan_harga
    SET status = 'terverifikasi'
    WHERE id_laporan = 1
      AND status = 'menunggu'
    RETURNING
        id_laporan,
        id_pengguna,
        id_komoditas
)
INSERT INTO peringatan_harga (
    id_pengguna,
    id_komoditas,
    pesan
)
SELECT
    id_pengguna,
    id_komoditas,
    'Laporan harga #' || id_laporan ||
    ' telah diverifikasi.'
FROM laporan_diperbarui
WHERE id_pengguna IS NOT NULL;

COMMIT;

SELECT
    lk.id_langganan,
    u.nama AS nama_pengguna,
    k.nama_komoditas,
    lk.tanggal_langganan
FROM langganan_komoditas lk
JOIN pengguna u
    ON lk.id_pengguna = u.id_pengguna
JOIN komoditas k
    ON lk.id_komoditas = k.id_komoditas
ORDER BY lk.id_langganan;

SELECT
    id_laporan,
    harga,
    status
FROM laporan_harga
ORDER BY id_laporan;

SELECT
    id_peringatan,
    id_pengguna,
    id_komoditas,
    pesan,
    status
FROM peringatan_harga
ORDER BY id_peringatan;
