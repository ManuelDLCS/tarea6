import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea6/NavBar.dart';

class Edad extends StatefulWidget {
  const Edad({Key? key}) : super(key: key);

  @override
  _EdadState createState() => _EdadState();
}

class _EdadState extends State<Edad> {
  String nombre = '';
  int? edad;
  String estado = '';

  Future<void> obtenerEdad(String nombre) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        edad = data['age'];
        if (edad! <= 18) {
          estado = 'Joven';
        } else if (edad! <= 60) {
          estado = 'Adulto';
        } else {
          estado = 'Anciano';
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Edad'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Pedrictor de Edad por el Nombre',
                style: TextStyle(fontSize: 24),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  obtenerEdad(nombre);
                },
                child: const Text('Obtener Edad'),
              ),
              const SizedBox(height: 20),
              if (edad != null)
                Column(
                  children: [
                    Text(
                      'Edad: $edad',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Estado: $estado',
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (estado == 'Joven')
                      Image.asset(
                        'assets/joven.jpg',
                        width: 500,
                        height: 500,
                      ),
                    if (estado == 'Adulto')
                      Image.asset(
                        'assets/adulto.png',
                        width: 500,
                        height: 500,
                      ),
                    if (estado == 'Anciano')
                      Image.asset(
                        'assets/anciano.jpg',
                        width: 500,
                        height: 500,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
