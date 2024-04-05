import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/widgets/connectivity_result.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';

class HomeBonoPageCafeteria extends StatefulWidget {
  @override
  _HomeBonoPageCafeteriaState createState() => _HomeBonoPageCafeteriaState();
}

class _HomeBonoPageCafeteriaState extends State<HomeBonoPageCafeteria> {
  String valorBono = '';
  String puntosRequeridos = '';

  @override
  Widget build(BuildContext context) {

    
    Future<void> _initializeConnectivity() async {
      final connectivityResult = await MyConnectivity.getConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, "/");
      }
    }

    _initializeConnectivity();

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
                child: BlocBuilder<BonoBloc, BonoState>(
                  builder: (context, state) {
                    if (state is GetBonoSuccessState) {
                      return Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FlexColumnWidth(1), // Ancho de la primera columna
                          1: FlexColumnWidth(2), // Ancho de la segunda columna
                          2: FlexColumnWidth(
                              2), // Ancho de la tercera columna (puntos requeridos)
                          3: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Center(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.0),
                                    child: Text(
                                      'Id',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
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
                              TableCell(
                                child: Center(child: Text('Editar Bono')),
                              ),
                            ],
                          ),
                          for (var bono in state.bonos)
                            TableRow(children: [
                              TableCell(
                                child: Center(child: Text(bono.id!)),
                              ),
                              TableCell(
                                child: Center(child: Text("${bono.valorBono}")),
                              ),
                              TableCell(
                                child: Center(
                                    child: Text("${bono.puntosRequeridos}")),
                              ),
                              TableCell(
                                  child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context, "/editar-cafeteria",
                                    arguments: {
                                      "id" : bono.id,
                                      "valorBono" : bono.valorBono,
                                      "puntosRequeridos" : bono.puntosRequeridos
                                    });
                                },
                              ))
                            ]),
                        ],
                      );
                    }
                    return Center(child: Text("Cargando Bonos..."),);
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            /*ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, "/editar-cafeteria", arguments: 1);
              },
              style: ElevatedButton.styleFrom(
                  //primary: Color.fromARGB(255, 83, 177, 117),
                  //onPrimary: Colors.white,

                  ),
              child: Text('Editar bono'),
            ),*/
          ],
        ),
      ),
    );
  }
}
