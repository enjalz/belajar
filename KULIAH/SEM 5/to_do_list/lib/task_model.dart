/// Model data untuk sebuah Task.
///
/// Ini merepresentasikan struktur data yang akan kita simpan di SQLite.
class Task {
  int? id; // ID unik untuk database, bisa null jika belum disimpan
  String title; // Judul tugas
  String description; // Deskripsi tugas
  bool isDone; // Status selesai
  DateTime? deadline; // Waktu deadline tugas (BARU)

  Task({
    this.id,
    required this.title,
    this.description = '', // Default deskripsi kosong
    this.isDone = false, // Default belum selesai
    this.deadline, // Tambahkan deadline di constructor
  });

  /// Konversi objek Task menjadi Map.
  /// Ini digunakan saat menyimpan data ke SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // Konversi boolean ke integer (SQLite tidak punya tipe boolean)
      'isDone': isDone ? 1 : 0,
      // Konversi DateTime ke string ISO 8601 (format standar)
      'deadline': deadline?.toIso8601String(),
    };
  }

  /// Konversi Map dari SQLite menjadi objek Task.
  /// Ini digunakan saat membaca data dari SQLite.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      // Konversi integer kembali ke boolean
      isDone: map['isDone'] == 1,
      // Konversi string kembali ke DateTime (jika tidak null)
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
    );
  }
}
