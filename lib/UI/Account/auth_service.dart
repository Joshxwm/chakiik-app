import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user == null) {
        print("Error: No se pudo iniciar sesión");
        return;
      }

      print("Usuario autenticado: ${user.email}");
    } catch (e) {
      print("Error al iniciar sesión: $e");
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user == null) {
        print("Error: No se pudo registrar");
        return;
      }

      print("Usuario registrado: ${user.email}");
    } catch (e) {
      print("Error al registrar: $e");
    }
  }
}
