import 'package:flutter/material.dart';

class EditarBonoPage extends StatefulWidget {
  @override
  _EditarBonoPageState createState() => _EditarBonoPageState();
}

class _EditarBonoPageState extends State<EditarBonoPage> {
  TextEditingController valorBonoController = TextEditingController();
  TextEditingController puntosRequeridosController = TextEditingController();

  @override
  void dispose() {
    valorBonoController.dispose();
    puntosRequeridosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Bono'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: valorBonoController,
              decoration: InputDecoration(
                labelText: 'Valor del bono',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: puntosRequeridosController,
              decoration: InputDecoration(
                labelText: 'Puntos requeridos',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmación'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deseas actualizar los cambios:'),
                          SizedBox(height: 20.0),
                          Text('Valor del bono: ${valorBonoController.text}'),
                          Text(
                              'Puntos requeridos: ${puntosRequeridosController.text}'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Actualizar los valores en la página anterior
                            Navigator.pop(context, {
                              'valorBono': valorBonoController.text,
                              'puntosRequeridos':
                                  puntosRequeridosController.text,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                          ),
                          child: Text('Confirmar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                          ),
                          child: Text('Cancelar'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 83, 177, 117),
                onPrimary: Colors.white,
              ),
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
