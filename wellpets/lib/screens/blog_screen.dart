import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog de Dueños de Mascotas',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ComunidadPage(),
    );
  }
}

class ComunidadPage extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<ComunidadPage> {
  // Lista de comentarios
  List<Map<String, String>> messages = [
    {'text': 'Me parece muy importante lo de revisar a nuestros perros cada cierto tiempo', 'user': 'Ana', 'color': 'green'},
    {'text': 'Deberían crear una nueva marca de comida para perros, están muy caras las de hoy', 'user': 'Ruben', 'color': 'red'},
    {'text': 'Si quieren un buen shampoo para su cachorro deberían usar Thankful, lo recomiendo bastante :)', 'user': 'Martin', 'color': 'blue'},
  ];

  // Controlador para el campo de texto
  final TextEditingController _controller = TextEditingController();

  // Función para agregar un nuevo comentario
  void _addMessage(String text) {
    setState(() {
      messages.add({'text': text, 'user': 'Nuevo usuario', 'color': 'green'});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dueños conectados'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  color: message['color'] == 'green'
                      ? Colors.green[50]
                      : message['color'] == 'red'
                          ? Colors.red[50]
                          : Colors.blue[50],
                  child: ListTile(
                    title: Text(
                      message['text']!,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      message['user']!,
                      style: TextStyle(
                        color: message['color'] == 'green'
                            ? Colors.green
                            : message['color'] == 'red'
                                ? Colors.red
                                : Colors.blue,
                      ),
                    ),
                    leading: Icon(
                      Icons.person,
                      color: message['color'] == 'green'
                          ? Colors.green
                          : message['color'] == 'red'
                              ? Colors.red
                              : Colors.blue,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Publica algo...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
