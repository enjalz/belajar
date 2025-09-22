import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bikin nilai dummy untuk progres latihan (60%)
    const double exerciseProgress = 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'latihan harian',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFCD4D4),
        centerTitle: true, // biar judulnya di tengah
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // judul halaman
            const Text(
              'workout hari ini',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 30),
            // tampilkan kartu progres latihan
            _buildProgressCard(exerciseProgress),
            const SizedBox(height: 30),
            // bagian rekomendasi latihan
            const Text(
              'rekomendasi latihan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 15),
            // list latihan
            _buildExerciseList(),
          ],
        ),
      ),
    );
  }

  // widget untuk bikin kartu progres latihan
  Widget _buildProgressCard(double progress) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9A825).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'progres latihanmu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          // teks keterangan berapa persen progres hari ini
          Text(
            'kamu sudah menyelesaikan ${(progress * 100).toInt()}% dari targetmu hari ini.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 15),
          // bar progres
          LinearProgressIndicator(
            value: progress, // nilainya dari variabel progress
            backgroundColor: Colors.grey.shade300,
            color: const Color(0xFFF9A825),
            borderRadius: BorderRadius.circular(10),
            minHeight: 12,
          ),
        ],
      ),
    );
  }

  // widget untuk bikin daftar latihan
  Widget _buildExerciseList() {
    return ListView(
      shrinkWrap: true, // biar nggak ambil tinggi layar penuh
      physics: const NeverScrollableScrollPhysics(), // scroll ikut parent
      children: const [
        // item latihan satu-satu
        _ExerciseItem(
          title: 'lari pagi',
          duration: '30 menit',
          icon: Icons.directions_run,
        ),
        _ExerciseItem(
          title: 'push-up',
          duration: '3 set x 10 reps',
          icon: Icons.fitness_center,
        ),
        _ExerciseItem(
          title: 'squat',
          duration: '3 set x 12 reps',
          icon: Icons.line_weight,
        ),
      ],
    );
  }
}

// widget reusable untuk setiap item latihan
class _ExerciseItem extends StatelessWidget {
  final String title; // nama latihannya
  final String duration; // lama / jumlah set latihannya
  final IconData icon; // ikon yang ditampilkan

  const _ExerciseItem({
    required this.title,
    required this.duration,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // icon di sebelah kiri
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9A825).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFF9A825)),
          ),
          const SizedBox(width: 15),
          // teks judul dan durasi latihan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  duration,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // icon panah kecil di kanan
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
