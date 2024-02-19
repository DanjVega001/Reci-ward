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
                  'Inicio:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'En el panel principal, observamos el menu inferior, tips de nuestra app y las opciones HOME, ENTREGAS, BONOS. ',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion1.jpg', // Ruta de la imagen
                  
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),
                const SizedBox(height: 20.0),


                const Text(
                  'Datos personales:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'Edita o actualiza tus datos personales.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion2.jpg', // Ruta de la imagen
                 
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),


                const Text(
                  'Entrega:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'Suma tus puntos antes de cada entrega y acumulalos.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion3.jpg', // Ruta de la imagen
                   
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),


                const Text(
                  'Historial de entrega:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'Observa el historial de tus entregas más detalladas.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion4.jpg', // Ruta de la imagen
                  
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),


                  const Text(
                  'Canjear bonos:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'Observa la cantidad de tus puntos, canjealos y reclama tu bono.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion4.jpg', // Ruta de la imagen
                  
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),


                  const Text(
                  'Historial de bonos:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Color.fromARGB(255, 60, 109, 61), // Agrega el color verde aquí
                  ),
                ),
                const Text(
                  'Obeserva el historial de tus bonos más detallados.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion4.jpg', // Ruta de la imagen
                  
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
