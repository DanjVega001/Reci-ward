import 'package:flutter/material.dart';

class ManualCafe extends StatelessWidget {
  const ManualCafe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Instrucciones'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildInstruction(
              'Menu de Cafeteria:',
              'observa las opciones: BONO, VALIDAR BONO Y ENTREGA ',
              'assets/manualCafeteria/menu_principal.jpg',
            ),
            _buildInstruction(
              ' Barra de busqueda de Entrega',
              'Debe ingresar el codigo de la entrega',
              'assets/manualCafeteria/validarEntrega_blanco.jpg',
            ),
             _buildInstruction(
              'Validar Entrega',
              'Se mostrara la entregar para aceptarla',
              'assets/manualCafeteria/val_Entrega.jpg',
            ),
             _buildInstruction(
              'Barra de busqueda de Bonos',
              'Debe ingresar el codigo del Bono del aprendiz',
              'assets/manualCafeteria/validarBono_blanco.jpg',
            ),
             _buildInstruction(
              'Aceptar Bono',
              'Dar tap en aceptar bono para cajearlo',
              'assets/manualCafeteria/val_Bono.jpg',
            ),
             
            // Agrega más instrucciones y sus explicaciones aquí si es necesario
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(
    String title,
    String description,
    String imagePath,
  ) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Image.asset(
                  imagePath,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
        const Divider(), // Agrega un separador entre cada instrucción
      ],
    );
  }
}

// Esta función onPressed estará en otra página o widget donde necesites abrir el manual.
void showManual(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ManualCafe()),
  );
}
