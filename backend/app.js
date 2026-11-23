
const express = require('express');
const cors = require('cors');

const authRoutes = require('./routes/authRoutes');
const hargaRoutes = require('./routes/hargaRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Halaman utama API
app.get('/', (req, res) => {
    res.json({
        message: 'Selamat datang di API HargaPasar Aceh'
    });
});

// Route autentikasi
app.use('/api/auth', authRoutes);

// Route harga dan pasar
app.use('/api', hargaRoutes);

// Route tidak ditemukan
app.use((req, res) => {
    res.status(404).json({
        message: 'Endpoint tidak ditemukan'
    });
});

// Penanganan kesalahan umum
app.use((error, req, res, next) => {
    console.error(error);

    res.status(500).json({
        message: 'Terjadi kesalahan pada server'
    });
});

module.exports = app;
