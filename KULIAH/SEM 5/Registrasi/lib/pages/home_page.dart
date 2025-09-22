import 'package:flutter/material.dart';
// Import file register_page biar bisa ambil data registrasi (RegistrationData)
import 'register_page.dart';

// =======================================================
// CLASS 1: DIALOG POP-UP (Muncul setelah registrasi sukses)
// =======================================================
class RegistrationSuccessDialog extends StatelessWidget {

  final RegistrationData data; // Data yang dikirim dari halaman registrasi
  const RegistrationSuccessDialog({super.key, required this.data});

  // Fungsi static biar gampang manggil dialog ini dari mana aja
  static Future<void> show(BuildContext context, RegistrationData data) {
    return showDialog(
      context: context,
      barrierDismissible: false, // Dialog ga bisa ditutup klik luar
      builder: (BuildContext context) {
        return RegistrationSuccessDialog(data: data);
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const Text('Registrasi Berhasil!'), // Judul popup
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // Tampilkan data user yang baru daftar
            Text('Nama: ${data.name}'),
            const SizedBox(height: 4),
            Text('Email: ${data.email}'),
            const SizedBox(height: 4),
            Text('Jenis Kelamin: ${data.gender}'),
            const SizedBox(height: 4),
            Text('Kota Lahir: ${data.city}'),
            const SizedBox(height: 4),
            Text('Tanggal Lahir: ${data.birthdate}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            // Tutup dialog
            Navigator.of(context).pop();

            // Pindah ke HomeScreen dan hapus halaman sebelumnya
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false, // hapus semua route lama
            );
          },
        ),
      ],
    );
  }
}

// =======================================================
// CLASS 2: HOME SCREEN (Halaman utama setelah registrasi)
// =======================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bagian background atas
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/pink.png', // Pastikan file ini ada di folder assets
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) => Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.pink.shade100, // fallback kalo gambar ga ada
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildHeader(), // Bagian header (sapaan)
                        const SizedBox(height: 30),
                        _buildSearchBar(), // Search bar
                        const SizedBox(height: 30),
                        _buildGridMenu(context), // Grid menu fitur
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                _buildBottomNavBar(), // Bottom navigation bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian Header: Ada menu icon + sapaan
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ikon menu di kanan atas
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9A825).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu,
              color: Color(0xFFF9A825),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Sapaan user
        const Text(
          'Good Morning\nDunjali',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  /// Search Bar di bawah header
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search', // placeholder
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Grid Menu untuk fitur utama aplikasi
  Widget _buildGridMenu(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // 2 kolom
      shrinkWrap: true, // biar grid bisa scroll bareng column
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        // Card fitur diet plan
        FeatureCard(
          title: 'Diet Plan',
          imagePath: 'images/diet.png',
          onTap: () => Navigator.of(context).pushNamed('/diet'),
        ),
        // Card fitur exercises
        FeatureCard(
          title: 'Exercises',
          imagePath: 'images/exercise.png',
          onTap: () => Navigator.of(context).pushNamed('/exercises'),
        ),
        // Card fitur medical tips
        FeatureCard(
          title: 'Medical Tips',
          imagePath: 'images/medical.png',
          onTap: () => Navigator.of(context).pushNamed('/medical'),
        ),
        // Card fitur yoga
        FeatureCard(
          title: 'Yoga',
          imagePath: 'images/yoga.png',
          onTap: () => Navigator.of(context).pushNamed('/yoga'),
        ),
      ],
    );
  }

  /// Bottom navigation bar custom (tiga tombol)
  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            icon: Icons.calendar_today_outlined,
            label: 'Today',
          ),
          BottomNavItem(
            icon: Icons.settings,
            label: 'Settings',
            isActive: true,
          ),
          BottomNavItem(
            icon: Icons.calendar_today,
            label: 'Tomorrow',
          ),
        ],
      ),
    );
  }
}

// =======================================================
// WIDGET BANTUAN (Reusable components)
// =======================================================

/// Kartu menu untuk setiap fitur
class FeatureCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Biar kartu bisa diklik
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// Item untuk bottom navigation bar
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive; // Biar tau icon yang lagi aktif

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFFF9A825); // warna item aktif
    final Color inactiveColor = Colors.grey.shade500; // warna item pasif

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? activeColor : inactiveColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
