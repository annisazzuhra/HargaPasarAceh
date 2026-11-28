// =================================
// AUTENTIKASI PENGGUNA
// =================================

const loginForm = document.getElementById('loginForm');
const registerForm = document.getElementById('registerForm');

function tampilkanPesan(pesan, tipe) {
    const elemen = document.getElementById('authMessage');

    if (elemen) {
        elemen.textContent = pesan;
        elemen.className = `message ${tipe}`;
    }
}

// Mengunci tombol saat permintaan berjalan
function aturTombol(form, sibuk, teks) {
    const tombol = form.querySelector('button[type="submit"]');

    if (!tombol) return;

    if (!tombol.dataset.label) {
        tombol.dataset.label = tombol.textContent.trim();
    }

    tombol.disabled = sibuk;
    tombol.textContent = sibuk ? teks : tombol.dataset.label;
}

// Pengguna yang sudah masuk langsung diarahkan ke dashboard
if (loginForm && getToken()) {
    window.location.replace('dashboard.html');
}

// PROSES LOGIN
if (loginForm) {
    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        aturTombol(loginForm, true, 'Memproses...');

        try {
            const hasil = await apiRequest('/auth/login', {
                method: 'POST',
                body: JSON.stringify({ email, password })
            });

            localStorage.setItem('token', hasil.token);
            localStorage.setItem(
                'pengguna',
                JSON.stringify(hasil.pengguna)
            );

            tampilkanPesan('Login berhasil! Mengalihkan...', 'success');

            setTimeout(() => {
                window.location.href = 'dashboard.html';
            }, 500);

        } catch (error) {
            tampilkanPesan(error.message, 'error');
            aturTombol(loginForm, false);
        }
    });
}


// PROSES REGISTRASI
if (registerForm) {
    registerForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const nama = document.getElementById('nama').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        aturTombol(registerForm, true, 'Mendaftarkan...');

        try {
            await apiRequest('/auth/register', {
                method: 'POST',
                body: JSON.stringify({ nama, email, password })
            });

            tampilkanPesan(
                'Registrasi berhasil! Mengalihkan ke halaman masuk...',
                'success'
            );

            registerForm.reset();

            setTimeout(() => {
                window.location.href = 'login.html';
            }, 1200);

        } catch (error) {
            tampilkanPesan(error.message, 'error');
        } finally {
            aturTombol(registerForm, false);
        }
    });
}
