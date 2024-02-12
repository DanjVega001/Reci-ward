import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber[300]),
                            alignment: Alignment.center,
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                              ),
                            ),
                          ),
                          onPressed: () {},
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
                                style: TextStyle(color: Pallete.color1),
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
