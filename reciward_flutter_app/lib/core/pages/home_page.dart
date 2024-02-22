import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/presentation/bloc/tip_bloc.dart';

import '../widgets/app_bar_reciward.dart';
import '../widgets/nav_reciward.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarReciward(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/manual_images/arrrr.png"), // Ruta de tu imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Card(
                color: Color.fromARGB(255, 102, 148, 112),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Instrucciones de uso',
                        style: TextStyle(
                            color: Pallete.colorWhite,
                            fontSize: 21.0,
                            fontFamily: 'Ubuntu'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Guía de uso y recomendaciones para la aplicación',
                        style: TextStyle(
                            color: Pallete.colorWhite,
                            fontSize: 15,
                            fontFamily: 'Ubuntu'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Pallete.colorGrey2),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/manual");
                        },
                        child: const Text(
                          'Explorar',
                          style: TextStyle(
                              color: Pallete.color1,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Ubuntu'),
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
                  'CONSEJOS AMBIENTALES',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Ubuntu',
                    color: Color.fromARGB(255, 47, 161, 51), // Aquí estableces el color verde
                  ),
                ),
              ),
              BlocBuilder<TipBloc, TipState>(
                builder: (context, state) {
                  if (state is TipLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetTipSuccess) {
                    List<TipEntity> tips = state.datos;
                    return Expanded(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: tips.length,
                          itemBuilder: (context, index) {
                            TipEntity tip = tips[index];
                            return ExpansionTile(
                              children: <Widget>[
                                ListTile(title: Text(tip.descripcion!))
                              ],
                              leading: const Icon(Icons.recycling,
                                  color: Colors.green),
                              title: Text(
                                tip.nombreTips ?? "No hay titulo",
                                style:
                                    const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return const Text("Error en el servidor al cargar los tips");
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavReciward(
        currentIndex: 0,
      ),
    );
  }
}
