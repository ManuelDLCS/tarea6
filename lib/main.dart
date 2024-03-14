import 'package:flutter/material.dart';
import 'package:tarea6/NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6 (Couteau)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToolboxHomePage(),
    );
  }
}

class ToolboxHomePage extends StatelessWidget {
  const ToolboxHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarea 6'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/herramientas.jpg',
              width: 600,
              height: 600,
            ),
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Text('Ir a herramientas'),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
