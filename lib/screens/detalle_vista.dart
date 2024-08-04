import 'package:flutter/material.dart';
import 'dart:io';

class DetalleVisitaPage extends StatelessWidget {
  final Map<String, dynamic> visita;

  DetalleVisitaPage({required this.visita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Visita'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailItem('Cédula del Director', visita['cedulaDirector']),
            _buildDetailItem('Código del Centro', visita['codigoCentro']),
            _buildDetailItem('Motivo de la Visita', visita['motivoVisita']),
            _buildDetailItem('Comentario', visita['comentario']),
            _buildDetailItem('Latitud', visita['latitud']),
            _buildDetailItem('Longitud', visita['longitud']),
            _buildDetailItem('Fecha', visita['fecha']),
            _buildDetailItem('Hora', visita['hora']),
            SizedBox(height: 16),
            if (visita['imagenPath'] != null && File(visita['imagenPath']!).existsSync())
              _buildImageSection(File(visita['imagenPath']!))
            else
              _buildNoAttachmentSection('No hay imagen adjunta'),
            SizedBox(height: 16),
            if (visita['audioPath'] != null)
              _buildAudioSection()
            else
              _buildNoAttachmentSection('No hay nota de voz adjunta'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value ?? 'No disponible'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(File imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Imagen Adjunta',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Image.file(
          imageFile,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildAudioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nota de Voz Adjunta',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            
          },
          child: Text('Reproducir Nota de Voz'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNoAttachmentSection(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
