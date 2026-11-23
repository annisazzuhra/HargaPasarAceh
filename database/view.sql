CREATE OR REPLACE VIEW vw_harga_terbaru AS
SELECT
    lh.id_laporan,
    lh.id_komoditas,
    k.nama_komoditas,
    lh.id_pasar,
    p.nama_pasar,
    lh.harga,
    k.satuan,
    lh.tanggal_laporan,
    lh.status
FROM laporan_harga lh
JOIN komoditas k
    ON lh.id_komoditas = k.id_komoditas
JOIN pasar p
    ON lh.id_pasar = p.id_pasar
WHERE lh.status <> 'ditolak';

CREATE OR REPLACE VIEW vw_rata_rata_harga AS
SELECT
    k.id_komoditas,
    k.nama_komoditas,
    p.id_pasar,
    p.nama_pasar,
    AVG(lh.harga) AS rata_rata_harga,
    COUNT(lh.id_laporan) AS jumlah_laporan
FROM laporan_harga lh
JOIN komoditas k
    ON lh.id_komoditas = k.id_komoditas
JOIN pasar p
    ON lh.id_pasar = p.id_pasar
WHERE lh.status = 'terverifikasi'
GROUP BY
    k.id_komoditas,
    k.nama_komoditas,
    p.id_pasar,
    p.nama_pasar;
