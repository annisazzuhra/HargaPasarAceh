-- 1. Mengecek jumlah data pada setiap tabel
SELECT 'pengguna' AS nama_tabel, COUNT(*) AS jumlah_data
FROM pengguna
UNION ALL
SELECT 'pasar', COUNT(*) FROM pasar
UNION ALL
SELECT 'komoditas', COUNT(*) FROM komoditas
UNION ALL
SELECT 'harga_acuan', COUNT(*) FROM harga_acuan
UNION ALL
SELECT 'laporan_harga', COUNT(*) FROM laporan_harga
UNION ALL
SELECT 'log_anomali', COUNT(*) FROM log_anomali
UNION ALL
SELECT 'langganan_komoditas', COUNT(*) FROM langganan_komoditas
UNION ALL
SELECT 'peringatan_harga', COUNT(*) FROM peringatan_harga;

-- 2. Mengecek isi tabel pasar
SELECT * FROM pasar;

-- 3. Mengecek isi tabel komoditas
SELECT * FROM komoditas;

-- 4. Mengecek isi tabel harga acuan
SELECT * FROM harga_acuan;

-- 5. Mengecek isi tabel laporan harga
SELECT * FROM laporan_harga;

-- 6. Menguji view harga terbaru
SELECT * FROM vw_harga_terbaru;

-- 7. Menguji view rata-rata harga
SELECT * FROM vw_rata_rata_harga;

-- 8. Mengecek function rata-rata harga
SELECT
    routine_name,
    routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name = 'fn_rata_rata_harga';

-- 9. Mengecek stored procedure verifikasi laporan
SELECT
    routine_name,
    routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name = 'sp_verifikasi_laporan';

-- 10. Mengecek trigger pada tabel laporan harga
SELECT
    trigger_name,
    event_object_table,
    action_timing,
    event_manipulation
FROM information_schema.triggers
WHERE trigger_schema = 'public'
  AND event_object_table = 'laporan_harga';

-- 11. Mengecek data log anomali
SELECT * FROM log_anomali;

-- 12. Mengecek data peringatan harga
SELECT * FROM peringatan_harga;
