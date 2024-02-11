import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/widgets/modal_resumen_entrega.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/presentation/bloc/material_bloc.dart';

// ignore: must_be_immutable
class MaterialDropdown extends StatefulWidget {
  MaterialDropdown({super.key});

  @override
  State<MaterialDropdown> createState() => _MaterialDropdownState();
}

class _MaterialDropdownState extends State<MaterialDropdown> {
  List<Map<String, String>> materialesList = [];
  Map<String, int> contadores = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialBloc, MaterialesState>(
      builder: (context, state) {
        if (state is GetMaterialSuccess) {
          final materiales = state.materiales;

          if (materialesList.length != materiales.length) {
            for (var i = 0; i < materiales.length; i++) {
              MaterialEntity material = materiales[i];
              String id = material.id!;
              contadores.putIfAbsent(id, () => 0);
              Map<String, String> materialMap = {
                "id": material.id!,
                "nombre": material.nombreMaterial!,
                "puntos": "${material.numeroPuntos!}",
                "cantidad": "${contadores[material.id!]}"
              };

              materialesList.add(materialMap);
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: materiales.length,
                itemBuilder: (context, index) {
                  MaterialEntity material = materiales[index];
                  String id = material.id!;

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
                                "${material.nombreMaterial} Puntos: ${material.numeroPuntos}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (contadores[id]! > 0) {
                                      contadores[id] = contadores[id]! - 1;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    contadores[id] = contadores[id]! + 1;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Cantidad: ${contadores[id]}',
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
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: AuthFormButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < materialesList.length; i++) {
                        Map<String, String> map = materialesList[i];
                        map["cantidad"] = "${contadores[map["id"]]}";
                      }
                    });

                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ModalResumenEntrega(
                            materiales: materialesList,
                          );
                        });
                  },
                  text: "Hacer entrega",
                ),
              ),
            ],
          );
        }

        return Text("");
      },
    );
  }
}
