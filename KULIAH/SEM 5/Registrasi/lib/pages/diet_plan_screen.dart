import 'package:flutter/material.dart';

// Class untuk merepresentasikan pilihan diet
class DietOption {
  final String title;
  final String description;
  final IconData icon;

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
    // List data dummy untuk opsi diet
    const List<DietOption> dietOptions = [
      DietOption(
        title: 'Diet Mediterania',
        description: 'Fokus pada buah-buahan, sayuran, biji-bijian, dan lemak sehat.',
        icon: Icons.local_dining,
      ),
      DietOption(
        title: 'Diet Vegan',
        description: 'Membatasi semua produk hewani, termasuk daging, telur, dan susu.',
        icon: Icons.spa,
      ),
      DietOption(
        title: 'Diet Ketogenik (Keto)',
        description: 'Rendah karbohidrat, tinggi lemak untuk memaksa tubuh membakar lemak.',
        icon: Icons.fastfood,
      ),
      DietOption(
        title: 'Diet DASH',
        description: 'Dirancang untuk mengendalikan tekanan darah tinggi.',
        icon: Icons.monitor_heart,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rencana Diet',
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
              'Pilih Rencana Dietmu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Temukan rencana yang paling sesuai dengan gaya hidup dan tujuanmu.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dietOptions.length,
              itemBuilder: (context, index) {
                final option = dietOptions[index];
                return _buildDietCard(option);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Widget untuk membangun kartu pilihan diet
  Widget _buildDietCard(DietOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9A825).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(option.icon, color: const Color(0xFFF9A825), size: 30),
        ),
        title: Text(
          option.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF333333),
          ),
        ),
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
