import 'package:flutter/material.dart';

// class buat nyimpen data opsi diet
class DietOption {
  final String title; // judul diet
  final String description; // deskripsi singkat diet
  final IconData icon; // icon yang dipake buat diet ini

  const DietOption({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bikin list dummy untuk opsi diet
    const List<DietOption> dietOptions = [
      DietOption(
        title: 'diet mediterania',
        description: 'fokus pada buah-buahan, sayuran, biji-bijian, dan lemak sehat.',
        icon: Icons.local_dining,
      ),
      DietOption(
        title: 'diet vegan',
        description: 'membatasi semua produk hewani, termasuk daging, telur, dan susu.',
        icon: Icons.spa,
      ),
      DietOption(
        title: 'diet ketogenik (keto)',
        description: 'rendah karbohidrat, tinggi lemak untuk memaksa tubuh membakar lemak.',
        icon: Icons.fastfood,
      ),
      DietOption(
        title: 'diet dash',
        description: 'dirancang untuk mengendalikan tekanan darah tinggi.',
        icon: Icons.monitor_heart,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'rencana diet',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFCD4D4),
        centerTitle: true, // bikin judul di tengah
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // judul halaman
            const Text(
              'pilih rencana dietmu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            // subjudul kecil
            const Text(
              'temukan rencana yang paling sesuai dengan gaya hidup dan tujuanmu.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // bikin list opsi diet
            ListView.builder(
              shrinkWrap: true, // biar listnya ikut tinggi konten
              physics: const NeverScrollableScrollPhysics(), // biar scroll ikut parent
              itemCount: dietOptions.length,
              itemBuilder: (context, index) {
                final option = dietOptions[index];
                return _buildDietCard(option); // panggil widget kartu diet
              },
            ),
          ],
        ),
      ),
    );
  }

  // widget untuk bikin 1 kartu pilihan diet
  Widget _buildDietCard(DietOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // jarak antar kartu
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5), // bikin efek bayangan
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        // icon di sebelah kiri
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9A825).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(option.icon, color: const Color(0xFFF9A825), size: 30),
        ),
        // judul diet
        title: Text(
          option.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF333333),
          ),
        ),
        // deskripsi diet
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            option.description,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
