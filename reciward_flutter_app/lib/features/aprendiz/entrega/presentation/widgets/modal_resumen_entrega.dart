import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';


class ModalResumenEntrega extends StatelessWidget {
  final List<Map<String, String>> materiales;
  late List<int> puntosTotalesLista = [];

  ModalResumenEntrega(
      {super.key, required this.materiales});

  void cargarPuntos() {
    print(materiales);
    for (var i = 0; i < materiales.length; i++) {
      Map<String, String> material = materiales[i];
      int puntosTotales = int.parse(material['puntos']!) * int.parse(material['cantidad']!);
      puntosTotalesLista.add(puntosTotales);
    }
  }

  @override
  Widget build(BuildContext context) {

    cargarPuntos();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const Text(
            'Resumen de entrega',
            style: TextStyle(
                color: Pallete.colorBlack,
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            itemCount: materiales.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Map<String, String> material = materiales[index];
            
              int puntosTotales = int.parse(material['puntos']!) * int.parse(material['cantidad']!);
             
              return Card(
                child: ListTile(
                  title: Text(
                    "Cantidad: ${material['cantidad']}",
                    style: const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                  subtitle: Text(
                    "${material['nombre']}",
                    style: const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                  leading: Text(
                    "Puntos=$puntosTotales",
                    style: const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Puntos totales = ${puntosTotalesLista.reduce((value, element) => value + element)}",
            style: const TextStyle(
              fontFamily: 'Ubunutu',
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check, color: Pallete.colorWhite),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Pallete.color1),
                ),
                label: const Text(
                  "Confirmar entrega",
                  style: TextStyle(
                      fontFamily: 'Ubuntu', color: Pallete.colorWhite),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: Pallete.colorWhite),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 177, 83, 83)),
                ),
                label: const Text(
                  "Cancelar entrega",
                  style: TextStyle(
                      fontFamily: 'Ubuntu', color: Pallete.colorWhite),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
