import 'package:flutter/material.dart';
import 'package:final_app/screens/detalle_vista.dart';
import 'dart:io'; 

class VisitasRegistradasPage extends StatelessWidget {
  final List<Map<String, dynamic>> visitas;

  VisitasRegistradasPage({required this.visitas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitas Registradas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: visitas.length,
        itemBuilder: (context, index) {
          final visita = visitas[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: _buildImage(visita['imagenPath']),
              title: Text(
                'Código: ${visita['codigoCentro']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Motivo: ${visita['motivoVisita']}'),
                  Text('Fecha: ${visita['fecha']}'),
                  Text('Hora: ${visita['hora']}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleVisitaPage(visita: visita),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Icon(Icons.image, color: Colors.grey);
    }
    return Image.file(
      File(imagePath),
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}
