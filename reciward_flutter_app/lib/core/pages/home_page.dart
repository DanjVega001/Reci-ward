import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

import '../widgets/app_bar_reciward.dart';
import '../widgets/nav_reciward.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> items = [
    Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: const Text(
          'Tip 1: Este es el titulo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          'Tip 1: Esta es la descripcion del tip...'
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_sharp),
        ),
      ),
    ), 
    Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: const Text(
          'Tip 2: Este es el titulo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          'Tip 2: Esta es la descripcion del tip...'
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_sharp),
        ),
      ),
    ),
    Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: const Text(
          'Tip 3: Este es el titulo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          'Tip 3: Esta es la descripcion del tip...'
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_sharp),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorGrey2,
      appBar: const  AppBarReciward(),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Card( 
              color: Pallete.color1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Instrucciones de uso',
                      style: TextStyle(
                        color: Pallete.colorWhite,
                        fontSize: 21.0
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text(
                      'Guía de uso y recomendaciones para la aplicación',
                      style: TextStyle(
                        color: Pallete.colorWhite,
                        fontSize: 15, 
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Pallete.colorGrey2),
                      ),
                      onPressed: () {
                            
                      },
                      child: const Text(
                        'Explorar',
                        style: TextStyle(
                          color: Pallete.color1,
                          fontSize: 15,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Consejos ambientales: Sé parte de la solución',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            
               Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return items[index];
                    },
                  ),
                ),
              ),
            
          ],
        ),
      ),
      bottomNavigationBar: const NavReciward(currentIndex: 0,),
    );
  }
}
