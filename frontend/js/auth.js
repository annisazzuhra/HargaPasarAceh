
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

// PROSES LOGIN
if (loginForm) {
    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

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

            tampilkanPesan('Login berhasil!', 'success');

            window.location.href = 'dashboard.html';

        } catch (error) {
            tampilkanPesan(error.message, 'error');
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

        try {
            await apiRequest('/auth/register', {
                method: 'POST',
                body: JSON.stringify({
                    nama,
                    email,
                    password
                })
            });

            tampilkanPesan(
                'Registrasi berhasil! Silakan masuk.',
                'success'
            );

            registerForm.reset();

        } catch (error) {
            tampilkanPesan(error.message, 'error');
        }
    });
}
