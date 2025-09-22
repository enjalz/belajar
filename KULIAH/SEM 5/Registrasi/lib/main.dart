import 'package:flutter/material.dart';
import 'package:registrasi/pages/home_page.dart';
import 'package:registrasi/pages/register_page.dart';
import 'package:registrasi/pages/diet_plan_screen.dart';
import 'package:registrasi/pages/exercises_screen.dart';
import 'package:registrasi/pages/medical_screen.dart';
import 'package:registrasi/pages/yoga_screen.dart';

void main() {
  // ini fungsi utama yg pertama kali dijalanin pas app dibuka
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi dan Navigasi', // judul aplikasi
      theme: ThemeData(
        // atur tema warna aplikasi
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      initialRoute: '/', // halaman pertama yg dituju pas app dibuka
      routes: {
        // daftar semua halaman yg bisa diakses
        '/': (context) => const RegisterPage(), // halaman registrasi
        '/home': (context) => const HomeScreen(), // halaman utama setelah login
        '/diet': (context) => const DietPlanScreen(), // halaman diet plan
        '/exercises': (context) => const ExercisesScreen(), // halaman exercise
        '/medical': (context) => const MedicalScreen(), // halaman medical info
        '/yoga': (context) => const YogaScreen(), // halaman yoga
      },
      onGenerateRoute: (settings) {
        // ini dijalanin kalo ada route yg perlu penanganan khusus
        if (settings.name == '/home') {
          // ngecek apakah route yg dipanggil itu '/home'
          final args = settings.arguments as RegistrationData?;
          if (args != null) {
            // kalo ada data registrasi, tampilkan dialog sukses
            WidgetsBinding.instance.addPostFrameCallback((_) {
              RegistrationSuccessDialog.show(context, args);
            });
          }
          // balik ke halaman home
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return null; // kalo ga ketemu route, balik null aja
      },
    );
  }
}
