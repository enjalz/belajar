import 'package:flutter/material.dart';
import 'package:registrasi/pages/home_page.dart';
import 'package:registrasi/pages/register_page.dart';
import 'package:registrasi/pages/diet_plan_screen.dart';
import 'package:registrasi/pages/exercises_screen.dart';
import 'package:registrasi/pages/medical_screen.dart';
import 'package:registrasi/pages/yoga_screen.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrasi dan Navigasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterPage(),
        '/home': (context) => const HomeScreen(),
        '/diet': (context) => const DietPlanScreen(),
        '/exercises': (context) => const ExercisesScreen(),
        '/medical': (context) => const MedicalScreen(),
        '/yoga': (context) => const YogaScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments as RegistrationData?;
          if (args != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              RegistrationSuccessDialog.show(context, args);
            });
          }
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return null;
      },
    );
  }
}
