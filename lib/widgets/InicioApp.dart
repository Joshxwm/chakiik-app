//Inicio del logo Chak iik'

import 'package:flutter/material.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp>
    with SingleTickerProviderStateMixin {
  // Controlador de animación
  late AnimationController _controller;
  // Animación de escala
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Inicialización del controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Definir la animación de escala
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Iniciar la animación
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 185, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación del logo
            ScaleTransition(
              scale: _animation, // Aplicar animación de escala
              child: Image.asset(
                'assets/images/Inicio_Aplicacion.jpg', // Asegúrate de que la imagen esté en la carpeta correcta
                width: 400,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
