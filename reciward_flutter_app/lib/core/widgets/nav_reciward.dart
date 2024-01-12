import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

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
        Navigator.popAndPushNamed(context, '/bono');
      }
    }

    return BottomNavigationBar(
      
      backgroundColor: Pallete.colorGrey,
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      selectedIconTheme: const IconThemeData(size: 35.0),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: Pallete.color1),
          label: 'Home',
          backgroundColor: Pallete.colorGrey
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping_outlined, color: Pallete.color1),
          backgroundColor: Pallete.colorGrey,
          label: 'Entregas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.redeem,  color: Pallete.color1),
          label: 'Bonos',
          backgroundColor: Pallete.colorGrey
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Pallete.color1,
      unselectedIconTheme: const IconThemeData(size: 30.0),
      onTap: onItemTapped,
    );
  }
}
