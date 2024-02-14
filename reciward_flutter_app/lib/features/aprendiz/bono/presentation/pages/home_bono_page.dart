import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/widgets/get_puntos_banner.dart';

class HomeBonoPage extends StatelessWidget {
  const HomeBonoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorWhite,
      appBar: AppBarReciward(),
      body: Column(
        children: [
          GetPuntosBanner(),
          SizedBox(height: 20), 
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
              color: const Color.fromARGB(255, 228, 228, 227), 
              border: Border.all(color: const Color.fromARGB(255, 127, 141, 111)), 
              borderRadius: BorderRadius.circular(10), 
            ),
            child: Table(
              border: TableBorder.all(color: Color.fromARGB(0, 169, 201, 162)), 
              columnWidths: {
                0: FixedColumnWidth(50), 
              },
              defaultColumnWidth: FixedColumnWidth(100), 
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Id', style: TextStyle(fontSize: 16))), 
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Codigo', style: TextStyle(fontSize: 16))), 
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Estado', style: TextStyle(fontSize: 16))),
                      ),
                    ), 
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Expira', style: TextStyle(fontSize: 16))),
                      ),
                    ), 
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('1', style: TextStyle(fontSize: 14))), 
                      ),
                    ), 
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('123456', style: TextStyle(fontSize: 14))), 
                      ),
                    ), 
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Activo', style: TextStyle(fontSize: 14))), 
                      ),
                    ), 
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('17/02/2024', style: TextStyle(fontSize: 14))), 
                      ),
                    ), 
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavReciward(currentIndex: 2,),
    );
  }
}
