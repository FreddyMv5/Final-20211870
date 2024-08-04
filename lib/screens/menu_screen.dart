import 'package:final_app/screens/director.dart';
import 'package:final_app/screens/horoscopo.dart';
import 'package:final_app/screens/lista_visita.dart';
import 'package:final_app/screens/visita_tecnicos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'registro.dart';
import 'lista_registros.dart'; 
import 'about.dart'; 
import 'escuelas.dart'; 
import 'noticias.dart'; 
import 'clima.dart';
import 'visitas_manager.dart'; 

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> visitas;
  MenuPage({required this.visitas});
  final List<String> catNames = [
    "Registro",
    'Lista Registros',
    'Acerca de',
    'Visita Tecnicos',
    'Listado Visitas',
    'Escuelas',
    'Noticias',
    'Clima',
    'Horoscopo',
    'Director',
  ];

  final List<Color> catColors = [
    Color.fromARGB(255, 5, 165, 13),
    Color.fromARGB(255, 35, 180, 196),
    Color.fromARGB(255, 203, 89, 24),
    Color.fromARGB(255, 172, 1, 1),
    Color.fromARGB(255, 255, 45, 83),
    Color.fromARGB(255, 154, 22, 165),
    Color.fromARGB(255, 46, 31, 246),
    Color.fromARGB(255, 236, 232, 16),
    Color.fromARGB(255, 120, 8, 72),
    Color.fromARGB(255, 7, 119, 48),
  ];

  final List<Icon> catIcons = [
    Icon(Icons.app_registration, color: Colors.white, size: 30),
    Icon(Icons.list, color: Colors.white, size: 30),
    Icon(Icons.person, color: Colors.white, size: 30),
    Icon(Icons.contact_emergency_rounded, color: Colors.white, size: 30),
    Icon(Icons.person_pin_rounded, color: Colors.white, size: 30),
    Icon(Icons.school, color: Colors.white, size: 30),
    Icon(Icons.newspaper_outlined, color: Colors.white, size: 30),
    Icon(Icons.sunny, color: Colors.white, size: 30),
    Icon(Icons.star, color: Colors.white, size: 30),
    Icon(Icons.school, color: Colors.white, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 55, 119, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Herramientas",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: catNames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (catNames[index] == "Registro") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistroPage()),
                          );
                        } else if (catNames[index] == "Lista Registros") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListaRegistrosPage()),
                          );
                        } else if (catNames[index] == "Acerca de") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PerfilPage(
                              imagenUrl: 'assets/fotopf.jpeg', 
                              nombre: 'Freddy Manuel',
                              apellido: 'Villar Abreu',
                              matricula: '2021-1870',
                              descripcion: 'La educación no es la preparación para la vida; la educación es la vida misma.',
                            )),
                          );
                        
                        } else if (catNames[index] == "Escuelas") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EscuelasPage()), 
                          );
                        } else if (catNames[index] == "Noticias") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NoticiasPage()), 
                          );
                        } else if (catNames[index] == "Clima") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WeatherHome()), 
                          );
                        }else if (catNames[index] == "Horoscopo") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HoroscopeScreen()), 
                          );
                        }else if (catNames[index] == "Director") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DirectorScreen()), 
                          );
                        }else if (catNames[index] == "Visita Tecnicos") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrarVisitaPage(visitas: visitas)), 
                          );
                        } else if (catNames[index] == "Listado Visitas") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VisitasRegistradasPage(visitas: visitas)), 
                          );
                        } 
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            catNames[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
