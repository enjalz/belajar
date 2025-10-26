import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task_model.dart'; // Impor model data

/// Kelas helper untuk mengelola semua operasi database SQLite.
class DatabaseHelper {
  // Gunakan pola Singleton untuk memastikan hanya ada satu instance database.
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  /// Getter untuk database.
  /// Jika database belum diinisialisasi, panggil _initDb().
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  /// Inisialisasi database.
  Future<Database> _initDb() async {
    // Dapatkan path direktori database
    String path = join(await getDatabasesPath(), 'todo.db');

    // Buka database. Jika belum ada, onCreate akan dijalankan.
    return await openDatabase(
      path,
      version: 2, // NAIKKAN VERSI database karena ada perubahan skema
      onCreate: _onCreate, // Panggil fungsi _onCreate saat database dibuat
      onUpgrade: _onUpgrade, // Panggil fungsi _onUpgrade saat versi naik
    );
  }

  /// Fungsi ini dijalankan saat database dibuat pertama kali.
  /// Digunakan untuk membuat tabel.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER NOT NULL,
        deadline TEXT 
      )
    ''');
  }

  /// Fungsi ini dijalankan saat versi database naik.
  /// Digunakan untuk migrasi data/skema.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Jika versi lama kurang dari 2, tambahkan kolom deadline
      try {
        await db.execute('ALTER TABLE tasks ADD COLUMN deadline TEXT');
      } catch (e) {
        print('Gagal menambah kolom deadline (mungkin sudah ada): $e');
      }
    }
  }

  // --- Operasi CRUD ---

  /// CREATE: Menambah Task baru ke database.
  Future<int> insertTask(Task task) async {
    Database db = await database;
    // 'id' akan di-generate otomatis oleh SQLite
    return await db.insert('tasks', task.toMap()..remove('id'));
  }

  /// READ: Mengambil semua Task dari database.
  Future<List<Task>> getTasks() async {
    Database db = await database;
    // Query semua data dari tabel 'tasks'
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Konversi List<Map> menjadi List<Task>
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  /// UPDATE: Memperbarui Task yang ada di database.
  Future<int> updateTask(Task task) async {
    Database db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?', // Tentukan task mana yang di-update berdasarkan ID
      whereArgs: [task.id],
    );
  }

  /// DELETE: Menghapus Task dari database.
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?', // Tentukan task mana yang dihapus berdasarkan ID
      whereArgs: [id],
    );
  }
}
