import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tarea6/NavBar.dart';

class Genero extends StatefulWidget {
  const Genero({Key? key}) : super(key: key);

  @override
  _GeneroState createState() => _GeneroState();
}

class _GeneroState extends State<Genero> {
  String nombre = '';
  String genero = '';
  Color? color;

  Future<void> predecirGenero() async {
    var response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$nombre'));
    var data = json.decode(response.body);
    setState(() {
      genero = data['gender'];
      color = genero == 'male' ? Colors.blue : Colors.pink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Género'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ingresa un nombre:',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  predecirGenero();
                },
                child: const Text('Predecir Género'),
              ),
              const SizedBox(height: 50),
              genero.isNotEmpty
                  ? Text(
                      'El género es: $genero',
                      style: TextStyle(fontSize: 20, color: color),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
