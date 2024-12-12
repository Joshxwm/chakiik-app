import 'package:chakiik_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chack iik´',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 113, 192, 216)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Chack iik´'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _location = 'Unknown';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static List<Widget> _widgetOptions = <Widget>[
    LoginWidget(),
    SignUpWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    //Usar stream en FirebaseMessaging de mensajes entrantes
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location = '${position.latitude}, ${position.longitude}';
    });

    //Enviar ubicacion a FireStore para el seguimiento de huracanes
    await _firestore.collection('locations').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      String title = message.data['title'];
      String body = message.data['body'];
      // Mostrar una notificacion push
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title: $body'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       title: Text(widget.title),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[ 
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem( 
            icon: Icon(Icons.app_registration),
            label: 'Sign Up',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
} 
// Widget de inicio de sesión 
class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Text('Login'),
          TextField(
            decoration: InputDecoration(hintText: 'Username'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica de inicio de sesión
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
  
  // Widget de creación de cuenta
class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign Up'),
          TextField(
            decoration: InputDecoration(hintText: 'Username'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField( 
            decoration: InputDecoration(hintText: 'Password'),
            obscureText: true,
          ), 
          ElevatedButton(
            onPressed: () { 
              // Lógica de creación de cuenta 
            }, 
            child: Text('Sign Up'),
          ),
        ], 
      ), 
    );
  }
}
/*
  Hola, mi nombre es Annie, tengo 23 años, casi 24,
  soy virgen, me gustaría dejar de serlo, me gustaría
  tener mi primera vez. con alguien maduro.
*/