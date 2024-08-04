import 'package:flutter/material.dart';

class DirectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Director'),
        backgroundColor: Colors.blue,
      ),
      body: MaintenanceTab(),
    );
  }
}

class MaintenanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.yellow,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'UPS!, esta pestaña se encuentra en mantenimiento...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DirectorScreen(),
  ));
}
