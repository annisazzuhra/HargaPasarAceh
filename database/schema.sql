CREATE TABLE pengguna (
    id_pengguna SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tanggal_daftar TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pasar (
    id_pasar SERIAL PRIMARY KEY,
    nama_pasar VARCHAR(100) NOT NULL,
    alamat TEXT,
    kecamatan VARCHAR(100)
);

CREATE TABLE komoditas (
    id_komoditas SERIAL PRIMARY KEY,
    nama_komoditas VARCHAR(100) NOT NULL,
    satuan VARCHAR(30) NOT NULL,
    kategori VARCHAR(50)
);

CREATE TABLE harga_acuan (
    id_harga_acuan SERIAL PRIMARY KEY,
    id_komoditas INT NOT NULL REFERENCES komoditas(id_komoditas),
    harga_referensi NUMERIC(12,2) NOT NULL,
    tanggal_berlaku DATE NOT NULL,
    sumber_data TEXT
);

CREATE TABLE laporan_harga (
    id_laporan SERIAL PRIMARY KEY,
    id_pengguna INT REFERENCES pengguna(id_pengguna),
    id_pasar INT NOT NULL REFERENCES pasar(id_pasar),
    id_komoditas INT NOT NULL REFERENCES komoditas(id_komoditas),
    harga NUMERIC(12,2) NOT NULL,
    tanggal_laporan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'menunggu'
);

CREATE TABLE log_anomali (
    id_anomali SERIAL PRIMARY KEY,
    id_laporan INT REFERENCES laporan_harga(id_laporan),
    harga_dilaporkan NUMERIC(12,2),
    harga_pembanding NUMERIC(12,2),
    persentase_selisih NUMERIC(8,2),
    tanggal_deteksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE langganan_komoditas (
    id_langganan SERIAL PRIMARY KEY,
    id_pengguna INT NOT NULL REFERENCES pengguna(id_pengguna),
    id_komoditas INT NOT NULL REFERENCES komoditas(id_komoditas),
    tanggal_langganan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (id_pengguna, id_komoditas)
);

CREATE TABLE peringatan_harga (
    id_peringatan SERIAL PRIMARY KEY,
    id_pengguna INT NOT NULL REFERENCES pengguna(id_pengguna),
    id_komoditas INT NOT NULL REFERENCES komoditas(id_komoditas),
    pesan TEXT NOT NULL,
    tanggal_peringatan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'belum_dibaca'
);
