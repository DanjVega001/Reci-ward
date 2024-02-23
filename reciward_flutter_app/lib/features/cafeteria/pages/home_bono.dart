import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Bonos'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/manual_images/cafff.png"), // Ruta de la imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: Color.fromRGBO(156, 245, 156, 0.5), // Color verde claro con transparencia
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
                    2: FlexColumnWidth(
                        2), // Ancho de la tercera columna (puntos requeridos)
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
                          child: Center(
                            child: BlocBuilder<BonoBloc, BonoState>(
                              builder: (context, state) {
                                if (state is GetBonoSuccessState) {
                                  for (var bono in state.bonos) {
                                    return Text("${bono.id}");
                                  }
                                }
                                return Text("No hay valor del bono");
                              },
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: BlocBuilder<BonoBloc, BonoState>(
                              builder: (context, state) {
                                if (state is GetBonoSuccessState) {
                                  for (var bono in state.bonos) {
                                    return Text("${bono.valorBono}");
                                  }
                                }
                                return Text("No hay valor del bono");
                              },
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: BlocBuilder<BonoBloc, BonoState>(
                              builder: (context, state) {
                                if (state is GetBonoSuccessState) {
                                  for (var bono in state.bonos) {
                                    return Text("${bono.puntosRequeridos} "); 
                                  }
                                }
                                return Text("No hay puntos requeridos del bono");
                              },
                            )
                          ),
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
                Navigator.pushNamed(context, "/editar-cafeteria", arguments: 1);
              },
              style: ElevatedButton.styleFrom(),
              child: Text('Editar bono'),
            ),
          ],
        ),
      ),
    );
  }
}
