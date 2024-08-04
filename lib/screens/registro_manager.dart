import 'package:flutter/material.dart';

class RegistroManager extends ChangeNotifier {
  List<Map<String, dynamic>> _registros = [];

  List<Map<String, dynamic>> get registros => _registros;

  void agregarRegistro(Map<String, dynamic> registro) {
    _registros.add(registro);
    notifyListeners();
  }

  void eliminarRegistro(int index) {
    if (index >= 0 && index < _registros.length) {
      _registros.removeAt(index);
      notifyListeners();
    }
  }
}
