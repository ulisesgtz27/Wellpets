import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: alimentacion_page(),
    );
  }
}

class alimentacion_page extends StatefulWidget {
  const alimentacion_page({super.key});

  @override
  _alimentacion_pageState createState() => _alimentacion_pageState();
}

class _alimentacion_pageState extends State<alimentacion_page> {
  // Variables para controlar el tamaño y color de los botones
  double _buttonHeight1 = 60.0; // Altura inicial del botón 1
  Color _buttonColor1 =
      const Color.fromARGB(255, 93, 182, 255); // Color inicial del botón 1

  double _buttonHeight2 = 60.0; // Altura inicial del botón 2
  Color _buttonColor2 =
      const Color.fromARGB(255, 93, 182, 255); // Color inicial del botón 2

  // Método para cambiar el tamaño y color del botón 1 al presionar
  void _onButtonPress1() {
    setState(() {
      _buttonHeight1 = 80.0; // Cambiar la altura
      _buttonColor1 = const Color.fromARGB(255, 4, 96, 255); // Cambiar el color
    });
  }

  // Método para revertir el tamaño y color del botón 1
  void _onButtonRelease1() {
    setState(() {
      _buttonHeight1 = 60.0; // Revertir a la altura inicial
      _buttonColor1 =
          const Color.fromARGB(255, 93, 182, 255); // Revertir al color inicial
    });
  }

  // Método para cambiar el tamaño y color del botón 2 al presionar
  void _onButtonPress2() {
    setState(() {
      _buttonHeight2 = 80.0; // Cambiar la altura
      _buttonColor2 = const Color.fromARGB(255, 4, 96, 255); // Cambiar el color
    });
  }

  // Método para revertir el tamaño y color del botón 2
  void _onButtonRelease2() {
    setState(() {
      _buttonHeight2 = 60.0; // Revertir a la altura inicial
      _buttonColor2 =
          const Color.fromARGB(255, 93, 182, 255); // Revertir al color inicial
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis planes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Espacio superior
            SizedBox(height: 20),

            // Botón "Planes de Alimentación"
            GestureDetector(
              onTapDown: (_) => _onButtonPress1(),
              onTapUp: (_) {
                _onButtonRelease1();
                // Navegar a la pantalla del plan alimenticio
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => plan_alimenticio()),
                );
              },
              onTapCancel: () => _onButtonRelease1(),
              child: AnimatedContainer(
                duration:
                    Duration(milliseconds: 200), // Duración de la animación
                height: _buttonHeight1,
                width: null, // Ajustar solo al tamaño del texto
                color: _buttonColor1,
                child: Center(
                  child: Text(
                    'Planes de alimentacion',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            // Espacio entre el botón y la huella
            SizedBox(height: 40),

            // Botón "Recordatorios de planes"
            GestureDetector(
              onTapDown: (_) => _onButtonPress2(),
              onTapUp: (_) {
                _onButtonRelease2();
                // Navegar a la pantalla del calendario
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendario()),
                );
              },
              onTapCancel: () => _onButtonRelease2(),
              child: AnimatedContainer(
                duration:
                    Duration(milliseconds: 200), // Duración de la animación
                height: _buttonHeight2,
                width: null, // Ajustar solo al tamaño del texto
                color: _buttonColor2,
                child: Center(
                  child: Text(
                    'Recordatorios de planes',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis planes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendario()),
              );
            },
          ),
        ],
      ),
      body: CalendarioVacunacion(),
    );
  }
}

class CalendarioVacunacion extends StatefulWidget {
  const CalendarioVacunacion({super.key});

  @override
  _CalendarioVacunacionState createState() => _CalendarioVacunacionState();
}

class _CalendarioVacunacionState extends State<CalendarioVacunacion> {
  late Map<DateTime, List<String>> _vacunas;
  late DateTime _selectedDay;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _vacunas = {
      DateTime(2024, 10, 20): ['Vacuna A'],
      DateTime(2024, 10, 25): ['Vacuna B', 'Vacuna C'],
    };
  }

  List<String> _getVacunasForDay(DateTime day) {
    return _vacunas[day] ?? [];
  }

  void _addNota(String nota) {
    setState(() {
      if (_vacunas[_selectedDay] != null) {
        _vacunas[_selectedDay]!.add(nota);
      } else {
        _vacunas[_selectedDay] = [nota];
      }
      _noteController.clear(); // Limpiar el campo de texto
    });
  }

  bool _hasNotas(DateTime day) {
    return _vacunas[day]?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2025),
          focusedDay: _selectedDay,
          selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            // Personalizar el día con notas
            defaultBuilder: (context, day, focusedDay) {
              if (_hasNotas(day)) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('${day.day}')),
                );
              }
              return null; // Deja que TableCalendar dibuje el día por defecto
            },
          ),
        ),
        ..._getVacunasForDay(_selectedDay).map((vacuna) => ListTile(
              title: Text(vacuna),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Agregar nota de vacunación',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_noteController.text.isNotEmpty) {
                    _addNota(_noteController.text);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class plan_alimenticio extends StatelessWidget {
  const plan_alimenticio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ExpansionTile(
              title: Text(
                'Plan Alimenticio 1',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                // Caja que contiene la información del plan
                Card(
                  shape: RoundedRectangleBorder(),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plan de Alimentación para Cachorros (0-12 meses)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Frecuencia de alimentación: 3-4 veces al día (hasta los 6 meses), luego reducir a 2-3 veces.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tipo de alimento: Alimento específico para cachorros, alto en proteínas y calorías para apoyar su crecimiento.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Dieta diaria:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mañana: 1 taza de alimento seco para cachorros (fórmula rica en proteínas y grasas).',
                        ),
                        Text(
                          'Mediodía: 1/2 taza de alimento húmedo para cachorros (carne de pollo o cordero).',
                        ),
                        Text(
                          'Noche: 1 taza de alimento seco para cachorros mezclado con un poco de caldo de pollo sin sal o agua.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Suplementos: Puedes agregar aceite de salmón para favorecer el desarrollo cerebral y un pelaje saludable.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ExpansionTile(
              title: Text(
                'Plan Alimenticio 2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Card(
                  shape: RoundedRectangleBorder(),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plan de Alimentación para Cachorros (1-2 años)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Frecuencia de alimentación: 3-4 veces al día (hasta los 6 meses), luego reducir a 2-3 veces.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tipo de alimento: Alimento específico para cachorros, alto en proteínas y calorías para apoyar su crecimiento.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Dieta diaria:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mañana: 1 taza de alimento seco para cachorros (fórmula rica en proteínas y grasas).',
                        ),
                        Text(
                          'Mediodía: 1/2 taza de alimento húmedo para cachorros (carne de pollo o cordero).',
                        ),
                        Text(
                          'Noche: 1 taza de alimento seco para cachorros mezclado con un poco de caldo de pollo sin sal o agua.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Suplementos: Puedes agregar aceite de salmón para favorecer el desarrollo cerebral y un pelaje saludable.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
