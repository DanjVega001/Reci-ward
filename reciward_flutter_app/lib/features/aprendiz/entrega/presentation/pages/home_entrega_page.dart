import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/pages/HistorialEntregasPage.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/material/presentation/widgets/material_dropdown.dart';

class HomeEntregaPage extends StatefulWidget {
  const HomeEntregaPage({Key? key}) : super(key: key);

  @override
  State<HomeEntregaPage> createState() => _HomeEntregaPageState();
}

class _HomeEntregaPageState extends State<HomeEntregaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarReciward(),
      body: Container(
        constraints: BoxConstraints
            .expand(), // Para que ocupe todo el espacio disponible
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/manual_images/arrrr.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(), // Evita el desplazamiento
            child: Column(
              children: [
                MaterialDropdown(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 15,
                  ),
                  child: AuthFormButton(
                    onPressed: () {
                      String accessToken =
                          (BlocProvider.of<ProfileBloc>(context).state
                                  as UserProfileState)
                              .user!
                              .accces_token!;
                      BlocProvider.of<EntregaBloc>(context)
                          .add(HistorialEntrega(accessToken: accessToken));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistorialEntregasPage(),
                        ),
                      );
                    },
                    text: "Historial de Entregas",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 1,
      ),
    );
  }
}
