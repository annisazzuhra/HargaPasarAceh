const express = require('express');
const router = express.Router();

const verifikasiToken = require('../middleware/authMiddleware');

const {
    getPasar,
    getKomoditas,
    getHargaTerbaru,
    getRataRata,
    tambahLaporan,
    getLaporanSaya
} = require('../controllers/hargaController');

// Data yang dapat dilihat pengguna
router.get('/pasar', getPasar);
router.get('/komoditas', getKomoditas);
router.get('/terbaru', getHargaTerbaru);
router.get('/rata-rata', getRataRata);
