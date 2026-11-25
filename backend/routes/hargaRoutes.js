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
