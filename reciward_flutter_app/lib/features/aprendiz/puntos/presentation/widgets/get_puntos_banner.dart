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
          return Container(
            color: Pallete.color1,
            padding: const EdgeInsets.all(13),
            child: Text("${puntos.cantidadAcumulada}"));
        }
        return Text("fallo");
      },
    );
  }
}
