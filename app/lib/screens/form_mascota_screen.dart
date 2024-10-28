import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Mascota',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: formulario(),
    );
  }
}

class formulario extends StatefulWidget {
  const formulario({super.key});

  @override
  _PetFormScreenState createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<formulario> {
  final _formKey = GlobalKey<FormState>();

  String _nombreMascota = '';
  String _tipoMascota = 'Chihuahua'; // Default option
  String _peso = '';
  String _edad = '';
  String _genero = 'Macho'; // Default option
  bool _vacunasAlDia = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo Nombre de la Mascota
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de la Mascota',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la mascota';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombreMascota = value ?? '';
                },
              ),
              SizedBox(height: 16),

              // Tipo de Mascota (Dropdown)
              DropdownButtonFormField<String>(
                value: _tipoMascota,
                decoration: InputDecoration(
                  labelText: 'Tipo de Mascota',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Chihuahua',
                  'Golden Retriever',
                  'Beagle',
                  'Pug',
                  'Labrador retriever',
                  'Otro'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tipoMascota = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),

              // Campo Raza
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Peso (Aproximado)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su peso de la mascota';
                  }
                  return null;
                },
                onSaved: (value) {
                  _peso = value ?? '';
                },
              ),
              SizedBox(height: 16),

              // Campo Edad
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Edad (en meses)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la edad de la mascota';
                  }
                  return null;
                },
                onSaved: (value) {
                  _edad = value ?? '';
                },
              ),
              SizedBox(height: 16),

              // Género (RadioButton)
              Text('Género:', style: TextStyle(fontSize: 16)),
              RadioListTile<String>(
                title: Text('Macho'),
                value: 'Macho',
                groupValue: _genero,
                onChanged: (value) {
                  setState(() {
                    _genero = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Hembra'),
                value: 'Hembra',
                groupValue: _genero,
                onChanged: (value) {
                  setState(() {
                    _genero = value!;
                  });
                },
              ),
              SizedBox(height: 16),

              // ¿Vacunas al día? (Checkbox)
              CheckboxListTile(
                title: Text('Vacunas al día'),
                value: _vacunasAlDia,
                onChanged: (bool? value) {
                  setState(() {
                    _vacunasAlDia = value ?? false;
                  });
                },
              ),
              SizedBox(height: 16),

              // Botón para enviar el formulario
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes manejar los datos guardados, por ejemplo enviarlos a una API o base de datos
                    _showFormData(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Muestra los datos del formulario en un diálogo
  void _showFormData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Datos de la Mascota'),
          content: Text(
            'Nombre: $_nombreMascota\n'
            'Tipo: $_tipoMascota\n'
            'Raza: $_peso\n'
            'Edad: $_edad años\n'
            'Género: $_genero\n'
            'Vacunas al día: ${_vacunasAlDia ? 'Sí' : 'No'}',
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
