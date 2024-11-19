import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellpets/services/firestore_service.dart';

class PerfilPerro extends StatefulWidget {
  final String userId;
  final String mascotaId;

  const PerfilPerro({super.key, required this.userId, required this.mascotaId});

  @override
  _PerfilPerroState createState() => _PerfilPerroState();
}

class _PerfilPerroState extends State<PerfilPerro> {
  late Future<dynamic> _mascotaData;
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic>? _selectedMascota;
  bool _showDetails = false;

  // Mapa local para almacenar las imágenes de las mascotas
  Map<String, File?> _imagenesMascotas = {};

  @override
  void initState() {
    super.initState();
    _mascotaData = widget.mascotaId.isEmpty
        ? FirestoreService().getMascotasByUserId(widget.userId)
        : FirestoreService().getMascotaData(widget.userId, widget.mascotaId);
  }

  void _toggleDetails(Map<String, dynamic> mascota) {
    setState(() {
      if (_selectedMascota == mascota && _showDetails) {
        // Ocultar detalles
        _showDetails = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      } else {
        // Mostrar detalles y desplazarse hacia abajo
        _selectedMascota = mascota;
        _showDetails = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  Future<void> _seleccionarImagen(String mascotaId) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagenesMascotas[mascotaId] = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de la Mascota'),
        backgroundColor: const Color.fromARGB(255, 241, 231, 244),
      ),
      body: FutureBuilder<dynamic>(
        future: _mascotaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error al cargar los datos: ${snapshot.error}");
            return const Center(
                child: Text('Error al cargar los datos de la mascota.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No se encontraron datos para esta mascota.'));
          }

          var mascotas = widget.mascotaId.isEmpty
              ? snapshot.data as List<Map<String, dynamic>>
              : [snapshot.data as Map<String, dynamic>];

          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mascotas.length,
                  itemBuilder: (context, index) {
                    var mascota = mascotas[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            _imagenesMascotas[mascota['id']] != null
                                ? FileImage(_imagenesMascotas[mascota['id']]!)
                                    as ImageProvider
                                : const NetworkImage(
                                    'https://via.placeholder.com/150'),
                      ),
                      title: Text(
                        mascota['nombre'] ?? 'Sin nombre',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text('Raza: ${mascota['raza'] ?? "Desconocida"}'),
                      trailing: Icon(
                        _selectedMascota == mascota && _showDetails
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      onTap: () => _toggleDetails(mascota),
                    );
                  },
                ),
                AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: _selectedMascota != null
                      ? _buildMascotaDetailView(_selectedMascota!)
                      : Container(),
                  crossFadeState: _showDetails
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMascotaDetailView(Map<String, dynamic> mascota) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _imagenesMascotas[mascota['id']] != null
                      ? FileImage(_imagenesMascotas[mascota['id']]!)
                          as ImageProvider
                      : const NetworkImage('https://via.placeholder.com/150'),
                ),
                if (_imagenesMascotas[mascota['id']] == null)
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () => _seleccionarImagen(mascota['id']),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Nombre: ${mascota['nombre'] ?? "Sin nombre"}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Raza:', mascota['raza'] ?? "Desconocida"),
          _buildDetailRow('Edad:', '${mascota['edad'] ?? "N/A"} años'),
          _buildDetailRow('Peso:', '${mascota['peso'] ?? "N/A"} kg'),
          _buildDetailRow(
              'Vacunado:', mascota['vacunado'] == true ? "Sí" : "No"),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Funcionalidad para editar la mascota
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar Mascota'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
