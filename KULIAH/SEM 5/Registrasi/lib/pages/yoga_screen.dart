import 'package:flutter/material.dart';

class YogaScreen extends StatelessWidget {
  const YogaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Progres yoga dummy
    const double yogaProgress = 0.8; // 80%

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Yoga & Meditasi',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFCD4D4),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard(yogaProgress),
            const SizedBox(height: 30),
            _buildSectionTitle('Rekomendasi Yoga'),
            _buildYogaList(),
            const SizedBox(height: 30),
            _buildSectionTitle('Sesi Meditasi'),
            _buildMeditationList(),
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
        color: const Color(0xFFFFCC80).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progres Yogamu',
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

  /// Widget untuk judul bagian
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    );
  }

  /// Widget untuk membuat daftar yoga
  Widget _buildYogaList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _YogaMeditationItem(
          title: 'Yoga untuk Pemula',
          duration: '15 Menit',
          icon: Icons.self_improvement,
        ),
        _YogaMeditationItem(
          title: 'Morning Flow',
          duration: '20 Menit',
          icon: Icons.ac_unit,
        ),
      ],
    );
  }

  /// Widget untuk membuat daftar meditasi
  Widget _buildMeditationList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _YogaMeditationItem(
          title: 'Meditasi Kesadaran',
          duration: '10 Menit',
          icon: Icons.lightbulb_outline,
        ),
        _YogaMeditationItem(
          title: 'Relaksasi Deep Breathing',
          duration: '5 Menit',
          icon: Icons.air,
        ),
      ],
    );
  }
}

/// Widget yang dapat digunakan kembali untuk item yoga/meditasi
class _YogaMeditationItem extends StatelessWidget {
  final String title;
  final String duration;
  final IconData icon;

  const _YogaMeditationItem({
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
