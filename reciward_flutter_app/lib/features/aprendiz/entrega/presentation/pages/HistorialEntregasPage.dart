import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_historial_entrega.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';

class HistorialEntregasPage extends StatefulWidget {
  const HistorialEntregasPage({Key? key}) : super(key: key);

  @override
  _HistorialEntregaspage createState() => _HistorialEntregaspage();
}

class _HistorialEntregaspage extends State<HistorialEntregasPage> {
  List<List<String>> _tableData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Entregas')),
      body: BlocBuilder<EntregaBloc, EntregaState>(
        builder: (context, state) {
          if (state is HistorialEntregaSuccess) {
            final entregas = state.entregas;
            return Table(
              border: TableBorder.all(color: Colors.transparent),
              children: _buildTableRows(entregas),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<TableRow> _buildTableRows(List<GetHistorialEntrega> entregas) {
    List<TableRow> rows = [];
    rows.add(const TableRow(children: [
      TableCell(child: Center(child: Text('Codigo'))),
      TableCell(child: Center(child: Text('Cantidad Material'))),
      TableCell(child: Center(child: Text('Nombre Material'))),
      TableCell(child: Center(child: Text('Puntos Acumulados'))),
      TableCell(child: Center(child: Text('Canjeada'))),
    ]));
    for (GetHistorialEntrega entrega in entregas) {
      rows.add(TableRow(children: [
        TableCell(
          child: Center(
            child: Text(
              entrega.id!,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.cantidadMaterial.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.nombreMaterial![0],
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.puntosAcumulados.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.canjeada! ? "Activo" : "Inactivo",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ]));
    }
    return rows;
  }

  void updateTableData(List<List<String>> newData) {
    setState(() {
      _tableData = newData;
    });
  }
}
