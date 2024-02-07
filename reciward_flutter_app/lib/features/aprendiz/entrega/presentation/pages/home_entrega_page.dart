import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/material/presentation/widgets/material_dropdown.dart';

// ignore: must_be_immutable
class HomeEntregaPage extends StatefulWidget {

  HomeEntregaPage({super.key});

  @override
  State<HomeEntregaPage> createState() => _HomeEntregaPageState();
}

class _HomeEntregaPageState extends State<HomeEntregaPage> {
  List<String> materiales = [];
  Map<String, int> contadores = {};

  void loadMaterial(String material) {
    setState(() {
      String id = material.substring(0,1);
      contadores[id] = 0;
      if (materiales.isEmpty) {
        materiales.add(material);
      }
      for (var i = 0; i < materiales.length; i++) {
        if (materiales[i].startsWith(id, 0)) {
          print("existe");
        } else {
          print("no existe");
          materiales.add(material);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorWhite,
      appBar: const AppBarReciward(),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Text(
              "Realizar una entrega",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 19,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialDropdown(
              loadMaterial: loadMaterial,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: materiales.length,
                itemBuilder: (context, index) {
                  String material = materiales[index];
                  String id = material.substring(0,1);
                  return ListTile(
                    title: Text(
                      material,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 1,
      ),
    );
  }
}
