import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/entrega_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_material_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class ValidarEntregaPage extends StatelessWidget {
  ValidarEntregaPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Validar entrega',
          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
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
                
              },
              builder: (context, state) {
                if (state is GetEntregaCafeteriaSuccess) {
                  final data = state.data;
                  EntregaEntity entrega = data.entrega!;
        
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Nombres:${data.nombre} ${data.apellido}"),
                      Text("Documento:${data.documento}"),
                      Text("Cod Entrega:${entrega.id}"),
                      Text("Cantidad total:${entrega.cantidadMaterial}"),
                      Text("Puntos totales:${entrega.puntosAcumulados}"),
                      Expanded(
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: entrega.materiales!.length,
                            itemBuilder: (context, index) {
                              GetEntregaMaterialEntity material = data.entrega!.materiales![index];
                              return ListTile(
                                title: Text(material.nombreMaterial!),
                                //subtitle: Text("${material.numeroPuntos}"),
                                //trailing: Text("Cant:${material.numeroMaterial}"),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Text("Sin datos");
              },
            )
          ],
        ),
      ),
    );
  }
}
