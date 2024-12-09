import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}

class salud_page extends StatelessWidget {
  const salud_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salud'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Espacio superior
            SizedBox(height: 20),

            // Botón "Siguiente"
            SizedBox(
              width: double.infinity, // Ancho máximo
              child: ElevatedButton(
                onPressed: () {
                  // Navegar a la segunda pantalla
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendario()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 15), // Espaciado vertical
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Calendario de vacunacion'),
              ),
            ),

            // Espacio entre el botón y la huella
            SizedBox(height: 40),

            // SizedBox(
            //   width: double.infinity, // Ancho máximo
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navegar a la segunda pantalla
            //        Navigator.push(
            //          context,
            //          MaterialPageRoute(builder: (context) => pagina_principal()),
            //        );
            //     },
            //   child: Text('Estado de salud'),
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(vertical: 15),
            //       textStyle: TextStyle(fontSize: 18),
            //     ),
            //   ),
            //   ),
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
        title: Text('Calendario de Vacunación'),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Acción para el ícono de perfil
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          //boton de notificaciones para navegar
          IconButton(
            icon: Icon(Icons.notifications),
            iconSize: 30.0, // Tamaño del icono
            color: Colors.white, // Color del icono
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Index()),
              );
            },
            padding: EdgeInsets.all(10.0), // Padding alrededor del icono
            constraints: BoxConstraints(), // Elimina el espacio extra alrededor del icono
            splashColor: Colors.blueAccent, // Color del efecto de splash
            highlightColor: Colors.blue, // Color del highlight cuando se presiona
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
