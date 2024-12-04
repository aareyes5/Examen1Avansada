import 'package:flutter/material.dart';
import '../logica/logica_classes.dart';
//pantalla con mensaje de bienvenida y un boton que redirige a la pantalla de pesage de pescado

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.anchor, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Bienvenido a La pesa de pescado',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/kilos');
                },
                icon: Icon(Icons.navigate_next, color: Colors.white),
                label: Text('Pesar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade900,
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}