import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'form_mascota_screen.dart'; // Verifica que el archivo sea el correcto
import 'perfil_mascota_screen.dart';
import 'perfil_usuario_screen.dart';
import 'alimentacion_screen.dart';
import 'salud_screen.dart';
import 'blog_screen.dart';

//alias: wellpetsk
//contraseña: appwellpets

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const Index({super.key});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  late String userId;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Si no hay usuario autenticado, mostramos una pantalla de carga
      return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    userId = user.uid; // Obtenemos el userId cuando el usuario está autenticado

    // Lista de pantallas con el userId
    final List<Widget> _screens = [
      HomeScreen(),
      FormMascotaScreen(userId: userId), // Pasamos el userId aquí
      perfilUsuario(),
      PerfilPerro(userId: userId, mascotaId: 'mascotaId')
    ];

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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Agregar mascota'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pets), label: 'Perfil mascota'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final String userId = user.uid;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 150,
              child: PageView(
                controller: PageController(),
                children: <Widget>[
                  buildTipCard(
                      'Sabías que los perros necesitan ejercicio diario...', 0),
                  buildTipCard(
                      'Sabías que los gatos pueden dormir hasta 16 horas al día...',
                      1),
                  buildTipCard(
                      'Sabías que los conejos disfrutan masticar ramas frescas...',
                      2),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildServiceButton(
                    'Planes', Icons.list, context, alimentacion_page()),
                _buildServiceButton(
                    'Salud', Icons.health_and_safety, context, salud_page()),
                _buildServiceButton(
                    'Blog', Icons.group, context, ComunidadPage()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBottomButton(
                  'Perfil Mascota',
                  Icons.pets,
                  context,
                  () => perfilMascotaScreen(context, userId, ''),
                ),
                SizedBox(height: 10),
                _buildBottomButton(
                  'Perfil Usuario',
                  Icons.person,
                  context,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => perfilUsuario()),
                  ),
                ),
                SizedBox(height: 10),
                _buildBottomButton(
                  'Agregar Mascota',
                  Icons.note_add,
                  context,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FormMascotaScreen(userId: userId), // Pasa userId aquí
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  static Widget _buildServiceButton(
      String label, IconData icon, BuildContext context, Widget targetScreen) {
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

  static Widget _buildBottomButton(String label, IconData icon,
      BuildContext context, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

void perfilMascotaScreen(
    BuildContext context, String userId, String mascotaId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PerfilPerro(userId: userId, mascotaId: mascotaId),
    ),
  );
}
