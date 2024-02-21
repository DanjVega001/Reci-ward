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
                Column(
                  children: [
                    const Text(
                      'Inicio:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 60, 158, 62),
                      ),
                    ),
                    const Text(
                      'En el panel principal, observamos el menu inferior, tips de nuestra app y las opciones HOME, ENTREGAS, BONOS. ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Image.asset(
                        'assets/manual_images/inicio.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Datos personales:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 60, 158, 62),
                      ),
                    ),
                    const Text(
                      'Edita o actualiza tus datos personales.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Image.asset(
                        'assets/manual_images/datospersonales.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Entrega:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 60, 158, 62),
                      ),
                    ),
                    const Text(
                      'Suma tus puntos antes de cada entrega y acumúlalos.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Image.asset(
                        'assets/manual_images/entrega.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Historial de entrega:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 60, 158, 62),
                      ),
                    ),
                    const Text(
                      'Observa el historial de tus entregas más detalladas.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'ruta_de_la_imagen.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Canjear bonos:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(
                            255, 60, 158, 62), // Agrega el color verde aquí
                      ),
                    ),
                    const Text(
                      'Observa la cantidad de tus puntos, canjealos y reclama tu bono.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/manual_images/Canjear.png', // Ruta de la imagen
                        fit: BoxFit.cover, // Ajuste de la imagen
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Historial de bonos:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(
                            255, 60, 158, 62), // Agrega el color verde aquí
                      ),
                    ),
                    const Text(
                      'Observa el historial de tus bonos más detallados.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/manual_images/Entrega_N.png', // Ruta de la imagen
                        fit: BoxFit.cover, // Ajuste de la imagen
                      ),
                    ),
                  ],
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
