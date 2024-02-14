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
                  'En el panel principal, vemos el menu inferior y las opciones HOME, ENTREGAS, BONOS. ',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion1.jpg', // Ruta de la imagen
                  
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
                  'Aqui pondemos agregar o quitar la cantida de cada material que deseamos entregar y presionamos HACER ENTREGA.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion2.jpg', // Ruta de la imagen
                 
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),
                const Text(
                  'Instrucción 3:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'En esta ventana emergente se puede visualizar la cantidad total de material y los puntos totales que pondemos obtener.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  'assets/manual_images/instruccion3.jpg', // Ruta de la imagen
                   
                  fit: BoxFit.cover, // Ajuste de la imagen
                ),
                const Text(
                  'Instrucción 4:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'Aqui podemos ver  todos los puntos acumulados y la opcion de CANJEAR BONO, para redimir los puntos acumulados',
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
