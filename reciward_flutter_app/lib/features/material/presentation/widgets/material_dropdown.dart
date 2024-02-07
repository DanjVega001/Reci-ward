import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/presentation/bloc/material_bloc.dart';

// ignore: must_be_immutable
class MaterialDropdown extends StatefulWidget {
  Function(String) loadMaterial;

  MaterialDropdown({super.key, required this.loadMaterial});

  @override
  State<MaterialDropdown> createState() => _MaterialDropdownState();
}

class _MaterialDropdownState extends State<MaterialDropdown> {
  String ? selectedItem;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MaterialBloc, MaterialesState>(
      builder: (context, state) {
        if (state is GetMaterialSuccess) {
          final materiales = state.materiales;
          final primerMaterial = materiales.first;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedItem  ?? '${primerMaterial.id} - ${primerMaterial.nombreMaterial} - ${primerMaterial.numeroPuntos}',
                  focusColor: Pallete.colorBlack,
                  isExpanded: true,
                  dropdownColor: Pallete.colorWhite,
                  style: const TextStyle(color: Pallete.colorBlack),
                  onChanged: (String? value) {
                    setState(() {
                      selectedItem = value!;
                    });
                  },
                  items: materiales.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value:
                          '${e.id} - ${e.nombreMaterial} - ${e.numeroPuntos}',
                      child: Text(
                        ' Nombre: ${e.nombreMaterial} // Puntos: ${e.numeroPuntos}',
                        style: const TextStyle(
                          color: Pallete.colorBlack,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              TextButton(
                onPressed: () {                  
                  widget.loadMaterial(selectedItem!);
                },
                child: Text("Agregar"),
              )
            ],
          );
        }

        return Text("");
      },
    );
  }
}
