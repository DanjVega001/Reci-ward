import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/connectivity_result.dart';
import 'package:reciward_flutter_app/core/widgets/snackbar_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class ValidarBonoPage extends StatelessWidget {
  ValidarBonoPage({Key? key});

  final TextEditingController searchController = TextEditingController();
  int idBono = 0;

  @override
  Widget build(BuildContext context) {

    
    Future<void> _initializeConnectivity() async {
      final connectivityResult = await MyConnectivity.getConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, "/");
      }
    }

    _initializeConnectivity();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Validar bono',
          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/manual_images/cafff.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: AuthFormField(
                    controller: searchController,
                    label: "Busque por el codigo del bono",
                    type: TextInputType.text,
                  )),
                  IconButton(
                    onPressed: () {
                      String accessToken = (BlocProvider.of<ProfileBloc>(context)
                              .state as UserProfileState)
                          .user!
                          .accces_token!;
                      BlocProvider.of<BonoBloc>(context).add(
                          GetBonoCafeteriaEvent(
                              accessToken: accessToken,
                              code: searchController.text.trim()));
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              BlocConsumer<BonoBloc, BonoState>(
                listener: (context, state) {
                  if (state is ValidarBonoSuccess) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(MySnackBar.showSnackBar(state.message, false));
                    Navigator.pop(context);
                  }
                  if (state is ValidarBonoFailed) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(MySnackBar.showSnackBar(state.error, true));
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is GetBonoCafeteriaSuccess) {
                    final bono = state.data;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Nombres: ${bono.nombreAprendiz} ${bono.apellidoAprendiz}",
                                style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Documento: ${bono.documento}",
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Bono",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20)),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    idBono = int.parse(state.data.id!);
                                    return Card(
                                      color: Pallete.colorWhite,
                                      elevation: 3,
                                      child: ListTile(
                                        title: Text(bono.id!,
                                            style: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Pallete.colorBlack)),
                                        subtitle: Text(
                                            "Vence ${bono.fechaVencimiento}",
                                            style: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Pallete.colorBlack)),
                                        trailing: Text(
                                            "Valor bonos ${bono.valorBono}",
                                            style: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Pallete.colorBlack)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AuthFormButton(
                                onPressed: () {
                                  String accessToken =
                                      (BlocProvider.of<ProfileBloc>(context).state
                                              as UserProfileState)
                                          .user!
                                          .accces_token!;
                                  BlocProvider.of<BonoBloc>(context).add(
                                      ValidarBonoEvent(
                                          accessToken: accessToken,
                                          idBono: idBono));
                                },
                                text: "Aceptar bono",
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text("Sin bonos"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
