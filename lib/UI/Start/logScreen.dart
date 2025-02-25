import 'dart:async';
import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  double _opacity = 0.0;
  double _scale = 0.5;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutExpo,
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
