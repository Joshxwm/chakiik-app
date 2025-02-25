import 'package:chakiik_app/UI/Account/loginScreen.dart';
import 'package:chakiik_app/UI/Account/regScreen.dart';
import 'package:chakiik_app/UI/Start/HomeScreen.dart';
import 'package:chakiik_app/UI/Start/OnboardingScreen.dart';
import 'package:chakiik_app/UI/Start/logScreen.dart';
import 'package:chakiik_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chak iik’',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 113, 192, 216),
        ),
        useMaterial3: true,
      ),
      home: const LogScreen(), // Comienza en LogScreen
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegScreen(),
        '/home': (context) => HomeScreen(), // HomeScreen sin parámetros
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
