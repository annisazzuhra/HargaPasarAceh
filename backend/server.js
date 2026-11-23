
require('dotenv').config();

const app = require('./app');
const pool = require('./config/database');

const PORT = process.env.PORT || 3000;

const startServer = async () => {
    try {
        // Memastikan database dapat dihubungi
        await pool.query('SELECT 1');

        console.log('Koneksi PostgreSQL berhasil');

        app.listen(PORT, () => {
            console.log(
                `Server berjalan di http://localhost:${PORT}`
            );
        });

    } catch (error) {
        console.error(
            'Server gagal dijalankan:',
            error.message
        );

        process.exit(1);
    }
};

startServer();
