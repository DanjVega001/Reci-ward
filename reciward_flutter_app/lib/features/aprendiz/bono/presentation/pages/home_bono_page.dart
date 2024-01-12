import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/app_bar_reciward.dart';
import 'package:reciward_flutter_app/core/widgets/nav_reciward.dart';


class HomeBonoPage extends StatelessWidget {
  const HomeBonoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.colorGrey2,
      appBar: AppBarReciward(),
      body: Center(
        child: Text("Home bono page"),
      ),
      bottomNavigationBar: NavReciward(currentIndex: 2,),
    );
  }
}