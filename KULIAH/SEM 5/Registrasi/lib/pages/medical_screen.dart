import 'package:flutter/material.dart';
import 'dart:math';

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _resultText = '';
  Color _resultColor = Colors.black;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    // Mengambil nilai dari controller, konversi ke double
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    // Validasi input
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _resultText = 'Masukkan tinggi dan berat badan yang valid.';
        _resultColor = Colors.red;
      });
      return;
    }

    // Konversi tinggi dari cm ke meter
    final double heightInMeters = height / 100;

    // Menghitung BMI
    final double bmi = weight / pow(heightInMeters, 2);

    // Menentukan status kesehatan berdasarkan BMI
    String status;
    if (bmi < 18.5) {
      status = 'Kekurangan berat badan.';
      _resultColor = const Color(0xFFF9A825);
    } else if (bmi >= 18.5 && bmi < 24.9) {
      status = 'Berat badan normal (sehat).';
      _resultColor = Colors.green;
    } else if (bmi >= 25 && bmi < 29.9) {
      status = 'Kelebihan berat badan.';
      _resultColor = const Color(0xFFF9A825);
    } else {
      status = 'Obesitas.';
      _resultColor = Colors.red;
    }

    // Menentukan rekomendasi
    String recommendation;
    if (bmi < 25) {
      recommendation =
      'Pertahankan gaya hidup sehatmu dengan pola makan seimbang dan rutin berolahraga.';
    } else if (bmi >= 25 && bmi < 30) {
      recommendation =
      'Disarankan untuk mulai berolahraga secara teratur dan perhatikan asupan makananmu.';
    } else {
      recommendation =
      'Kondisi ini membutuhkan perhatian lebih. Sangat disarankan untuk berkonsultasi dengan dokter untuk mendapatkan rencana kesehatan yang tepat.';
    }

    // Update state untuk menampilkan hasil
    setState(() {
      _resultText =
      'BMI-mu adalah ${bmi.toStringAsFixed(2)}. Ini menunjukkan kamu berada dalam kategori "$status"\n\n$recommendation';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cek Kesehatan',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFCD4D4),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Periksa BMI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Masukkan tinggi dan berat badanmu untuk melihat kondisi kesehatanmu.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
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
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9A825),
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
            if (_resultText.isNotEmpty) ...[
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _resultColor.withOpacity(0.1),
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
