import 'package:flutter/material.dart';
// import file register_page biar bisa ambil data registrasi (registrationdata)
import 'register_page.dart';

// class pop up dialog setelah registrasi sukses
class RegistrationSuccessDialog extends StatelessWidget {
  final RegistrationData data; // data yang dikirim dari halaman registrasi
  const RegistrationSuccessDialog({super.key, required this.data});

  // bikin function static biar gampang panggil pop up ini dari mana aja
  static Future<void> show(BuildContext context, RegistrationData data) {
    return showDialog(
      context: context,
      barrierDismissible: false, // ga bisa tutup kalo klik di luar dialog
      builder: (BuildContext context) {
        return RegistrationSuccessDialog(data: data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrasi Berhasil!'), // judul pop up
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // tampilkan data user yang baru daftar
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
            // tutup dialog
            Navigator.of(context).pop();

            // pindah ke homescreen, hapus semua halaman sebelumnya
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );
  }
}

// halaman utama setelah registrasi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // gambar background di bagian atas
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/pink.png',
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) => Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.pink.shade100, // fallback kalo gambar ga ketemu
              ),
            ),
          ),

          // isi utama halaman
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
                        _buildHeader(), // bagian header / sapaan
                        const SizedBox(height: 30),
                        _buildSearchBar(), // search bar
                        const SizedBox(height: 30),
                        _buildGridMenu(context), // menu utama berbentuk grid
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                _buildBottomNavBar(), // bottom nav bar di bawah
              ],
            ),
          ),
        ],
      ),
    );
  }

  // bagian header: ada menu icon + sapaan user
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ikon menu di pojok kanan atas
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
        // sapaan user
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

  // search bar di bawah header
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
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

  // menu grid untuk fitur utama
  Widget _buildGridMenu(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        // card fitur exercises
        FeatureCard(
          title: 'Exercises',
          imagePath: 'images/exercise.png',
          onTap: () => Navigator.of(context).pushNamed('/exercises'),
        ),
        // card fitur medical tips
        FeatureCard(
          title: 'Medical Tips',
          imagePath: 'images/medical.png',
          onTap: () => Navigator.of(context).pushNamed('/medical'),
        ),
        // card fitur yoga
        FeatureCard(
          title: 'Yoga',
          imagePath: 'images/yoga.png',
          onTap: () => Navigator.of(context).pushNamed('/yoga'),
        ),
      ],
    );
  }

  // bottom nav bar custom
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

// kartu menu untuk tiap fitur
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
      onTap: onTap, // biar kartu bisa diklik
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

// item untuk bottom navigation bar
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFFF9A825);
    final Color inactiveColor = Colors.grey.shade500;

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
