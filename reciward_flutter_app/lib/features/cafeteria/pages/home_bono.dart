import 'package:flutter/material.dart';

class HomeBonoPageCafeteria extends StatefulWidget {
  @override
  _HomeBonoPageCafeteriaState createState() => _HomeBonoPageCafeteriaState();
}

class _HomeBonoPageCafeteriaState extends State<HomeBonoPageCafeteria> {
  String valorBono = '';
  String puntosRequeridos = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Bonos'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: Color.fromRGBO(156, 245, 156, 1), // Color verde claro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(1), // Ancho de la primera columna
                    1: FlexColumnWidth(2), // Ancho de la segunda columna
                    2: FlexColumnWidth(2), // Ancho de la tercera columna (puntos requeridos)
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6.0),
                              child: Text(
                                'Id',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(child: Text('Valor del bono')),
                        ),
                        TableCell(
                          child: Center(child: Text('Puntos requeridos')),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text('1')),
                        ),
                        TableCell(
                          child: Center(child: Text(valorBono)),
                        ),
                        TableCell(
                          child: Center(child: Text(puntosRequeridos)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, "/editar-cafeteria");
                if (result != null && result is Map<String, String>) {
                  setState(() {
                    valorBono = result['valorBono']!;
                    puntosRequeridos = result['puntosRequeridos']!;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 83, 177, 117),
                onPrimary: Colors.white,
              ),
              child: Text('Editar bono'),
            ),
          ],
        ),
      ),
    );
  }
}
