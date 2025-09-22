// Tugas 1 Mobile Programming
// Buatlah sebuah program sederhana menggunakan Dart yang memodelkan Mahasiswa dengan atribut dan perilaku tertentu. Program harus menerapkan class, constructor, method, dan object.
// Nama : Angel Fransisca Wijaya
// NIM  : 825230065

// Import file 825230065_mahasiswa.dart
import '825230065_mahasiswa.dart';

void main() {
  // Membuat 3 object Mahasiswa
  var mahasiswa1 = Mahasiswa('Angel Fransisca Wijaya', '825230065', 'Sistem Informasi', 4.00);
  var mahasiswa2 = Mahasiswa('Aldho Brawijaya', '525230032', 'Teknik Informatika', 3.40);
  var mahasiswa3 = Mahasiswa('Gregorius Theodore', '825230078', 'Sistem Informasi', 3.00);

  // Memanggil method perkenalan() dan cekKelulusan()
  mahasiswa1.perkenalan();
  mahasiswa1.cekKelulusan();

  mahasiswa2.perkenalan();
  mahasiswa2.cekKelulusan();

  mahasiswa3.perkenalan();
  mahasiswa3.cekKelulusan();
}
