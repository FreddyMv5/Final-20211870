import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'registro_manager.dart';

class ListaRegistrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registros = Provider.of<RegistroManager>(context).registros;

    void _confirmDelete(BuildContext context, int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmar Eliminación"),
            content: Text("¿Seguro que quieres eliminar este registro?"),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
              ),
              TextButton(
                child: Text("Sí"),
                onPressed: () {
                  Provider.of<RegistroManager>(context, listen: false).eliminarRegistro(index);
                  Navigator.of(context).pop(); 
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Registros'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: registros.length,
        itemBuilder: (context, index) {
          final registro = registros[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                registro['titulo'] ?? 'Sin título',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('Centro Educativo: ${registro['centroEducativo'] ?? 'No especificado'}'),
                  Text('Regional: ${registro['regional'] ?? 'No especificada'}'),
                  Text('Distrito: ${registro['distrito'] ?? 'No especificado'}'),
                  Text('Fecha: ${registro['fecha'] ?? 'No especificada'}'),
                  Text('Descripción: ${registro['descripcion'] ?? 'No disponible'}'),
                  if (registro['imagenPath'] != null && File(registro['imagenPath']!).existsSync())
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        File(registro['imagenPath']!),
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (registro['audioPath'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.audiotrack, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Audio adjunto'),
                        ],
                      ),
                    ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(context, index),
              ),
            ),
          );
        },
      ),
    );
  }
}
