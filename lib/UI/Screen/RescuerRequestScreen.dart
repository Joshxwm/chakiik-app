// Pantalla para solicitar ayuda de rescatistas

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RescuerRequestScreen extends StatefulWidget {
  const RescuerRequestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RescuerRequestScreenState createState() => _RescuerRequestScreenState();
}

class _RescuerRequestScreenState extends State<RescuerRequestScreen> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _location;
  // ignore: unused_field
  String? _contactNumber;
  // ignore: unused_field
  String? _additionalInfo;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

Widget build(BuildContext context) {
  // ignore: no_leading_underscores_for_local_identifiers
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
  String? _additionalInfo;
  // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
  String? _contactNumber;
  return Scaffold(
    appBar: AppBar(
      title: const Text('Solicitar Rescate'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Ubicacion"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la ubicacion';
                }
                return null;
              },
              onSaved: (value) => _additionalInfo = value,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Numero de contacto"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un numero de contacto';
                }
                return null;
              },
              onSaved: (value) => _contactNumber = value,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitForm(context, _formKey),
              child: const Text("Enviar solicitud"),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: no_leading_underscores_for_local_identifiers
void _submitForm(BuildContext context, GlobalKey<FormState> _formKey) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    // ignore: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables
    var _location;
    // ignore: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables
    var _contactNumber;
    // ignore: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables
    var _additionalInfo;
    final rescueRequest = RescueRequest(
      // Assuming RescueRequest class exists
      location: _location!,
      contactNumber: _contactNumber!,
      additionalInfo: _additionalInfo,
    );

    Provider.of<RescueRequestProvider>(context, listen: false)
        .addRescueRequest(rescueRequest);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solicitud de rescate enviada')),
    );
  }
}

abstract class RescueRequestProvider {
  void addRescueRequest(RescueRequest rescueRequest);
}

class RescueRequest {
  final String location;
  final String contactNumber;
  final String? additionalInfo;
  RescueRequest(
      {required this.location,
      required this.contactNumber,
      this.additionalInfo});
}
