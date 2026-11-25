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
