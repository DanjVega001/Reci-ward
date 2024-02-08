import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/widgets/modal_resumen_entrega.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/material/presentation/widgets/material_dropdown.dart';

// ignore: must_be_immutable
class HomeEntregaPage extends StatefulWidget {
  const HomeEntregaPage({super.key});

  @override
  State<HomeEntregaPage> createState() => _HomeEntregaPageState();
}

class _HomeEntregaPageState extends State<HomeEntregaPage> {
  List<String> materiales = [];
  Map<String, int> contadores = {};

  void loadMaterial(String material) {
    setState(() {
      String id = material.split(' - ')[0];
      contadores.putIfAbsent(id, () => 0);

      if (!materiales.any((element) => element.startsWith(id))) {
        materiales.add(material);
      }
      contadores[id] = contadores[id]! + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorWhite,
      appBar: const AppBarReciward(),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Realizar una entrega",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialDropdown(
                loadMaterial: loadMaterial,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: materiales.length,
                itemBuilder: (context, index) {
                  String material = materiales[index];
                  String id = material.split(' - ')[0];
                  int contador = contadores[id] ?? 0;
                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                material,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (contadores[id] != null &&
                                        contadores[id]! > 0) {
                                      contadores[id] = contadores[id]! - 1;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Contador: $contador',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AuthFormButton(
                onPressed: () {
                  /*showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ModalResumenEntrega(
                          materiales: materiales,
                        );
                      });*/
                  print(materiales);
                },
                text: "Hacer entrega",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 1,
      ),
    );
  }
}
