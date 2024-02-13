import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/bloc/punto_bloc.dart';

class NavReciward extends StatelessWidget {
  final int currentIndex;
  const NavReciward({
    super.key, required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {

    final currentRoute = ModalRoute.of(context)?.settings.name;
    void onItemTapped(int index) {
      
      if (index == 0 && currentRoute != '/home') {
        Navigator.popAndPushNamed(context, '/home');
      }

      else if (index == 1 && currentRoute != '/entrega') {
        Navigator.popAndPushNamed(context, '/entrega');
      }

      else if (index == 2 && currentRoute != '/bono') {
        String accessToken = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
        BlocProvider.of<PuntoBloc>(context).add(GetPuntosEvent(accessToken: accessToken));
        BlocProvider.of<BonoBloc>(context).add(GetHistorialBonosEvent(accessToken: accessToken));
        Navigator.popAndPushNamed(context, '/bono');
      }
    }

    return BottomNavigationBar(
      
      backgroundColor: Pallete.colorGrey2,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily:'Ubuntu',),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily:'Ubuntu',),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          backgroundColor: Pallete.colorGrey
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping_outlined,),
          backgroundColor: Pallete.colorGrey,
          label: 'Entregas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.redeem),
          label: 'Bonos',
          backgroundColor: Pallete.colorGrey
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Pallete.color1,
      unselectedItemColor: Pallete.colorBlack,
      onTap: onItemTapped,
    );
  }
}
