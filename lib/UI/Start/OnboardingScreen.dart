// Comienzo

import 'package:chakiik_app/UI/Account/loginScreen.dart';
import 'package:chakiik_app/UI/Account/regScreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "video": "assets/video/rain.mp4",
      "text": "Acceso directo a mapas de huracanes en tiempo real"
    },
    {
      "video": "assets/video/rain.mp4",
      "text":
          "Fomenta información más segura para el resguardo en épocas de huracanes, tormentas y más"
    },
    {
      "video": "assets/video/rain.mp4",
      "text": "Solicita ayuda y accede a refugios en casos de emergencia"
    },
  ];

  void _goToRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegScreen()),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Imagen de fondo
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_pages[index]["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Contenido de la pantalla
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png", // Asegúrate de tener el logo
                          height: 80,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Chak iik’ App",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 100),
                        Text(
                          _pages[index]["text"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Botón de navegación entre páginas
          Positioned(
            left: 16,
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _goToRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Para comenzar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Texto "Iniciar sesión"
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _goToLogin,
              child: const Text(
                "¿Ya tienes una cuenta?  Iniciar sesión",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
