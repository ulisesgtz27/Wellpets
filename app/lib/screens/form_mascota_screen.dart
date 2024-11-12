import 'package:flutter/material.dart';
import 'package:wellpets/services/firestore_service.dart';

class FormMascotaScreen extends StatefulWidget {
  final String userId;

  FormMascotaScreen({super.key, required this.userId});

  @override
  _FormMascotaScreenState createState() => _FormMascotaScreenState();
}

class _FormMascotaScreenState extends State<FormMascotaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _pesoController = TextEditingController();
  final _edadController = TextEditingController();
  String _raza = 'Pitbull';
  bool _vacunado = false;

  final List<String> razas = [
    'Pitbull',
    'Pug',
    'Chihuahua',
    'French Poodle',
    'Pastor Belga',
    'Otro'
  ];

  Future<void> _registrarMascota() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> mascotaData = {
        'uid_usuario': widget.userId,
        'nombre': _nombreController.text,
        'raza': _raza,
        'peso': _pesoController.text,
        'edad': _edadController.text,
        'vacunado': _vacunado,
      };

      await FirestoreService().addMascota(widget.userId, mascotaData);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Mascota registrada correctamente'),
        backgroundColor: Colors.green,
      ));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Mascota')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre de la Mascota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _raza,
                onChanged: (String? newValue) {
                  setState(() {
                    _raza = newValue!;
                  });
                },
                items: razas.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Raza'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _pesoController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el peso';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _edadController,
                decoration: InputDecoration(labelText: 'Edad (años)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la edad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('¿Está vacunado?'),
                value: _vacunado,
                onChanged: (bool value) {
                  setState(() {
                    _vacunado = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarMascota,
                child: Text('Registrar Mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _pesoController.dispose();
    _edadController.dispose();
    super.dispose();
  }
}
