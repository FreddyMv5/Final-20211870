import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HoroscopeScreen extends StatefulWidget {
  @override
  _HoroscopeScreenState createState() => _HoroscopeScreenState();
}

class Horoscope {
  final String sign;
  final String imageUrl;
  final String phrase;

  Horoscope({
    required this.sign,
    required this.imageUrl,
    required this.phrase,
  });
}

class _HoroscopeScreenState extends State<HoroscopeScreen> {
  final TextEditingController _dateController = TextEditingController();
  Horoscope? _horoscope;

  final Map<String, Horoscope> _horoscopes = {
    'Aries': Horoscope(
      sign: 'Aries',
      imageUrl: 'assets/horoscopo/Aries.jpg',
      phrase: '¡Actúa con valentía y determinación!',
    ),
    'Tauro': Horoscope(
      sign: 'Tauro',
      imageUrl: 'assets/horoscopo/taurus.jpg',
      phrase: 'La paciencia y la persistencia te recompensarán.',
    ),
    'Geminis': Horoscope(
      sign: 'Geminis',
      imageUrl: 'assets/horoscopo/Geminis.jpg',
      phrase: 'La curiosidad te llevará a nuevos descubrimientos.',
    ),
    'Cancer': Horoscope(
      sign: 'Cancer',
      imageUrl: 'assets/horoscopo/Cancer.jpg',
      phrase: 'Confía en tus instintos; te guiarán por el camino correcto.',
    ),
    'Leo': Horoscope(
      sign: 'Leo',
      imageUrl: 'assets/horoscopo/Leo.jpg',
      phrase: 'Tu carisma te abrirá puertas inesperadas.',
    ),
    'Virgo': Horoscope(
      sign: 'Virgo',
      imageUrl: 'assets/horoscopo/Virgo.jpg',
      phrase: 'La organización y la atención al detalle te ayudarán a alcanzar tus objetivos.',
    ),
    'Libra': Horoscope(
      sign: 'Libra',
      imageUrl: 'assets/horoscopo/Libra.jpg',
      phrase: 'Busca el equilibrio en todas las áreas de tu vida.',
    ), 
    'Escorpio': Horoscope(
      sign: 'Escorpio',
      imageUrl: 'assets/horoscopo/Escorpio.jpeg',
      phrase: 'La pasión te impulsará hacia el éxito.',
    ),
    'Capricornio': Horoscope(
      sign: 'Capricornio',
      imageUrl: 'assets/horoscopo/Capricornio.jpg',
      phrase: 'La perseverancia te llevará lejos.',
    ),
    'Sagitario': Horoscope(
      sign: 'Sagitario',
      imageUrl: 'assets/horoscopo/Sagitario.jpg',
      phrase: 'Explora nuevas aventuras y amplía tus horizontes.',
    ),
    'Acuario': Horoscope(
      sign: 'Acuario',
      imageUrl: 'assets/horoscopo/Acuario.jpg',
      phrase: 'Sé auténtico y sigue tu propio camino.',
    ),
    'Piscis': Horoscope(
      sign: 'Piscis',
      imageUrl: 'assets/horoscopo/Piscis.png',
      phrase: 'Confía en tu intuición; te sorprenderá.',
    ),
  };

  void _calculateHoroscope(DateTime date) {
    final int month = date.month;
    final int day = date.day;
    String sign = '';

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      sign = 'Aries';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      sign = 'Tauro';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      sign = 'Géminis';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      sign = 'Cáncer';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      sign = 'Leo';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      sign = 'Virgo';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      sign = 'Libra';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      sign = 'Escorpio';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      sign = 'Sagitario';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      sign = 'Capricornio';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      sign = 'Acuario';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      sign = 'Piscis';
    }

    setState(() {
      _horoscope = _horoscopes[sign];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horóscopo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu fecha de nacimiento (Año-Mes-Día)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  if (value.length == 10) {
                    try {
                      final date = DateFormat('yyyy-MM-dd').parse(value);
                      _calculateHoroscope(date);
                    } catch (e) {
                      print('Fecha inválida');
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              _horoscope != null
                  ? Column(
                      children: [
                        Text(
                          _horoscope!.sign,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          _horoscope!.imageUrl,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          _horoscope!.phrase,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Text(
                      'Introduce tu fecha de nacimiento para ver tu horóscopo.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
