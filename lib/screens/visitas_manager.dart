import 'package:flutter/material.dart';

class VisitasManager extends ChangeNotifier {
  List<Map<String, dynamic>> _visitas = [];

  List<Map<String, dynamic>> get visitas => _visitas;

  void addVisita(Map<String, dynamic> visita) {
    _visitas.add(visita);
    notifyListeners();
  }

  void removeVisita(Map<String, dynamic> visita) {
    _visitas.remove(visita);
    notifyListeners();
  }
}
