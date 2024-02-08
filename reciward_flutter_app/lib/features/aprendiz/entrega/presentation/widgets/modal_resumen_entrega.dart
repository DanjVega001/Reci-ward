import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

class ModalResumenEntrega extends StatelessWidget {
  final List<String> materiales;

  const ModalResumenEntrega({super.key, required this.materiales});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Resumen de entrega',
              style: TextStyle(color: Pallete.colorBlack, fontFamily: 'Ubuntu'),
            ),
            ListView.builder(
              itemCount: materiales.length,
              itemBuilder: (BuildContext context, int index) {
                List<String> material = materiales[index].split(' - ');

                return Card(
                  child: ListTile(
                    title: Text(
                      material[0],
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                    subtitle: Text(
                      material[1],
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                    leading: Text(
                      "Puntos=${material[2]}",
                      style: const TextStyle(fontFamily: 'Ubuntu'),
                    ),
                  ),
                );
              },
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check),
              label: const Text(
                "Confirmar entrega",
                style: TextStyle(fontFamily: 'Ubuntu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
