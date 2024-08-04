import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class RegistrarVisitaPage extends StatefulWidget {
  final List<Map<String, dynamic>> visitas;

  RegistrarVisitaPage({required this.visitas});

  @override
  _RegistrarVisitaPageState createState() => _RegistrarVisitaPageState();
}

class _RegistrarVisitaPageState extends State<RegistrarVisitaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaDirectorController = TextEditingController();
  final TextEditingController _codigoCentroController = TextEditingController();
  final TextEditingController _motivoVisitaController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final TextEditingController _latitudController = TextEditingController();
  final TextEditingController _longitudController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  File? _selectedImage;
  File? _selectedAudio;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedAudio = File(result.files.single.path!);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _fechaController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _horaController.text = pickedTime.format(context);
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final visita = {
        'cedulaDirector': _cedulaDirectorController.text,
        'codigoCentro': _codigoCentroController.text,
        'motivoVisita': _motivoVisitaController.text,
        'comentario': _comentarioController.text,
        'latitud': _latitudController.text,
        'longitud': _longitudController.text,
        'fecha': _fechaController.text,
        'hora': _horaController.text,
        'imagenPath': _selectedImage?.path,
        'audioPath': _selectedAudio?.path,
      };

      widget.visitas.add(visita);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Visita registrada exitosamente')),
      );

      _formKey.currentState?.reset();
      setState(() {
        _selectedImage = null;
        _selectedAudio = null;
        _fechaController.clear();
        _horaController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Visita'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFormField(
                  controller: _cedulaDirectorController,
                  labelText: 'Cédula del Director',
                ),
                _buildTextFormField(
                  controller: _codigoCentroController,
                  labelText: 'Código del Centro',
                ),
                _buildTextFormField(
                  controller: _motivoVisitaController,
                  labelText: 'Motivo de la Visita',
                ),
                _buildTextFormField(
                  controller: _comentarioController,
                  labelText: 'Comentario',
                  maxLines: 3,
                ),
                _buildTextFormField(
                  controller: _latitudController,
                  labelText: 'Latitud',
                ),
                _buildTextFormField(
                  controller: _longitudController,
                  labelText: 'Longitud',
                ),
                _buildDatePicker(context),
                _buildTimePicker(context),
                SizedBox(height: 20),
                _buildFilePicker(
                  onTap: _pickImage,
                  label: 'Seleccionar Imagen',
                  file: _selectedImage,
                  icon: Icons.image,
                ),
                SizedBox(height: 10),
                _buildFilePicker(
                  onTap: _pickAudio,
                  label: 'Seleccionar Audio',
                  file: _selectedAudio,
                  icon: Icons.audiotrack,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Guardar Visita'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _fechaController,
          decoration: InputDecoration(
            labelText: 'Fecha',
            hintText: 'Selecciona una fecha',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor seleccione una fecha';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _horaController,
          decoration: InputDecoration(
            labelText: 'Hora',
            hintText: 'Selecciona una hora',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor seleccione una hora';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildFilePicker({
    required VoidCallback onTap,
    required String label,
    required dynamic file,
    required IconData icon,
  }) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(icon),
            label: Text(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        SizedBox(width: 10),
        if (file != null)
          Icon(Icons.check_circle, color: Colors.green, size: 24),
        if (file == null)
          Text('No seleccionado', style: TextStyle(color: Colors.red))
      ],
    );
  }
}
