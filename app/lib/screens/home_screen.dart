import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'form_mascota_screen.dart';
import 'perfil_mascota_screen.dart';
import 'perfil_usuario_screen.dart';
import 'alimentacion_screen.dart';
import 'salud_screen.dart';
import 'blog_screen.dart';

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
      return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    userId = user.uid;

    final List<Widget> _screens = [
      HomeScreen(),
      FormMascotaScreen(userId: userId),
      PerfilUsuario(),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Configura el temporizador para cambiar la página automáticamente cada 3 segundos
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancela el temporizador cuando se sale de la pantalla
    super.dispose();
  }

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
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  buildTipCard(
                      'Sabías que los perros necesitan ejercicio diario...', 0),
                  buildTipCard(
                      'Sabías que los gatos pueden dormir hasta 16 horas al día...', 1),
                  buildTipCard(
                      'Sabías que los conejos disfrutan masticar ramas frescas...', 2),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildIndicator(index)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
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
              children: [
                _buildCustomButton(
                  'Perfil Mascota',
                  Icons.pets,
                  context,
                  () => perfilMascotaScreen(context, userId, ''),
                ),
                SizedBox(height: 10),
                _buildCustomButton(
                  'Perfil Usuario',
                  Icons.person,
                  context,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PerfilUsuario()),
                  ),
                ),
                SizedBox(height: 10),
                _buildCustomButton(
                  'Agregar Mascota',
                  Icons.note_add,
                  context,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormMascotaScreen(userId: userId),
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

  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: _currentPage == index ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.purple : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
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
            backgroundColor: const Color(0xFFE1BEE7),
            radius: 30,
            child: Icon(icon, color: Colors.purple, size: 30),
          ),
          SizedBox(height: 8),
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  static Widget _buildCustomButton(String label, IconData icon,
      BuildContext context, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 28),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBF73CC),
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.purple, width: 1),
          ),
          elevation: 4,
          shadowColor: Colors.tealAccent.withOpacity(0.3),
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
