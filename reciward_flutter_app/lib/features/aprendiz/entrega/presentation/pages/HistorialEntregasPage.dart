import 'package:flutter/material.dart';

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
    List<Entrega> historialEntregas = [
      Entrega(
          id: 1,
          cantidad: 5,
          nombreMaterial: 'Material 1',
          estado: 'Entregado',
          puntos: 10),
      Entrega(
          id: 2,
          cantidad: 3,
          nombreMaterial: 'Material 2',
          estado: 'En proceso',
          puntos: 8),
    ];

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
      rows: historialEntregas.map((entrega) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text('${entrega.id}')),
            DataCell(Text('${entrega.cantidad}')),
            DataCell(Text('${entrega.nombreMaterial}')),
            DataCell(Text('${entrega.estado}')),
            DataCell(Text('${entrega.puntos}')),
          ],
        );
      }).toList(),
    );
  }
}

class Entrega {
  final int id;
  final int cantidad;
  final String nombreMaterial;
  final String estado;
  final int puntos;

  Entrega({
    required this.id,
    required this.cantidad,
    required this.nombreMaterial,
    required this.estado,
    required this.puntos,
  });
}
