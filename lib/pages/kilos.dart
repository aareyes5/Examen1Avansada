import 'package:flutter/material.dart';
import '../logica/logica_classes.dart';

class Kilos extends StatefulWidget {
  @override
  KilosState createState() => KilosState();
}

class KilosState extends State<Kilos> {
  final _controller = TextEditingController();
  LogicaKilos? _logicaKilos;
  String _mensaje = "Ingrese el límite de kilogramos para iniciar.";
  bool _excedido = false; // Indica si se ha excedido el límite

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _iniciarPrograma(String limite) {
    final int? limiteNumerico = int.tryParse(limite);
    if (limiteNumerico == null) {
      // Mostrar error si no es un número
      setState(() {
        _mensaje = "Por favor, ingrese un número válido como límite.";
      });
      return;
    }

    setState(() {
      _logicaKilos = LogicaKilos(limiteNumerico);
      _mensaje = "Ingrese los kilogramos pescados.";
      _excedido = false; // Reinicia el estado si se vuelve a iniciar
    });
  }

  void _agregarKilos(String kilos) {
    if (_logicaKilos == null) return;

    final int? kg = int.tryParse(kilos);
    if (kg == null) {
      // Mostrar error si no es un número
      setState(() {
        _mensaje = "Por favor, ingrese un número válido para los kilogramos.";
      });
      return;
    }

    final resultado = _logicaKilos!.agregarKilos(kg);

    setState(() {
      _mensaje = resultado;
      if (resultado.contains("Límite excedido")) {
        _excedido = true; // Marca que se ha excedido el límite
      }
      if (kg == 0) {
        _logicaKilos = null; // Resetea el programa si se introduce 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Pesca'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.teal),
              ),
              child: Text(
                _mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.teal.shade900),
              ),
            ),
            SizedBox(height: 20),
            if (!_excedido) ...[
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _logicaKilos == null
                      ? 'Ingrese el límite de kilogramos'
                      : 'Ingrese kilos pescados',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.black12,
                  prefixIcon: Icon(Icons.scale, color: Colors.teal),
                ),
              ),
              SizedBox(height: 20),
            ],
            ElevatedButton.icon(
              onPressed: () {
                if (_excedido) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
                } else {
                  if (_logicaKilos == null) {
                    _iniciarPrograma(_controller.text);
                  } else {
                    _agregarKilos(_controller.text);
                  }
                  _controller.clear();
                }
              },
              icon: Icon(
                _excedido ? Icons.home : Icons.add,
                color: Colors.white,
              ),
              label: Text(
                _excedido ? 'Regresar' : (_logicaKilos == null ? 'Iniciar' : 'Agregar'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
