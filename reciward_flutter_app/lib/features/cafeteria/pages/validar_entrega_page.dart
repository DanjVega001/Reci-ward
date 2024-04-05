import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/connectivity_result.dart';
import 'package:reciward_flutter_app/core/widgets/snackbar_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/entrega_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_material_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class ValidarEntregaPage extends StatelessWidget {
  ValidarEntregaPage({Key? key});

  final TextEditingController searchController = TextEditingController();
  int idEntrega = 0;

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
          'Validar entrega',
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
                    label: "Busque por codigo de entrega",
                    type: TextInputType.number,
                  )),
                  IconButton(
                    onPressed: () {
                      String accessToken = (BlocProvider.of<ProfileBloc>(context)
                              .state as UserProfileState)
                          .user!
                          .accces_token!;
                      BlocProvider.of<EntregaBloc>(context).add(
                          GetEntregaCafeteriaEvent(
                              accessToken: accessToken,
                              idEntrega:
                                  int.parse(searchController.text.trim())));
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              BlocConsumer<EntregaBloc, EntregaState>(
                listener: (context, state) {
                  if (state is ValidarEntregaFailed) {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(MySnackBar.showSnackBar(state.error, true));
                    Navigator.pop(context);
                  }
                  if (state is ValidarEntregaSuccess) {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(MySnackBar.showSnackBar(state.message, false));
                    Navigator.pop(context);
                    
                  }
                },
                builder: (context, state) {
                  if (state is GetEntregaCafeteriaSuccess) {
                    final data = state.data;
                    EntregaEntity entrega = data.entrega!;
                    idEntrega = int.parse(entrega.id!);
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
                              Text("Cod Entrega: ${entrega.id}",
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Nombres: ${data.nombre} ${data.apellido}",
                                style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Documento: ${data.documento}",
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Cantidad total: ${entrega.cantidadMaterial}",
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Puntos totales: ${entrega.puntosAcumulados}",
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Materiales",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20)),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: entrega.materiales!.length,
                                  itemBuilder: (context, index) {
                                    GetEntregaMaterialEntity material =
                                        data.entrega!.materiales![index];
                                    return Card(
                                      color: Pallete.colorWhite,
                                      elevation: 3,
                                      child: ListTile(
                                        title: Text(material.nombreMaterial!,
                                            style: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Pallete.colorBlack)),
                                        subtitle: Text(
                                            "Puntos ${material.numeroPuntos}",
                                            style: const TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Pallete.colorBlack)),
                                        trailing: Text(
                                            "Cant ${material.numeroMaterial}",
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
                                  String accessToken = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
                                  BlocProvider.of<EntregaBloc>(context).add(ValidarEntregaEvent(accessToken: accessToken, idEntrega: idEntrega));
                                },
                                text: "Aceptar entrega",
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(child: Text("Sin datos", style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w600),));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
