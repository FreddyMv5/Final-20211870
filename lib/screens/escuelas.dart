import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EscuelasPage extends StatefulWidget {
  @override
  _EscuelasPageState createState() => _EscuelasPageState();
}

class _EscuelasPageState extends State<EscuelasPage> {
  final TextEditingController _codigoController = TextEditingController();
  Map<String, dynamic>? _escuelaData;
  bool _loading = false;
  bool _error = false;
  String _errorMessage = '';

  Future<void> _buscarEscuela() async {
    setState(() {
      _loading = true;
      _error = false;
      _errorMessage = '';
    });

    final String codigo = _codigoController.text;
    final String url = 'https://adamix.net/minerd/minerd/centros.php?regional=01'; 

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['exito'] && data['datos'].isNotEmpty) {
          final schoolData = data['datos'].firstWhere((item) => item['codigo'] == codigo, orElse: () => null);
          if (schoolData != null) {
            setState(() {
              _escuelaData = schoolData;
              _error = false;
            });
            _mostrarDialogo();
          } else {
            setState(() {
              _error = true;
              _errorMessage = 'No se encontró la escuela con el código proporcionado.';
              _escuelaData = null;
            });
          }
        } else {
          setState(() {
            _error = true;
            _errorMessage = 'No se encontraron datos o la API devolvió un error.';
            _escuelaData = null;
          });
        }
      } else {
        setState(() {
          _error = true;
          _errorMessage = 'Error al conectar con la API.';
          _escuelaData = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = true;
        _errorMessage = 'Ocurrió un error inesperado: $e';
        _escuelaData = null;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _mostrarDialogo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold),),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          content: _escuelaData != null
              ? _buildSchoolDetails()
              : Text(_errorMessage),
        );
      },
    );
  }

  Widget _buildSchoolDetails() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre: ${_escuelaData!['nombre']}'),
        Text('Código: ${_escuelaData!['codigo']}'),
        Text('Coordenadas: ${_escuelaData!['coordenadas']}'),
        Text('Distrito: ${_escuelaData!['distrito']}'),
        Text('Regional: ${_escuelaData!['regional']}'),
        Text('Distrito Municipal: ${_escuelaData!['d_dmunicipal']}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Escuela' , style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codigoController,
              decoration: InputDecoration(
                labelText: 'Código de Escuela',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _buscarEscuela,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                foregroundColor: Colors.white, 
              ),
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
