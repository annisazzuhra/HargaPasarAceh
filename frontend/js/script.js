// Mengambil form laporan
const reportForm = document.getElementById("reportForm");

// Menjalankan fungsi ketika form dikirim
reportForm.addEventListener("submit", function(event) {

    // Mencegah halaman refresh
    event.preventDefault();

    // Mengambil data dari form
    const nama = document.getElementById("nama").value;
    const pasar = document.getElementById("pasar").value;
    const komoditas = document.getElementById("komoditas").value;
    const harga = document.getElementById("harga").value;

    // Menampilkan laporan
    alert(
        "Laporan berhasil dikirim!\n\n" +
        "Nama: " + nama + "\n" +
        "Pasar: " + pasar + "\n" +
        "Komoditas: " + komoditas + "\n" +
        "Harga: Rp " + Number(harga).toLocaleString("id-ID")
    );

    // Mengosongkan form
    reportForm.reset();
});

