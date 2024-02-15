import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/pages/HistorialEntregasPage.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/material/presentation/widgets/material_dropdown.dart';

// ignore: must_be_immutable
class HomeEntregaPage extends StatefulWidget {
  const HomeEntregaPage({super.key});

  @override
  State<HomeEntregaPage> createState() => _HomeEntregaPageState();
}

class _HomeEntregaPageState extends State<HomeEntregaPage> {
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
            MaterialDropdown(),
            Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 15),
                child: AuthFormButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistorialEntregasPage()));
                    },
                    text: "Historial de Entregas"))
          ],
        )),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 1,
      ),
    );
  }
}
