import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final String imagenUrl; 
  final String nombre;
  final String apellido;
  final String matricula;
  final String descripcion;

  PerfilPage({
    required this.imagenUrl,
    required this.nombre,
    required this.apellido,
    required this.matricula,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(imagenUrl), 
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$nombre $apellido',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Matrícula: $matricula',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              descripcion,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PerfilPage(
      imagenUrl: 'assets/profile.jpg', 
      nombre: 'Juan',
      apellido: 'Pérez',
      matricula: '123456',
      descripcion: 'La educación no es la preparación para la vida; la educación es la vida misma.',
    ),
  ));
}
