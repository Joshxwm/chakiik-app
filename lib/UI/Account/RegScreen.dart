// Crear cuenta

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class regScreen extends StatefulWidget {
  const regScreen({super.key});

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Inicializa el video desde los assets
    _controller = VideoPlayerController.asset('assets/video/rain.mp4')
      ..initialize().then((_) {
        setState(() {}); // Redibuja la interfaz cuando el video esté listo
        _controller.play(); // Reproduce el video automáticamente
        _controller.setLooping(true); // Repite el video en bucle
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Libera el controlador cuando el widget se destruye
  }

  Future<void> _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada con éxito')),
      );
      Navigator.pop(context); // Regresa a la pantalla de inicio de sesión
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
      ),
      body: Stack(
        children: [
          // Fondo de video
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          // Contenido sobre el video
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Registrar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Regresa a la pantalla de inicio de sesión
                  },
                  child: const Text('¿Ya tienes cuenta? Inicia sesión aquí'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
