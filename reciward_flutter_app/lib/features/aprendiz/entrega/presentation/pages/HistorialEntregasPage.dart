import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_historial_entrega.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';

class HistorialEntregasPage extends StatefulWidget {
  const HistorialEntregasPage({super.key});

  @override
  _HistorialEntregaspageState createState() => _HistorialEntregaspageState();
}

class _HistorialEntregaspageState extends State<HistorialEntregasPage> {
  List<List<String>> _tableData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Entregas',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/manual_images/arrrr.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<EntregaBloc, EntregaState>(
            builder: (context, state) {
              if (state is HistorialEntregaSuccess) {
                final entregas = state.entregas;
                return _buildTable(entregas);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTable(List<GetHistorialEntrega> entregas) {
    return Table(
      border: TableBorder.all(
          color: const Color.fromARGB(244, 168, 168, 168),
          borderRadius: BorderRadius.circular(10)),
      children: _buildTableRows(entregas),
    );
  }

  List<TableRow> _buildTableRows(List<GetHistorialEntrega> entregas) {
    List<TableRow> rows = [];
    rows.add(const TableRow(children: [
      TableCell(
        child: Center(
          child: Text(
            'Codigo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Center(
          child: Text(
            'Cantidad Material',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Center(
          child: Text(
            'Nombre Material',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Center(
          child: Text(
            'Puntos Acumulados',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Center(
          child: Text(
            'Canjeada',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]));
    for (GetHistorialEntrega entrega in entregas) {
      rows.add(TableRow(children: [
        TableCell(
          child: Center(
            child: Text(
              entrega.id!,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.cantidadMaterial.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.nombreMaterial!
                  .reduce((value, element) => '$value $element'),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.puntosAcumulados.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(
              entrega.canjeada! ? "Activo" : "Inactivo",
              style: TextStyle(
                  fontSize: 14,
                  color: entrega.canjeada! ? Colors.green : Colors.red),
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
