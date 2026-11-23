CREATE OR REPLACE FUNCTION fn_deteksi_anomali()
RETURNS TRIGGER AS $$
DECLARE
    v_harga_pembanding NUMERIC(12,2);
    v_selisih NUMERIC(8,2);
BEGIN
    SELECT AVG(harga)
    INTO v_harga_pembanding
    FROM laporan_harga
    WHERE id_komoditas = NEW.id_komoditas
      AND id_pasar = NEW.id_pasar
      AND tanggal_laporan >=
          NEW.tanggal_laporan - INTERVAL '7 days'
      AND id_laporan <> NEW.id_laporan
      AND status = 'terverifikasi';

    IF v_harga_pembanding IS NULL OR v_harga_pembanding = 0 THEN
        SELECT harga_referensi
        INTO v_harga_pembanding
        FROM harga_acuan
        WHERE id_komoditas = NEW.id_komoditas
        ORDER BY tanggal_berlaku DESC
        LIMIT 1;
    END IF;

    IF v_harga_pembanding IS NOT NULL
       AND v_harga_pembanding <> 0 THEN

        v_selisih :=
            ABS(NEW.harga - v_harga_pembanding)
            / v_harga_pembanding * 100;

        IF v_selisih > 20 THEN
            INSERT INTO log_anomali (
                id_laporan,
                harga_dilaporkan,
                harga_pembanding,
                persentase_selisih
            )
            VALUES (
                NEW.id_laporan,
                NEW.harga,
                v_harga_pembanding,
                v_selisih
            );
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_deteksi_anomali
AFTER INSERT ON laporan_harga
FOR EACH ROW
EXECUTE FUNCTION fn_deteksi_anomali();
