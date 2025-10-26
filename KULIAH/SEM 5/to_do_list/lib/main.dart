import 'package:flutter/material.dart';
import 'database_helper.dart'; // Impor database helper
import 'task_model.dart'; // Impor model data
// Impor paket intl untuk format tanggal
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async { // Ubah jadi async
  // Pastikan Flutter binding sudah siap sebelum menjalankan kode
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi data lokasi untuk format tanggal Indonesia
  await initializeDateFormatting('id_ID', null);
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Atur warna centang checkbox secara global
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.green; // Warna hijau saat dicentang
            }
            return null; // Warna default saat tidak dicentang
          }),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // Halaman utama aplikasi kita adalah TaskListScreen
      home: const TaskListScreen(),
    );
  }
}

// --- Halaman Utama (Layar 1): Menampilkan Daftar Tugas ---
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List untuk menampung data tugas dari database
  List<Task> _tasks = [];
  // Instance dari database helper
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = true; // Status loading data

  // Variabel state baru untuk progress bar
  int _completedTasks = 0;
  int _totalTasks = 0;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _refreshTaskList(); // Ambil data saat halaman pertama kali dibuka
  }

  /// Mengupdate variabel state untuk progress bar
  void _updateProgressStats() {
    if (_tasks.isEmpty) {
      _completedTasks = 0;
      _totalTasks = 0;
      _progress = 0.0;
    } else {
      _completedTasks = _tasks.where((t) => t.isDone).length;
      _totalTasks = _tasks.length;
      _progress = _totalTasks == 0 ? 0.0 : _completedTasks / _totalTasks;
    }
    // Tidak perlu setState di sini karena akan dipanggil di dalam _refreshTaskList
  }

  /// Mengambil data terbaru dari database dan memperbarui UI
  Future<void> _refreshTaskList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await _dbHelper.getTasks();
      setState(() {
        _tasks = data;
        _updateProgressStats(); // Panggil update progress di sini
        _isLoading = false;
      });
    } catch (e) {
      // Tangani error jika gagal mengambil data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
      setState(() {
        _tasks = [];
        _updateProgressStats(); // Reset progress saat error
        _isLoading = false;
      });
    }
  }

  /// Menavigasi ke halaman detail untuk menambah/edit tugas
  void _navigateToDetail({Task? task}) async {
    // Tunggu hasil dari halaman detail (apakah ada perubahan data)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );

    // Jika hasilnya 'true' (ada perubahan), refresh list
    if (result == true) {
      _refreshTaskList();
    }
  }

  /// Memperbarui status selesai/belum selesai
  Future<void> _toggleTaskDone(Task task) async {
    task.isDone = !task.isDone; // Ubah status
    await _dbHelper.updateTask(task); // Simpan ke database
    _refreshTaskList(); // Refresh UI
  }

  /// Menampilkan dialog konfirmasi sebelum menghapus
  void _showDeleteDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Tugas'),
        content: Text('Anda yakin ingin menghapus "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Tutup dialog
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(task.id!); // Hapus tugas
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Menghapus tugas dari database
  Future<void> _deleteTask(int id) async {
    try {
      await _dbHelper.deleteTask(id);
      _refreshTaskList(); // Refresh UI
      // Tampilkan Snackbar konfirmasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas berhasil dihapus'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus tugas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // Membuat AppBar dengan gradien biru
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        shadowColor: Colors.blue.withOpacity(0.5),
      ),
      // Gunakan Column untuk menampung progress bar dan list
      body: Column(
        children: [
          // Bagian 1: Progress Bar (Hanya tampil jika tidak loading & ada tugas)
          if (!_isLoading && _tasks.isNotEmpty) _buildProgressSection(),
          // Bagian 2: Konten Utama (Loading, Empty, or List)
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator()) // Tampilkan loading
                : _tasks.isEmpty
                ? const Center(
                child: Text(
                  'Tidak ada tugas.\nTekan tombol + untuk menambah.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ))
                : _buildTaskList(), // Tampilkan list jika data ada
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToDetail(), // Panggil fungsi navigasi
        child: Container(
          width: 60,
          height: 60,
          // Membuat FAB dengan gradien biru
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  /// Widget untuk membangun bagian progress bar (BARU)
  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress: $_completedTasks / $_totalTasks Selesai',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(_progress * 100).toStringAsFixed(0)}% Selesai',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk membangun ListView
  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            // Checkbox di sebelah kiri
            leading: Checkbox(
              value: task.isDone,
              onChanged: (value) => _toggleTaskDone(task),
              // activeColor: Colors.green, // Sudah diatur di ThemeData
            ),
            // Judul tugas
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone
                    ? TextDecoration.lineThrough // Coret jika selesai
                    : TextDecoration.none,
                color: task.isDone ? Colors.grey : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Subtitle (Deskripsi dan Deadline)
            subtitle: _buildSubtitle(task), // Gunakan helper
            // Tombol Edit dan Hapus di sebelah kanan
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tombol Edit
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _navigateToDetail(task: task),
                ),
                // Tombol Hapus
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteDialog(task),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Widget helper untuk membangun subtitle (Deskripsi & Deadline) (BARU)
  Widget? _buildSubtitle(Task task) {
    final hasDescription = task.description.isNotEmpty;
    final hasDeadline = task.deadline != null;

    if (!hasDescription && !hasDeadline) return null;

    // Cek apakah deadline sudah lewat dan belum selesai
    bool isOverdue = false;
    if (hasDeadline && !task.isDone) {
      isOverdue = task.deadline!.isBefore(DateTime.now());
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0), // Beri sedikit jarak dari judul
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasDescription)
            Text(
              task.description,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: task.isDone ? Colors.grey : Colors.black54,
              ),
            ),
          if (hasDeadline)
            Padding(
              padding: EdgeInsets.only(top: hasDescription ? 4.0 : 0),
              child: Text(
                // Format tanggal pakai intl
                'Deadline: ${DateFormat('EEE, dd MMM yyyy - HH:mm', 'id_ID').format(task.deadline!)}',
                style: TextStyle(
                  decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: task.isDone ? Colors.grey : (isOverdue ? Colors.red : Colors.blue[700]),
                  fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --- Halaman Detail (Layar 2): Menambah atau Mengedit Tugas ---
class TaskDetailScreen extends StatefulWidget {
  final Task? task; // Task yang akan diedit (null jika menambah baru)

  const TaskDetailScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk validasi form
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isEditing; // Tandai apakah ini mode edit atau tambah

  // State baru untuk deadline
  DateTime? _selectedDeadline;
  // Formatter untuk menampilkan tanggal
  final DateFormat _deadlineFormatter = DateFormat('EEE, dd MMM yyyy - HH:mm', 'id_ID');

  @override
  void initState() {
    super.initState();
    _isEditing = widget.task != null; // Cek apakah ini mode edit

    // Isi controller dengan data task jika ini mode edit
    _titleController = TextEditingController(text: _isEditing ? widget.task!.title : '');
    _descriptionController = TextEditingController(text: _isEditing ? widget.task!.description : '');
    // Isi state deadline jika mode edit
    _selectedDeadline = _isEditing ? widget.task!.deadline : null;
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget tidak digunakan
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Fungsi untuk memunculkan date & time picker (BARU)
  Future<void> _pickDeadline() async {
    // 1. Pilih Tanggal
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime(2000), // Bisa atur tanggal awal
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return; // User batal pilih tanggal

    // 2. Pilih Waktu
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDeadline ?? DateTime.now()),
    );

    if (pickedTime == null) return; // User batal pilih waktu

    // 3. Gabungkan dan update state
    setState(() {
      _selectedDeadline = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }


  /// Fungsi untuk menyimpan data (Create atau Update)
  Future<void> _saveTask() async {
    // Lakukan validasi form
    if (_formKey.currentState!.validate()) {
      try {
        final task = Task(
          id: _isEditing ? widget.task!.id : null, // ID tetap jika edit
          title: _titleController.text,
          description: _descriptionController.text,
          isDone: _isEditing ? widget.task!.isDone : false, // Status tetap jika edit
          deadline: _selectedDeadline, // Masukkan deadline
        );

        if (_isEditing) {
          await DatabaseHelper().updateTask(task); // Update data
        } else {
          await DatabaseHelper().insertTask(task); // Insert data baru
        }

        // Tampilkan Snackbar konfirmasi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing ? 'Tugas berhasil diperbarui' : 'Tugas berhasil ditambah'),
            backgroundColor: Colors.green,
          ),
        );

        // Kembali ke halaman list dan kirim sinyal 'true' (ada perubahan)
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan tugas: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Tugas' : 'Tambah Tugas',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // AppBar dengan gradien biru
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Pasang kunci form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextField untuk Judul
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Tugas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                // Validasi: Judul tidak boleh kosong
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // TextField untuk Deskripsi
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (Opsional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4, // Buat agar bisa multi-baris
              ),
              const SizedBox(height: 16),
              // --- Input Deadline (BARU) ---
              InkWell(
                onTap: _pickDeadline,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedDeadline == null
                              ? 'Ketuk untuk memilih deadline'
                              : _deadlineFormatter.format(_selectedDeadline!),
                          style: TextStyle(
                            color: _selectedDeadline == null ? Colors.grey[600] : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (_selectedDeadline != null)
                      // Tombol clear deadline
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDeadline = null;
                            });
                          },
                          child: const Icon(Icons.clear, color: Colors.red, size: 20),
                        )
                    ],
                  ),
                ),
              ),
              // --- Akhir Input Deadline ---
              const SizedBox(height: 24),
              // Tombol Simpan
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0), // Hapus padding default
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Ink(
                  // Widget Ink untuk menampilkan gradien di atas button
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      'SIMPAN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
