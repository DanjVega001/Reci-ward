import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/snackbar_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/bloc/punto_bloc.dart';

enum BonosEnum {bono_1, bono_2}


class ShowModalBonos extends StatefulWidget {
  const ShowModalBonos({super.key});

  @override
  State<ShowModalBonos> createState() => _ShowModalBonosState();
}


class _ShowModalBonosState extends State<ShowModalBonos> {
  int selectedValueId = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BonoBloc, BonoState>(
      listener: (context, state) {
        if (state is SaveBonoAprendizFailed) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
            .showSnackBar(MySnackBar.showSnackBar(state.error, true));
        }

        if (state is SaveBonoAprendizSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
            .showSnackBar(MySnackBar.showSnackBar(state.message, false));
          BlocProvider.of<PuntoBloc>(context).add(GetPuntosEvent(accessToken: state.accessToken));

        }
      },
      builder: (context, state) {
        if (state is GetBonosLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetBonoFailedState) {
          return Center(child: Text(state.error));
        }

        if (state is GetBonoSuccessState) {
          List<BonoEntity> bonos = state.bonos;

          return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const Text(
                'Elija el bono',
                style: TextStyle(
                    color: Pallete.colorBlack,
                    fontFamily: 'Ubuntu',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder( 
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: bonos.length,
                itemBuilder: (context, index) {

                  BonoEntity bono = bonos[index];

                  return Card(
                    child: RadioListTile(
                      value: int.parse(bono.id!),
                      groupValue: selectedValueId,
                      onChanged: (value) {
                        setState(() {
                          selectedValueId = value!;
                        });
                      },
                      title: Text("Valor bono: ${bono.valorBono}"),
                      subtitle: Text("Puntos requeridos: ${bono.puntosRequeridos}"),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      String accessToken = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
                      BlocProvider.of<BonoBloc>(context).add(SaveBonoAprendizEvent(bonoId: selectedValueId, accessToken: accessToken));
                      BlocProvider.of<BonoBloc>(context).add(GetHistorialBonosEvent(accessToken: accessToken));
                    },
                    icon: const Icon(Icons.check, color: Pallete.colorWhite),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Pallete.color1),
                    ),
                    label: const Text(
                      "Confirmar",
                      style: TextStyle(
                          fontFamily: 'Ubuntu', color: Pallete.colorWhite),
                    ),
                  ),
                  
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      String accessToken = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
                      BlocProvider.of<BonoBloc>(context).add(GetHistorialBonosEvent(accessToken: accessToken));
                    },
                    icon: const Icon(Icons.close, color: Pallete.colorWhite),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 177, 83, 83)),
                    ),
                    label: const Text(
                      "Cancelar",
                      style: TextStyle(
                          fontFamily: 'Ubuntu', color: Pallete.colorWhite),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        }

        return const Center(child: Text("ERROR!!"),);

    
      },
    );
  }
}
