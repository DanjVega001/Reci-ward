import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';

void main() => runApp(const MaterialApp(
      home: HistorialEntregasPage(),
    ));

class HistorialEntregasPage extends StatelessWidget {
  const HistorialEntregasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Entregas')),
      body: const HistorialDataTable(),
    );
  }
}

class HistorialDataTable extends StatelessWidget {
  const HistorialDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntregaBloc, EntregaState>(
      builder: (context, state) {
        if (state is HistorialEntregaSuccess) {
          final entregas = state.entregas;
          print(entregas);
          return DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Cantidad',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Nombre Material',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Estado',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Puntos',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            columnSpacing: 10,
            rows: entregas.map((entrega) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text('${entrega.id}')),
                  DataCell(Text('${entrega.cantidadMaterial}')),
                  DataCell(Text('${entrega.nombreMaterial}')),
                  DataCell(Text('${entrega.puntosAcumulados}')),
                  DataCell(Text('${entrega.canjeada}')),
                ],
              );
            }).toList(),
          );
        }
        return Center(child: Text("Cargando..."));
      },
    );
  }
}
