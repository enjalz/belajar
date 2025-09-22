import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Progres latihan dummy
    const double exerciseProgress = 0.6; // 60%

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Latihan Harian',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFCD4D4),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Hari Ini',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 30),
            _buildProgressCard(exerciseProgress),
            const SizedBox(height: 30),
            const Text(
              'Rekomendasi Latihan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 15),
            _buildExerciseList(),
          ],
        ),
      ),
    );
  }

  /// Widget untuk menampilkan kartu progres
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
            'Progres Latihanmu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Kamu sudah menyelesaikan ${(progress * 100).toInt()}% dari targetmu hari ini.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: const Color(0xFFF9A825),
            borderRadius: BorderRadius.circular(10),
            minHeight: 12,
          ),
        ],
      ),
    );
  }

  /// Widget untuk membuat daftar latihan
  Widget _buildExerciseList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _ExerciseItem(
          title: 'Lari Pagi',
          duration: '30 Menit',
          icon: Icons.directions_run,
        ),
        _ExerciseItem(
          title: 'Push-up',
          duration: '3 Set x 10 Reps',
          icon: Icons.fitness_center,
        ),
        _ExerciseItem(
          title: 'Squat',
          duration: '3 Set x 12 Reps',
          icon: Icons.line_weight,
        ),
      ],
    );
  }
}

/// Widget yang dapat digunakan kembali untuk setiap item latihan
class _ExerciseItem extends StatelessWidget {
  final String title;
  final String duration;
  final IconData icon;

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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9A825).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFF9A825)),
          ),
          const SizedBox(width: 15),
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
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
