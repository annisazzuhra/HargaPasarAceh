
-- =========================================
-- HARGAPASAR ACEH
-- 06 - TRANSAKSI DATABASE
-- =========================================

-- 1. Contoh transaksi COMMIT
-- Menambahkan langganan komoditas untuk pengguna.

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
