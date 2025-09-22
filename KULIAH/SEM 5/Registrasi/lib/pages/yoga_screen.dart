import 'package:flutter/material.dart';

class YogaScreen extends StatelessWidget {
  const YogaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ini cuma data dummy buat nunjukin progres yoga (80%)
    const double yogaProgress = 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // judul app bar di atas layar
        title: const Text('Yoga & Meditasi',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFCD4D4), // warna background app bar
        centerTitle: true, // biar judulnya di tengah
      ),
      body: SingleChildScrollView(
        // biar body bisa discroll kalau kontennya panjang
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard(yogaProgress), // nunjukin kartu progres yoga
            const SizedBox(height: 30), // jarak biar ga dempet
            _buildSectionTitle('Rekomendasi Yoga'), // judul bagian yoga
            _buildYogaList(), // list yoga yg direkomendasi
            const SizedBox(height: 30),
            _buildSectionTitle('Sesi Meditasi'), // judul bagian meditasi
            _buildMeditationList(), // list meditasi yg direkomendasi
          ],
        ),
      ),
    );
  }

  // bikin widget buat nampilin kartu progres yoga
  Widget _buildProgressCard(double progress) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC80).withOpacity(0.2), // warna background soft
        borderRadius: BorderRadius.circular(20), // biar ujungnya rounded
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
          // teks keterangan berapa % yang sudah selesai
          Text(
            'Kamu sudah menyelesaikan ${(progress * 100).toInt()}% dari targetmu hari ini.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 15),
          // indikator progress bar
          LinearProgressIndicator(
            value: progress, // nilai progress (0.8 = 80%)
            backgroundColor: Colors.grey.shade300,
            color: const Color(0xFFF9A825), // warna bar-nya
            borderRadius: BorderRadius.circular(10),
            minHeight: 12,
          ),
        ],
      ),
    );
  }

  // bikin judul bagian biar konsisten stylenya
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

  // bikin daftar yoga
  Widget _buildYogaList() {
    return ListView(
      shrinkWrap: true, // biar muat di dalam scroll utama
      physics: const NeverScrollableScrollPhysics(), // ga perlu scroll sendiri
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

  // bikin daftar meditasi
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

// widget reusable untuk yoga dan meditasi biar ga perlu bikin 2 kali
class _YogaMeditationItem extends StatelessWidget {
  final String title; // judul yoga/meditasi
  final String duration; // durasi latihannya
  final IconData icon; // icon yg ditampilkan

  const _YogaMeditationItem({
    required this.title,
    required this.duration,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), // jarak antar item
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          // bayangan biar keliatan kayak kartu
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // kotak kecil berisi icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9A825).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFF9A825)),
          ),
          const SizedBox(width: 15),
          // teks judul dan durasi
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
          // icon panah di ujung kanan
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
