import 'package:flutter/material.dart';
import 'package:wellpets/services/firestore_service.dart';

class PerfilPerro extends StatefulWidget {
  final String userId;
  final String mascotaId;

  const PerfilPerro({super.key, required this.userId, required this.mascotaId});

  @override
  _PerfilPerroState createState() => _PerfilPerroState();
}

class _PerfilPerroState extends State<PerfilPerro> {
  late Future<Map<String, dynamic>> _mascotaData;

  @override
  void initState() {
    super.initState();
    print("UserId: ${widget.userId}, MascotaId: ${widget.mascotaId}");

    // Si el mascotaId está vacío, obtenemos la lista de mascotas del usuario
    if (widget.mascotaId.isEmpty) {
      print("Error: La mascotaId está vacía");
      // Obtenemos las mascotas del usuario
      _mascotaData = FirestoreService()
          .getMascotasByUserId(widget.userId)
          .then((mascotas) {
        if (mascotas.isNotEmpty) {
          // Tomamos el primer ID de la mascota disponible
          return mascotas[
              0]; // Asegúrate de manejar esto correctamente si hay más de una mascota
        } else {
          return {}; // Si no hay mascotas, devolvemos un Map vacío
        }
      });
    } else {
      // Si el mascotaId no está vacío, buscamos los datos de esa mascota
      _mascotaData =
          FirestoreService().getMascotaData(widget.userId, widget.mascotaId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de la Mascota'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _mascotaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error al cargar los datos: ${snapshot.error}");
            return Center(
                child: Text('Error al cargar los datos de la mascota.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No se encontraron datos para esta mascota.'));
          }

          var mascota = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      mascota['imagen'] ?? 'https://via.placeholder.com/150'),
                ),
                SizedBox(height: 16),
                Text(
                  'Nombre: ${mascota['nombre'] ?? "Sin nombre"}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Raza: ${mascota['raza'] ?? "Desconocida"}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Edad: ${mascota['edad'] ?? "N/A"} años',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Peso: ${mascota['peso'] ?? "N/A"} kg',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Vacunado: ${mascota['vacunado'] ?? "No especificado"}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Funcionalidad para editar o eliminar la mascota
                  },
                  child: Text('Editar Mascota'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
