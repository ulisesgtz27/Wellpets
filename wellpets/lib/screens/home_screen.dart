import 'package:flutter/material.dart';
import 'package:wellpets/screens/form_mascota_screen.dart';
import 'perfil_mascota_screen.dart';
import 'perfil_usuario_screen.dart';
import 'alimentacion_screen.dart';
import 'salud_screen.dart';
import 'blog_screen.dart';
//import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WellPets',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0; // Variable para almacenar el índice seleccionado

  // Lista de pantallas
  final List<Widget> _screens = [
    HomeScreen(),
    formulario(),
    perfil_perro(),
    perfilUsuario(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('lib/assets/images/icon.png'), 
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Muestra la pantalla correspondiente
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Agregar mascota'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Perfil mascota'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Maneja el evento de tocar un ícono
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner promocional
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 150,
              child: PageView(
                controller: PageController(),
                children: <Widget>[
                  buildTipCard('Sabías que los perros necesitan ejercicio diario...', 0),
                  buildTipCard('Sabías que los gatos pueden dormir hasta 16 horas al día...', 1),
                  buildTipCard('Sabías que los conejos disfrutan masticar ramas frescas...', 2),
                ],
              ),
            ),
          ),
          // Servicios (Grid de opciones)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // _buildServiceButton('Mascotas', Icons.pets, context, MascotasScreen()),
                _buildServiceButton('Planes', Icons.list, context, alimentacion_page()),
                _buildServiceButton('Salud', Icons.health_and_safety, context, salud_page()),
                _buildServiceButton('Blog', Icons.group, context, ComunidadPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir la tarjeta de consejos
  Widget buildTipCard(String tip, int index) {
    return Card(
      color: Colors.purple[50],
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            tip,
            style: TextStyle(fontSize: 16, color: Colors.purple),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Widget para botones de servicio
  static Widget _buildServiceButton(String label, IconData icon, BuildContext context, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple[100],
            child: Icon(icon, color: Colors.purple),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

