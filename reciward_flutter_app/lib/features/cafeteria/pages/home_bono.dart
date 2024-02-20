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
              onPressed: () {
                Navigator.pushNamed(context, "/editar-cafeteria");
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
