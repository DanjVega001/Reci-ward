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
          child: MaterialDropdown()
         
        ),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 1,
      ),
    );
  }
}
