EXPLAIN ANALYZE
SELECT
    id_laporan,
    id_komoditas,
    id_pasar,
    harga,
    tanggal_laporan
FROM laporan_harga
WHERE id_komoditas = 1
  AND id_pasar = 1
ORDER BY tanggal_laporan DESC;
