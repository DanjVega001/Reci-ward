import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/widgets/get_puntos_banner.dart';

class HomeBonoPage extends StatefulWidget {
  const HomeBonoPage({Key? key}) : super(key: key);

  @override
  _HomeBonoPageState createState() => _HomeBonoPageState();
}

class _HomeBonoPageState extends State<HomeBonoPage> {
  bool _showTable = false;
  List<List<String>> _tableData = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorWhite,
      appBar: AppBarReciward(),
      body: Column(
        children: [
          GetPuntosBanner(),
          SizedBox(height: 20), 
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showTable = !_showTable; 
              });
            },
            child: Text(_showTable ? '  Ocultar historial de bonos  ' : '  Mostrar historial de bonos  '),
          ),
          SizedBox(height: 10), 
          if (_showTable) ...[
            Text(
              'Historial',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 350, 
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 226, 201), 
                border: Border.all(color: const Color.fromARGB(255, 89, 94, 83)),
                borderRadius: BorderRadius.circular(10), 
              ),
              child: Table(
                border: TableBorder.all(color: Colors.transparent), 
                columnWidths: {
                  0: FixedColumnWidth(50), 
                },
                defaultColumnWidth: FixedColumnWidth(100), 
                children: _buildTableRows(), // Utiliza una función para construir las filas de la tabla
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: NavReciward(currentIndex: 2,),
    );
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [];

    // Agrega la fila de encabezado
    rows.add(
      TableRow(
        children: [
          TableCell(child: Center(child: Text('Id', style: TextStyle(fontSize: 16)))),
          TableCell(child: Center(child: Text('Codigo', style: TextStyle(fontSize: 16)))),
          TableCell(child: Center(child: Text('Estado', style: TextStyle(fontSize: 16)))),
          TableCell(child: Center(child: Text('Caduca', style: TextStyle(fontSize: 16)))),
        ],
      ),
    );

    // Agrega las filas de datos
    for (List<String> rowData in _tableData) {
      rows.add(
        TableRow(
          children: rowData.map((data) => TableCell(child: Center(child: Text(data, style: TextStyle(fontSize: 14))))).toList(),
        ),
      );
    }

    return rows;
  }

  // Función para actualizar los datos de la tabla
  void updateTableData(List<List<String>> newData) {
    setState(() {
      _tableData = newData;
    });
  }
}
