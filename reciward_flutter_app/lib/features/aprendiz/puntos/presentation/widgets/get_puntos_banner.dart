import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/widgets/show_modal_bonos.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/bloc/punto_bloc.dart';

class GetPuntosBanner extends StatelessWidget {
  const GetPuntosBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuntoBloc, PuntoState>(
      builder: (context, state) {
        if (state is GetPuntosSuccessState) {
          GetPuntoDto puntos = state.getPuntoDto;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Pallete.color1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Puntos totales: ${puntos.cantidadAcumulada}',
                              style: const TextStyle(
                                  color: Pallete.colorWhite,
                                  fontSize: 21.0,
                                  fontFamily: 'Ubuntu'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Puntos usados: ${puntos.puntosUtilizados}',
                              style: const TextStyle(
                                  color: Pallete.colorWhite,
                                  fontSize: 15,
                                  fontFamily: 'Ubuntu'),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Pallete.color2),
                            alignment: Alignment.center,
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:  BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                              ),
                            ),
                          ),
                          onPressed: () {
                            String accessToken = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
                            BlocProvider.of<BonoBloc>(context).add(GetBonosEvent(accessToken: accessToken));
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ShowModalBonos();
                              },
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.payments,
                                color: Pallete.color1,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Canjear puntos",
                                style: TextStyle(
                                  color: Pallete.color1,
                                  fontFamily: 'Ubuntu',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Text("fallo");
      },
    );
  }
}
