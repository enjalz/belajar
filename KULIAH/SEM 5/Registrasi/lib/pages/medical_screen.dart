import 'package:flutter/material.dart';
import 'dart:math';

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  // controller buat ambil input dari user (tinggi & berat)
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // variabel buat nampilin hasil bmi
  String _resultText = '';
  Color _resultColor = Colors.black;

  @override
  void dispose() {
    // bersihin controller biar gak ada memory leak
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    // ambil input tinggi & berat, terus ubah jadi angka (double)
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    // cek kalo input gak valid (kosong atau <= 0)
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _resultText = 'masukkan tinggi dan berat badan yang valid.'; // pesan error
        _resultColor = Colors.red; // teksnya jadi merah
      });
      return;
    }

    // ubah tinggi dari cm ke meter
    final double heightInMeters = height / 100;

    // hitung bmi dengan rumus = berat / (tinggi^2)
    final double bmi = weight / pow(heightInMeters, 2);

    // tentuin status berdasarkan hasil bmi
    String status;
    if (bmi < 18.5) {
      status = 'kekurangan berat badan.'; // kurus
      _resultColor = const Color(0xFFF9A825); // kuning
    } else if (bmi >= 18.5 && bmi < 24.9) {
      status = 'berat badan normal (sehat).'; // ideal
      _resultColor = Colors.green;
    } else if (bmi >= 25 && bmi < 29.9) {
      status = 'kelebihan berat badan.'; // overweight
      _resultColor = const Color(0xFFF9A825); // kuning lagi
    } else {
      status = 'obesitas.'; // berat banget
      _resultColor = Colors.red;
    }

    // kasih rekomendasi sesuai kategori bmi
    String recommendation;
    if (bmi < 25) {
      recommendation =
          'pertahankan gaya hidup sehatmu dengan pola makan seimbang dan rutin berolahraga.';
    } else if (bmi >= 25 && bmi < 30) {
      recommendation =
          'disarankan untuk mulai berolahraga secara teratur dan perhatikan asupan makananmu.';
    } else {
      recommendation =
          'kondisi ini membutuhkan perhatian lebih. sangat disarankan untuk berkonsultasi dengan dokter untuk mendapatkan rencana kesehatan yang tepat.';
    }

    // update state supaya ui-nya berubah sesuai hasil
    setState(() {
      _resultText =
          'bmi-mu adalah ${bmi.toStringAsFixed(2)}. ini menunjukkan kamu berada dalam kategori "$status"\n\n$recommendation';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cek Kesehatan',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFCD4D4), // warna pink muda biar soft
        centerTitle: true, // judul di tengah
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // judul halaman
            const Text(
              'Periksa BMI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            // penjelasan singkat
            const Text(
              'Masukkan tinggi dan berat badanmu untuk melihat kondisi kesehatanmu.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // input tinggi
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tinggi (cm)',
                hintText: 'Misalnya, 175',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 20),

            // input berat
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Badan (kg)',
                hintText: 'Misalnya, 70',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 30),

            // tombol untuk hitung bmi
            ElevatedButton(
              onPressed: _calculateBMI, // panggil fungsi hitung
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9A825), // warna tombol kuning
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Hitung BMI',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            // hasil bmi (kalau ada)
            if (_resultText.isNotEmpty) ...[
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _resultColor.withOpacity(0.1), // background sesuai kategori
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: _resultColor.withOpacity(0.5)),
                ),
                child: Text(
                  _resultText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _resultColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
