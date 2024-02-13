import 'package:flutter/material.dart';

class ManualUser extends StatelessWidget {
  const ManualUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Instrucciones'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Instrucción 1:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'Explicación de la instrucción 1.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion1.png', // Ruta de la imagen
                  height: 200.0, // Altura de la imagen
                  width: double.infinity, // Ancho de la imagen
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Instrucción 2:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'Explicación de la instrucción 2.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion2.png', // Ruta de la imagen
                  height: 200.0, // Altura de la imagen
                  width: double.infinity, // Ancho de la imagen
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),
                // Agrega más instrucciones y sus explicaciones aquí si es necesario
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Esta función onPressed estaría en otra página o widget donde necesites abrir el manual.
void showManual(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ManualUser()),
  );
}
