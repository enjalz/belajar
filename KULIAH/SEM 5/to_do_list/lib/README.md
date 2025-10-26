Aplikasi: To-Do List
Pembuat: Angel Fransisca Wijaya
NIM: 825230065

🌟 Pendahuluan
Ini adalah aplikasi To-Do List sederhana yang dibuat dengan Flutter. Aplikasi ini memungkinkan pengguna untuk membuat, membaca, memperbarui, dan menghapus (CRUD) tugas. Semua data disimpan secara lokal di perangkat menggunakan database SQLite, sehingga data tetap ada meskipun aplikasi ditutup.

✨ Fitur Utama
- Penyimpanan Lokal: Menggunakan sqflite untuk menyimpan data di database SQLite.
- Operasi CRUD:
  - ➕ Create: Menambah tugas baru melalui halaman khusus.
  - 📄 Read: Menampilkan semua tugas di halaman utama.
  - ✏️ Update: Mengedit tugas (judul, deskripsi) dan menandai tugas sebagai selesai (atau belum).
  - ❌ Delete: Menghapus tugas dengan dialog konfirmasi.
- Tandai Selesai: Tugas dapat ditandai selesai menggunakan checkbox.
- Deadline Task: Setiap tugas dapat diberi tanggal & waktu deadline.
- Progress Bar: Menampilkan progress total tugas selesai / semua tugas.

📱 Tampilan Layar:
- TaskListScreen: Halaman utama untuk menampilkan semua tugas dalam bentuk ListView, lengkap dengan progress bar.
- TaskDetailScreen: Halaman untuk menambah atau mengedit tugas (judul, deskripsi, deadline).

✅ Validasi Form: 
- Memastikan judul tugas tidak boleh kosong sebelum disimpan.

🧩 UI Komponen:
- ListView: Untuk menampilkan daftar tugas.
- Checkbox: Untuk memberi tanda tugas sudah selesai.
- TextField: Untuk input judul dan deskripsi.
- Date & Time Picker: Untuk memilih deadline.
- ElevatedButton: Untuk menyimpan data.
- Dialog: Untuk konfirmasi penghapusan.
- SnackBar: Untuk notifikasi setelah aksi (simpan, hapus).
- Progress Indicator: Untuk menampilkan perkembangan penyelesaian tugas.

🌙 State Management:
- Menggunakan StatefulWidget.

🎨 Desain Kustom: 
- AppBar dan Button memiliki latar belakang gradien biru.
- Tampilan bersih dan sederhana, mudah digunakan.

🚀 Cara Menjalankan
1. Pastikan Anda memiliki Flutter SDK.
   - Lihat dokumentasi instalasi Flutter jika belum.
2. Buat Proyek Flutter Baru:
    flutter create todo_app
    cd todo_app
3. Tambahkan Dependencies:
   - Salin konten dari berkas pubspec.yaml yang saya sediakan ke dalam berkas pubspec.yaml proyek Anda.
   - Jalankan flutter pub get di terminal.
4. Salin Kode Aplikasi:
   - Buat folder lib (jika belum ada).
   - Salin konten task_model.dart, database_helper.dart, dan main.dart ke dalam folder lib proyek Anda, sesuai dengan nama berkasnya.
5. Jalankan Aplikasi:
    flutter run

🏗️ Struktur Berkas
todo_app/
├── lib/
│   ├── task_model.dart       # Model data untuk Task
│   ├── database_helper.dart  # Logika helper SQLite
│   └── main.dart             # UI utama + progress + navigasi
├── pubspec.yaml              # Konfigurasi dependencies
└── README.md                 # Dokumentasi
