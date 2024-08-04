import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'registro_manager.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _centroEducativoController = TextEditingController();
  final TextEditingController _regionalController = TextEditingController();
  final TextEditingController _distritoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  DateTime? _selectedDate;
  XFile? _selectedImage; 
  File? _selectedAudio;

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery); 
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile; 
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

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final registro = {
        'titulo': _tituloController.text,
        'centroEducativo': _centroEducativoController.text,
        'regional': _regionalController.text,
        'distrito': _distritoController.text,
        'fecha': _selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : 'No seleccionada',
        'descripcion': _descripcionController.text,
        'imagenPath': _selectedImage?.path, 
        'audioPath': _selectedAudio?.path,
      };

      Provider.of<RegistroManager>(context, listen: false).agregarRegistro(registro);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro guardado exitosamente')),
      );

      _formKey.currentState?.reset();
      setState(() {
        _selectedDate = null;
        _selectedImage = null;
        _selectedAudio = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFormField(_tituloController, 'Título'),
                _buildTextFormField(_centroEducativoController, 'Centro Educativo'),
                _buildTextFormField(_regionalController, 'Regional'),
                _buildTextFormField(_distritoController, 'Distrito'),
                _buildDatePicker(context),
                _buildTextFormField(_descripcionController, 'Descripción', maxLines: 3),
                SizedBox(height: 20),
                _buildFilePicker(
                  onTap: _pickImage,
                  label: 'Seleccionar Imagen',
                  fileType: 'Imagen',
                  file: _selectedImage,
                ),
                SizedBox(height: 10),
                _buildFilePicker(
                  onTap: _pickAudio,
                  label: 'Seleccionar Audio',
                  fileType: 'Audio',
                  file: _selectedAudio,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Guardar'),
                ),
                SizedBox(height: 20),
               /* ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lista_registros');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                 // child: Text('Ver Registros'),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText, {int? maxLines}) {
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
          decoration: InputDecoration(
            labelText: 'Fecha',
            hintText: _selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                : 'Selecciona una fecha',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          validator: (value) {
            if (_selectedDate == null) {
              return 'Por favor seleccione una fecha';
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
    required String fileType,
    required dynamic file,
  }) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(label),
          ),
        ),
        SizedBox(width: 10),
        if (file != null)
          Icon(Icons.check_circle, color: Colors.green, size: 24),
        if (file == null)
          Text('No $fileType seleccionado', style: TextStyle(color: Colors.red))
      ],
    );
  }
}
