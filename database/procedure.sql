CREATE OR REPLACE FUNCTION fn_rata_rata_harga(
    p_id_komoditas INT,
    p_id_pasar INT
)
RETURNS NUMERIC(12,2) AS $$
DECLARE
    v_rata_rata NUMERIC(12,2);
BEGIN
    SELECT AVG(harga)
    INTO v_rata_rata
    FROM laporan_harga
    WHERE id_komoditas = p_id_komoditas
      AND id_pasar = p_id_pasar
      AND status = 'terverifikasi';

    RETURN v_rata_rata;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE sp_verifikasi_laporan(
    p_id_laporan INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE laporan_harga
    SET status = 'terverifikasi'
    WHERE id_laporan = p_id_laporan
      AND status = 'menunggu';
END;
$$;
